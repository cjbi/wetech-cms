package tech.wetech.cms.service;

import java.util.List;

import javax.inject.Inject;

import org.hibernate.SessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.ChannelType;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class ChannelAndTopicTest {
	@Inject
	private SessionFactory sessionFactory;
	@Inject
	private IChannelService channelService;
	@Inject
	private ITopicService topicService;
	
	
	@Test
	public void testTopNav() {
		List<Channel> cs = channelService.listTopNavChannel();
		for(Channel c:cs) {
			System.out.println(c.getId()+","+c.getName()+","+c.getCustomLink()+","+c.getCustomLinkUrl());
		}
	}
	
	@Test
	public void testIndexChannel() {
		List<Channel> cs = channelService.listAllIndexChannel(ChannelType.TOPIC_LIST);
		for(Channel c:cs) {
			System.out.println(c.getId()+","+c.getName());
		}
	}
	
	@Test
	public void testIsUpdateIndex() {
		System.out.println(topicService.isUpdateIndex(7));
	}
	
	@Test
	public void testLoadLastTopic() {
		System.out.println(topicService.loadLastedTopicByColumn(7).getSummary());
	}
	
	@Test
	public void testLoadFirstChannel() {
//		System.out.println(channelService.loadFirstChannelByNav(1).getName());
	}
	
	@Test
	public void testListChannelByType() {
		for(Channel c:channelService.listChannelByType(ChannelType.NAV_CHANNEL)) {
			System.out.println(c.getName()+","+c.getId());
		}
	}
}
