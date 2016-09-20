package tech.wetech.wordpress;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by: Matthew Smalley
 * Date: 28/12/2015
 */
public class Post {
    private String postTitle;
    private String postId;
    private List<String> categories = new ArrayList<>();
    private String contents;
    private String postExcerpt;

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public List<String> getCategories() {
        return categories;
    }

    public void setCategories(List<String> categories) {
        this.categories = categories;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getPostExcerpt() {
    	return postExcerpt;
    }
    
    public void setPostExcerpt(String postExcerpt) {
    	this.postExcerpt = postExcerpt;
    }
    
    public void merge(Post p) {
        if (p.getContents() != null) {
            this.setContents(p.getContents());
        }
        if (p.getPostTitle() != null) {
            this.setPostTitle(p.getPostTitle());
        }
        if (p.getCategories() != null && p.getCategories().size() > 0) {
            this.setCategories(p.getCategories());
        }
        if (p.getPostId() != null) {
            this.setPostId(p.getPostId());
        }
        if(p.getPostExcerpt() != null) {
        	this.setPostExcerpt(p.getPostId());
        }
    }

	@Override
	public String toString() {
		return "Post [postTitle=" + postTitle + ", postId=" + postId + ", categories=" + categories + ", contents="
				+ contents + ", postExcerpt=" + postExcerpt + "]";
	}

}
