package tech.wetech.cms.dao;


import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.dbunit.DatabaseUnitException;
import org.dbunit.dataset.IDataSet;
import org.dbunit.operation.DatabaseOperation;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.orm.hibernate4.SessionHolder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import tech.wetech.basic.model.Pager;
import tech.wetech.basic.util.AbstractDbUnitTestCase;
import tech.wetech.basic.util.JsonUtil;
import tech.wetech.basic.util.TestUtil;
import tech.wetech.cms.model.Topic;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class TopicDaoTest extends AbstractDbUnitTestCase{
	@Inject
	private SessionFactory sessionFactory;
	
	@Inject
	private ITopicDao topicDao;
	
	@Before
	public void setUp() throws SQLException, IOException, DatabaseUnitException {
		//此时最好不要使用Spring的Transactional来管理，因为dbunit是通过jdbc来处理connection，再使用spring在一些编辑操作中会造成事务shisu
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
		this.backupAllTable();
		IDataSet ds = createDateSet("topic");
		DatabaseOperation.CLEAN_INSERT.execute(dbunitCon,ds);
	}
	
	
	@After
	public void tearDown() throws DatabaseUnitException, SQLException, IOException {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
		this.resumeTable();
	}
	
	@Test
	public void testListTopicByChannelAndNumber() {
		List<Topic> topics =  topicDao.listTopicByChannelAndNumber(13, 8);
		String json = JsonUtil.getInstance().obj2json(topics);
		System.out.println(json);
	}
	
	@Test
	public void testFindByCts() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Pager<Topic> ts = topicDao.find(7, null, 1);
		Assert.assertEquals(ts.getTotal(), 2);
		List<Topic> ls = Arrays.asList(new Topic(1,"abababab1","aa|aaa",1,1,"管理员",""),
					new Topic(4,"dededede1","",1,1,"文章发布人员",""));
		TestUtil.assertListByClz(ls, ts.getDatas(), Topic.class,
				new String[]{"summary","content","user","publishDate",
			"createDate","cname","channel","channelPicId"});
	}


	@Test
	public void testSearchTopicByKeyword() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Pager<Topic> ts = topicDao.searchTopicByKeyword("aa");
		Assert.assertEquals(ts.getTotal(), 1);
		List<Topic> ls = Arrays.asList(new Topic(1,"abababab1","aa|aaa",1,1,"管理员",""));
		TestUtil.assertListByClz(ls, ts.getDatas(), Topic.class,
				new String[]{"summary","content","user","publishDate",
			"createDate","cname","channel","channelPicId"});
	}

	@Test
	public void testSearchTopic() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Pager<Topic> ts = topicDao.searchTopic("b");
		Assert.assertEquals(ts.getTotal(), 2);
		List<Topic> ls = Arrays.asList(new Topic(1,"abababab1","aa|aaa",1,1,"管理员",""),
				new Topic(3,"cdcdcdcd1","cd",1,0,"管理员",""));
		TestUtil.assertListByClz(ls, ts.getDatas(), Topic.class,
				new String[]{"summary","content","user","publishDate",
			"createDate","cname","channel","channelPicId"});
	}

	@Test
	public void testFindRecommendTopic() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Pager<Topic> ts = topicDao.findRecommendTopic(7);
		Assert.assertEquals(ts.getTotal(), 2);
		List<Topic> ls = Arrays.asList(new Topic(1,"abababab1","aa|aaa",1,1,"管理员",""),
					new Topic(4,"dededede1","",1,1,"文章发布人员",""));
		TestUtil.assertListByClz(ls, ts.getDatas(), Topic.class,
				new String[]{"summary","content","user","publishDate",
			"createDate","cname","channel","channelPicId"});
	}
	
	@Test
	public void testListRecommendTopicByNumber() {
		List<Topic> list = topicDao.listRecommendTopicByNumber(8);
		String json = JsonUtil.getInstance().obj2json(list);
		Assert.assertNotNull(json);
		System.out.println(json);
	}
	
	@Test
	public void testFindByTitileAndStatus() {
		Pager<Topic> ts = topicDao.find("", 1);
		String json = JsonUtil.getInstance().obj2json(ts);
		Assert.assertNotNull(json);
	}
	
}
