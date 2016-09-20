package org.wetech.wordpress.xmlrpc;

import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import org.apache.xmlrpc.client.XmlRpcClient;
import org.apache.xmlrpc.client.XmlRpcClientConfigImpl;

public class XMLRPCMetaWebDemo {

	public static void main(String[] args) {
		String title = "XML-RPC发布测试222222";
		String content = "CONTENT测试测试21212121";
		post(title, content);
	}

	public static void post(String title, String content) {
		try {
			// Set up XML-RPC connection to server
			String domain = "wetech.tech";// 你网站的域名
			XmlRpcClientConfigImpl config = new XmlRpcClientConfigImpl();
			config.setServerURL(new URL("http://" + domain + "/xmlrpc.php"));
			XmlRpcClient client = new XmlRpcClient();
			client.setConfig(config);

			// Set up parameters required by newPost method
			Map post = new HashMap();
			post.put("title", title);// 标题
			post.put("mt_keywords", "标签,标签2,标签3");// 标签
			Object[] categories = new Object[] { "服饰", "数码" };// 分类
			post.put("categories", categories);
			post.put("description", content);// 内容
			Object[] params = new Object[] { "1", "robot", "cjb646114497", post, Boolean.TRUE };

			// Call newPost
			String result = (String) client.execute("metaWeblog.newPost", params);
			System.out.println(" Created with blogid " + result);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			System.out.println(" UnCreated ");
		}
	}
}