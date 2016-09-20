package tech.wetech.wordpress;

import org.apache.xmlrpc.XmlRpcException;
import org.apache.xmlrpc.client.XmlRpcClient;
import org.apache.xmlrpc.client.XmlRpcClientConfigImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by: Matthew Smalley
 * Date: 28/12/2015
 */
public class WordPressRpcClient {
    private final static Logger LOGGER = LoggerFactory.getLogger(WordPressRpcClient.class);

    private String username;
    private String password;
    private URL xmlrpcUrl;
    private boolean loggedIn = false;
    private XmlRpcClient client;
    private Map<String, Post> posts;
    private Set<String> categories = new HashSet<>();

    protected void setClient(XmlRpcClient client) {
        this.client = client;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setXmlrpcUrl(String xmlrpcUrl) {
        try {
            this.xmlrpcUrl = new URL(xmlrpcUrl);
        } catch (MalformedURLException e) {
            LOGGER.error("Malformed URL: {}", xmlrpcUrl, e);
            throw new RuntimeException("Malformed URL: " + xmlrpcUrl, e);
        }
    }

    public synchronized void checkLoggedIn() {
        if (!loggedIn) {
            verifyEndpoint();
            loggedIn = true;
        }
    }

    private void verifyEndpoint() {
        try {
            XmlRpcClientConfigImpl config = new XmlRpcClientConfigImpl();
            config.setServerURL(xmlrpcUrl);

            client = new XmlRpcClient();
            client.setConfig(config);

            Object[] results = (Object[]) sendRequest("wp.getPosts", Collections.singletonList(Collections.singletonMap("number", 1)));
            if (results == null) {
                throw new RuntimeException("Error logging in (no results returned)");
            }
        } catch (Exception e) {
            LOGGER.error("Error verifying login details: {}", e.getMessage(), e);
            throw new RuntimeException("Error verifying login details: " + e.getMessage(), e);
        }
    }

    private List<Object> prepareParameters(List<Object> params) {
        List<Object> sendParams = new ArrayList<>();
        sendParams.add(0);
        sendParams.add(username);
        sendParams.add(password);
        if (params != null) {
            sendParams.addAll(params);
        }
        return sendParams;
    }

    Object sendRequest(String methodName, List<Object> params) {
        try {
            return client.execute(methodName, prepareParameters(params));
        } catch (XmlRpcException e) {
            LOGGER.error("Error sending request: {}", e.getMessage(), e);
            throw new RuntimeException("Error sending request: " + e.getMessage(), e);
        }
    }

    public void retrievePosts() {
        checkLoggedIn();
        if (posts == null) {
            posts = new HashMap<>();
            Object[] postsObject = (Object[]) sendRequest("wp.getPosts", Collections.singletonList(new Object[]{"post_id", "post_title", "terms"}));
            for (Object p : postsObject) {
                if (p instanceof Map) {
                    Map postMap = (Map) p;
                    Post post = new Post();
                    post.setPostId((String) postMap.get("post_id"));
                    post.setPostTitle((String) postMap.get("post_title"));
                    Object[] terms = (Object[]) postMap.get("terms");
                    for (Object obj : terms) {
                        if (obj instanceof Map) {
                            Map term = (Map) obj;
                            if ("category".equals(term.get("taxonomy"))) {
                                post.getCategories().add((String) term.get("name"));
                            }
                        }
                    }
                    posts.put(post.getPostTitle(), post);
                }
            }
        }
    }

    public Post addPost(Post p) {
        checkLoggedIn();

        retrievePosts();
        Post post;
        if (posts.containsKey(p.getPostTitle())) {
            post = posts.get(p.getPostTitle());
            post.merge(p);
        } else {
            posts.put(p.getPostTitle(), p);
            post = p;
        }

        boolean edit = false;
        Map<String, Object> params = new HashMap<>();
        if (post.getPostId() != null) {
            LOGGER.debug("Post exists, so updating rather than creating (post id is: {})", post.getPostId());
            edit = true;
        }
        params.put("post_type", "post");
        params.put("post_status", "publish");
        params.put("comment_status", "open");
        params.put("post_title", post.getPostTitle());
        if (post.getContents() != null) {
            params.put("post_content", post.getContents());
        }
        if(post.getPostExcerpt() != null) {
        	params.put("post_excerpt", post.getPostExcerpt());
        }
        params.put("terms_names", Collections.singletonMap("category", post.getCategories()));

        Object returnObj;

        if (edit) {
            returnObj = sendRequest("wp.editPost", Arrays.asList(new Object[]{post.getPostId(), params}));
        } else {
            returnObj = sendRequest("wp.newPost", Collections.singletonList(params));
            if (returnObj instanceof String) {
                post.setPostId((String) returnObj);
            }
        }
        return post;

    }

    public Set<String> getCategories() {
        retrieveCategories();
        return categories;
    }

    public Map<String, Post> getPosts() {
        retrievePosts();
        return posts;
    }

    public void retrieveCategories() {
        checkLoggedIn();

        Object o = sendRequest("wp.getTerms", Collections.singletonList("category"));

        if (o instanceof Object[]) {
            for (Object mapObj : (Object[]) o) {
                Map map = (Map) mapObj;
                if (map.containsKey("name")) {
                    categories.add((String) map.get("name"));
                }
            }
        }
    }

    public void uploadImage(String imageName, byte[] bytes, String postId) {
        checkLoggedIn();
        String mimeType;
        if (imageName.toUpperCase().endsWith("JPG") || imageName.toUpperCase().endsWith("JPEG")) {
            mimeType = "image/jpeg";
        } else {
            throw new RuntimeException("Unknown mime type for file:" + imageName);
        }

        Map<String, Object> params = new HashMap<>();
        params.put("name", imageName);
        params.put("type", mimeType);
        params.put("bits", bytes);
        params.put("overwrite", Boolean.TRUE);
        params.put("post_id", postId);

        Object o = sendRequest("wp.uploadFile", Collections.singletonList(params));
        System.out.println(o);

    }
}
