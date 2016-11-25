package tech.wetech.cms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tech.wetech.basic.model.SystemContext;
import tech.wetech.basic.util.FreemarkerUtil;
import tech.wetech.basic.util.PropertiesUtil;
import tech.wetech.cms.model.BaseInfo;
import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.ChannelType;
import tech.wetech.cms.model.IndexTopic;
import tech.wetech.cms.model.Topic;
import tech.wetech.cms.web.BaseInfoUtil;

@Service("indexService")
public class IndexService implements IIndexService {
	
	private String outPath;
	private FreemarkerUtil util;
	
	@Autowired(required=true)
	public IndexService(String ftlPath, String outPath) {
		super();
		if(util==null) {
			this.outPath = outPath;
			util = FreemarkerUtil.getInstance(ftlPath);
		}
	}

	private IChannelService channelService;
	private ITopicService topicService;
	private IIndexPicService indexPicService;
	private IKeywordService keyworkService;
	
	
	public IKeywordService getKeyworkService() {
		return keyworkService;
	}
	
	@Inject
	public void setKeyworkService(IKeywordService keyworkService) {
		this.keyworkService = keyworkService;
	}
	public IIndexPicService getIndexPicService() {
		return indexPicService;
	}
	@Inject
	public void setIndexPicService(IIndexPicService indexPicService) {
		this.indexPicService = indexPicService;
	}

	public ITopicService getTopicService() {
		return topicService;
	}
	
	@Inject
	public void setTopicService(ITopicService topicService) {
		this.topicService = topicService;
	}
	public IChannelService getChannelService() {
		return channelService;
	}
	@Inject
	public void setChannelService(IChannelService channelService) {
		this.channelService = channelService;
	}

	@Override
	public void generateTop() {
		System.out.println("=============重新生成了顶部信息====================");
		List<Channel> cs = channelService.listTopNavChannel();
		Map<String,Object> root = new HashMap<String,Object>();
		root.put("navs", cs);
		root.put("baseInfo", BaseInfoUtil.getInstacne().read());
		String outfile = SystemContext.getRealPath()+outPath+"/top.jsp";
		util.fprint(root, "/top.ftl", outfile);
	}

	@Override
	public void generateBottom() {
		System.out.println("=============重新生成了底部信息====================");
		Map<String,Object> root = new HashMap<String,Object>();
		root.put("baseInfo", BaseInfoUtil.getInstacne().read());
		String outfile = SystemContext.getRealPath()+outPath+"/bottom.jsp";
		util.fprint(root, "/bottom.ftl", outfile);
	}

	@Override
	public void generateBody() {
		System.out.println("=========重新生成首页的内容信息==============");
		//1、获取所有的首页栏目
		List<Channel> cs = channelService.listAllIndexChannel(ChannelType.TOPIC_LIST);
		//2、根据首页栏目创建相应的IndexTopic对象
		//加载indexChannel.properties
		Properties prop = PropertiesUtil.getInstance().load("indexChannel");
		Map<String,IndexTopic> topics = new HashMap<String, IndexTopic>();
		for(Channel c:cs) {
			int cid = c.getId();
			String[] xs = prop.getProperty(cid+"").split("_");
			String order = xs[0];
			int num = Integer.parseInt(xs[1]);
			IndexTopic it = new IndexTopic();
			it.setCid(cid);
			it.setCname(c.getName());
			List<Topic> tops = topicService.listTopicByChannelAndNumber(cid, num);
//			System.out.println(cid+"--"+tops);
			it.setTopics(tops);
			topics.put(order, it);
		}
		String outfile = SystemContext.getRealPath()+outPath+"/body.jsp";
		//3、更新首页图片
		BaseInfo bi = BaseInfoUtil.getInstacne().read();
		int picnum = bi.getIndexPicNumber();
		Map<String,Object> root = new HashMap<String,Object>();
		root.put("ts", topics);
		root.put("pics", indexPicService.listIndexPicByNum(picnum));
		root.put("keywords", keyworkService.getMaxTimesKeyword(12));
		//学校概括，从数据库取出
		root.put("xxgk", topicService.loadLastedTopicByColumn(7));
		util.fprint(root, "/body.ftl", outfile);
	}

}
