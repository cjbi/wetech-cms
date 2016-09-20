package tech.wetech.wordpress;

import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author cjb
 */
public class SimpleWordPressRpcClient {
	
	private final static Logger LOGGER = LoggerFactory.getLogger(SimpleWordPressRpcClient.class);
	
	private static WordPressRpcClient client;

	private static void initClient() {
		client = new WordPressRpcClient();
		client.setUsername("robot");
		client.setPassword("123456");
		client.setXmlrpcUrl("http://wetech.tech/xmlrpc.php");
	}

	/**
	 * send new request
	 * 
	 * @param methodName
	 * @param params
	 * @return
	 */
	public static Object sendRequest(String methodName, Map<String, Object> params) {
		
		return sendRequest(methodName, null, params);
	}

	/**
	 * send edit request
	 * 
	 * @param methodName
	 * @param postId
	 * @param params
	 * @return
	 */
	public static Object sendRequest(String methodName, String postId, Map<String, Object> params) {
		initClient();
		client.checkLoggedIn();
		client.retrievePosts();
		params.put("post_type", "post");
		params.put("post_status", "publish");
		params.put("comment_status", "open");
		LOGGER.info("正在通过xmlrpc发布文章："+params.get("post_title"));
		if (postId != null) {
			return client.sendRequest(methodName, Collections.singletonList(new Object[] { postId, params }));
		} else
			return client.sendRequest(methodName, Collections.singletonList(params));
	}

	public static void addPost(String postTitle, String contents) {

		addPost(postTitle, contents, null);
	}

	public static void addPost(String postTitle, String contents, Set<String> categories) {

		addPost(postTitle, contents, null, categories);
	}

	public static void addPost(String postTitle, String contents, String postExcerpt, Set<String> categories) {
		Post post = new Post();

		post.setPostTitle(postTitle);
		post.setContents(contents);

		if (postExcerpt != null) {
			post.setPostExcerpt(postExcerpt);
		}
		if (categories != null) {
			for (String categorie : categories) {
				post.getCategories().add(categorie);
			}
		}
		initClient();
		LOGGER.info(client.addPost(post).toString());
	}

}
