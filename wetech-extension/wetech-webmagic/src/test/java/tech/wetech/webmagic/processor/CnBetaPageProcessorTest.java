package tech.wetech.webmagic.processor;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;

public class CnBetaPageProcessorTest implements PageProcessor {

	private Site site = Site.me().setRetryTimes(3).setSleepTime(0);	
	
	@Override
	public void process(Page page) {
		
		page.addTargetRequests(page.getHtml().links().regex("http://www.cnbeta.com/articles/\\w+\\w+").all());
//		page.getUrl().regex("https://github\\.com/(\\w+)/.*").toString();
		String id = page.getUrl().regex("http://www.cnbeta.com/articles/(\\w+)").toString();
		System.out.println(id);
		String url = page.getHtml().links().regex("http://www.cnbeta.com/articles/\\w+\\w+").get();
		System.out.println(url);
		String newsTitle = page.getHtml().xpath("//h2[@id='news_title']/text()").toString();
		System.out.println(newsTitle);
		String introduction = page.getHtml().xpath("//div[@class='introduction']/p/text()").toString();
		System.out.println(introduction);
		String content = page.getHtml().xpath("//div[@class='content']").toString();
		System.out.println(content);
		String date = page.getHtml().xpath("//span[@class='date']/text()").toString();
		System.out.println(date);
		String where = page.getHtml().xpath("//span[@class='where']").toString();
		System.out.println(where);
		String author = page.getHtml().xpath("//span[@class='author']/text()").toString();
		if(author != null)
		System.out.println(author.substring(6 , author.length()-1));
	}
	@Override
	public Site getSite() {
		return site;
	}
	
	public static void main(String[] args) {
		Spider.create(new CnBetaPageProcessorTest()).addUrl("http://www.cnbeta.com").thread(5).run();
	}

}
