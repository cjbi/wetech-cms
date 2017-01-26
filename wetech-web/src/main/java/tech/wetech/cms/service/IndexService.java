package tech.wetech.cms.service;

import java.util.*;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tech.wetech.basic.model.SystemContext;
import tech.wetech.basic.util.FreemarkerUtil;
import tech.wetech.basic.util.PropertiesUtil;
import tech.wetech.cms.model.BaseInfo;
import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.ChannelType;
import tech.wetech.cms.model.IndexTopic;
import tech.wetech.cms.model.Topic;
import tech.wetech.cms.web.BaseInfoUtil;

@Service("indexService")
public class IndexService implements IIndexService {


    /**
     * 日志对象
     */
    private static final Logger logger = LoggerFactory.getLogger(TopicService.class);

    private String outPath;
    private FreemarkerUtil util;

    @Autowired(required = true)
    public IndexService(String ftlPath, String outPath) {
        super();
        if (util == null) {
            this.outPath = outPath;
            util = FreemarkerUtil.getInstance(ftlPath);
        }
    }

    @Inject
    private IChannelService channelService;
    @Inject
    private ITopicService topicService;
    @Inject
    private IIndexPicService indexPicService;
    @Inject
    private IKeywordService keyworkService;
    @Inject
    private ICmsLinkService cmsLinkService;

    @Override
    public void generateBanner() {
        logger.info("//////////重新生成首页轮播图片//////////");
        // 3、更新首页图片
        String outfile = SystemContext.getRealPath() + outPath + "/banner.jsp";
        BaseInfo bi = BaseInfoUtil.getInstacne().read();
        int picnum = bi.getIndexPicNumber();
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("pics", indexPicService.listIndexPicByNum(picnum));
        util.fprint(root, "/banner.ftl", outfile);
    }

    @Override
    public void generateTop() {
        logger.info("//////////重新生成了顶部信息//////////");
        List<Channel> cs = channelService.listTopNavChannel();
        List<ChannelTree> cts = new ArrayList<>();
        for (Channel c : cs) {
            ChannelTree ct = new ChannelTree();
            ct.setId(c.getId());
            ct.setName(c.getName());
            ct.setChannel(c);
            ct.setChild(channelService.listByParent(c.getId()));
            cts.add(ct);
        }
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("navs", cts);
        root.put("baseInfo", BaseInfoUtil.getInstacne().read());
        String outfile = SystemContext.getRealPath() + outPath + "/header.jsp";
        util.fprint(root, "/header.ftl", outfile);
    }

    @Override
    public void generateBottom() {
        logger.info("//////////重新生成了底部信息//////////");
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("baseInfo", BaseInfoUtil.getInstacne().read());
        String outfile = SystemContext.getRealPath() + outPath + "/footer.jsp";
        util.fprint(root, "/footer.ftl", outfile);
    }

    @Override
    public void generateBody() {
        logger.info("//////////重新生成首页的内容信息//////////");
        //加载indexChannel.properties
        Properties prop = PropertiesUtil.getInstance().load("conf");
        // 1、获取所有的首页栏目
        List<Channel> cs = channelService.listAllIndexChannel(ChannelType.TOPIC_LIST);
        // 2、根据首页栏目创建相应的IndexTopic对象
        List<IndexTopic> channelTopics = new ArrayList<IndexTopic>();
        for (Channel c : cs) {
            int cid = c.getId();
            IndexTopic it = new IndexTopic();
            it.setCid(cid);
            it.setCname(c.getName());
            int channelTopicNum = Integer.valueOf(prop.getProperty("cms.index.channel.topic.num"));
            List<Topic> tops = topicService.listTopicByChannelAndNumber(cid, channelTopicNum);
            // System.out.println(cid+"--"+tops);
            it.setTopics(tops);
            channelTopics.add(it);
        }
        String outfile = SystemContext.getRealPath() + outPath + "/body.jsp";
        generateBanner();
        Map<String, Object> root = new HashMap<String, Object>();
        int newNum = Integer.valueOf(prop.getProperty("cms.index.news.num"));
        root.put("news", topicService.listRecommendTopicByNumber(newNum));
        root.put("channelTopics", channelTopics);
        root.put("keywords", keyworkService.getMaxTimesKeyword(50));
        randomKeywordClz(root, 100);
        util.fprint(root, "/body.ftl", outfile);
    }

    @Override
    public void generateCmsLink() {
        logger.info("//////////重新生成首页的链接信息//////////");
        Map<String, Object> root = new HashMap<String, Object>();
        //获取所有链接地址
        root.put("links", cmsLinkService.listByType(null));
        String outfile = SystemContext.getRealPath() + outPath + "/cmsLink.jsp";
        util.fprint(root, "/cmsLink.ftl", outfile);
    }

    private void randomKeywordClz(Map<String, Object> root, int loopTimes) {
        List<String> keywordClzs = new ArrayList<String>();
        for (int i = 0; i < loopTimes; i++) {
            int radom = new Random().nextInt(6) + 1;
            switch (radom) {
                case 1:
                    keywordClzs.add("am-badge");
                    break;
                case 2:
                    keywordClzs.add("am-badge-primary");
                    break;
                case 3:
                    keywordClzs.add("am-badge-secondary");
                    break;
                case 4:
                    keywordClzs.add("am-badge-success");
                    break;
                case 5:
                    keywordClzs.add("am-badge-warning");
                    break;
                case 6:
                    keywordClzs.add("am-badge-danger");
                    break;
                default:
                    keywordClzs.add("am-badge-primary");
            }
        }
        root.put("keywordClzs", keywordClzs);
    }

}
