package tech.wetech.webmagic.model;

import java.util.Date;

import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.model.ConsolePageModelPipeline;
import us.codecraft.webmagic.model.OOSpider;
import us.codecraft.webmagic.model.annotation.ExtractBy;
import us.codecraft.webmagic.model.annotation.ExtractByUrl;
import us.codecraft.webmagic.model.annotation.Formatter;
import us.codecraft.webmagic.model.annotation.HelpUrl;
import us.codecraft.webmagic.model.annotation.TargetUrl;
/**
 * @author cjb
 */
@TargetUrl("http://www.cnbeta.com/articles/\\w+\\w+")
@HelpUrl("http://www.cnbeta.com/articles/\\w+")
public class CnBeta  {
	
	/**文章id**/
	@ExtractByUrl(value="http://www.cnbeta.com/articles/(\\w+)", notNull = true)
	private int id;
	 
	/**新闻标题**/
	@ExtractBy(value="//h2[@id='news_title']/text()", notNull = true)
	private String newsTitle;
	 
	/**引言**/
	@ExtractBy("//div[@class='introduction']/p/text()")
	private String introduction;
	 
	/**内容**/
	@ExtractBy(value = "//div[@class='content']", notNull = true)
	private String content;
	 
	/**日期**/
	@Formatter("yyyy-MM-dd HH:mm:ss")
	@ExtractBy("//span[@class='date']/regex('\\d+-\\d+-\\d+\\s+\\d+:\\d+')")
	private Date date;
	
	/**稿源**/
	@ExtractBy("//span[@class='where']")
	private String where;
	 
	/**责任编辑**/
	@ExtractBy("//span[@class='author']/text()")
	private String author;

	/**链接地址**/
	@ExtractByUrl
	private String url;
	
	private Date createDate;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNewsTitle() {
		return newsTitle;
	}

	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getWhere() {
		return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	 
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "CnBeta [id=" + id + ", newsTitle=" + newsTitle + ", introduction=" + introduction + ", content="
				+ content + ", date=" + date + ", where=" + where + ", author=" + author + ", url=" + url
				+ ", createDate=" + createDate + "]";
	}

	public static void main(String[] args) {
		OOSpider.create(Site.me().setSleepTime(1000)
                , new ConsolePageModelPipeline(), CnBeta.class)
                .addUrl("http://www.cnbeta.com").thread(5).run();
	}

}
