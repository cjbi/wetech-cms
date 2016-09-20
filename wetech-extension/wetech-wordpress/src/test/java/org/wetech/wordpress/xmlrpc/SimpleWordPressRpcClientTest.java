package org.wetech.wordpress.xmlrpc;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.junit.Test;

import tech.wetech.wordpress.SimpleWordPressRpcClient;

public class SimpleWordPressRpcClientTest {
	
	@Test
	public void testNewPost() {
		Set<String> categories = new HashSet<String>();
		categories.add("技术教程");
		categories.add("站点工程");
		SimpleWordPressRpcClient.addPost("测试标题11", "测试标题22", "测试摘要222222", categories);
	}
	
	@Test
	public void testSendRequest() {
		Map<String, Object> params = new HashMap<>();
		params.put("post_title", "测试标题123456");
		params.put("post_excerpt", "测试摘取123456");
		params.put("post_content", "测试内容123456");
		List<String> categories = new ArrayList<>();
		categories.add("cnBeta");
		params.put("terms_names", Collections.singletonMap("category", categories));
		System.out.println(SimpleWordPressRpcClient.sendRequest("wp.newPost", params));
	}
}
