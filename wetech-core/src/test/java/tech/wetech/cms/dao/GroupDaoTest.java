package tech.wetech.cms.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.io.IOException;
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
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.orm.hibernate4.SessionHolder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import tech.wetech.basic.model.Pager;
import tech.wetech.basic.model.SystemContext;
import tech.wetech.basic.util.AbstractDbUnitTestCase;
import tech.wetech.basic.util.EntitiesHelper;
import tech.wetech.basic.util.TestUtil;
import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.Group;
import tech.wetech.cms.model.GroupChannel;
import tech.wetech.cms.model.User;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class GroupDaoTest extends AbstractDbUnitTestCase{
	@Inject
	private SessionFactory sessionFactory;
	@Inject
	private IUserDao userDao;
	@Inject
	private IGroupDao groupDao;
	@Inject
	private IChannelDao channelDao;
	
	@Before
	public void setUp() throws SQLException, IOException, DatabaseUnitException {
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
		this.backupAllTable();
		IDataSet ds = createDateSet("t_user");
		DatabaseOperation.CLEAN_INSERT.execute(dbunitCon,ds);
	}
	
	@Test
	public void testListGroup() {
		List<Group> actuals = Arrays.asList(new Group(1,"财务处"),new Group(2,"计科系"),new Group(3,"宣传部"));
		List<Group> expects = groupDao.listGroup();
		EntitiesHelper.assertGroups(expects, actuals);
	}

	@Test
	public void testFindGroup() {
		SystemContext.setPageOffset(0);
		SystemContext.setPageSize(15);
		List<Group> actuals = Arrays.asList(new Group(1,"财务处"),new Group(2,"计科系"),new Group(3,"宣传部"));
		Pager<Group> pages = groupDao.findGroup();
		assertNotNull(pages);
		assertEquals(pages.getTotal(), 3);
		EntitiesHelper.assertGroups(pages.getDatas(), actuals);
	}

	@Test
	public void testDeleteGroupUsers() {
		int gid = 1;
		groupDao.deleteGroupUsers(gid);
		List<User> users = userDao.listGroupUsers(gid);
		assertEquals(users.size(), 0);
	}
	
	@Test
	public void testAddGroupChannel() {
		Group g = groupDao.load(3);
		Channel c = channelDao.load(6);
		groupDao.addGroupChannel(g, c);
		
		GroupChannel gc = groupDao.loadGroupChannel(3, 6);
		assertNotNull(gc);
		EntitiesHelper.assertGroup(gc.getGroup(), g);
	}

	@Test
	public void testLoadGroupChannel() throws Exception {
		Group g = groupDao.load(1);
		Channel c = channelDao.load(1);
		GroupChannel gc = groupDao.loadGroupChannel(1, 1);
		EntitiesHelper.assertChannel(gc.getChannel(), c);
		EntitiesHelper.assertGroup(gc.getGroup(), g);
	}

	@Test
	public void testListGroupChannelIds() {
		int gid = 1;
		List<Integer> actual = Arrays.asList(1,2,3,6,8);
		List<Integer> expected = groupDao.listGroupChannelIds(gid);
		EntitiesHelper.assertObjects(expected, actual);
	}

	@Test
	public void testGenerateGroupChannelTree() throws Exception{
		int gid = 1;
		List<ChannelTree> actuals = Arrays.asList
				(new ChannelTree(Channel.ROOT_ID,Channel.ROOT_NAME,-1),
				 new ChannelTree(1,"用户管理模块",0),
				 new ChannelTree(2,"用户管理1",1),
				 new ChannelTree(3,"用户管理2",1),
				 new ChannelTree(6,"文章管理模块",0),
				 new ChannelTree(8,"文章管理2",6));
		List<ChannelTree> cts = groupDao.generateGroupChannelTree(gid);
		TestUtil.assertListByClz(cts, actuals, ChannelTree.class, null);
	}

	@Test
	public void testGenerateUserChannelTree() throws Exception{
		int uid = 3;
		List<ChannelTree> actuals = Arrays.asList
				(new ChannelTree(Channel.ROOT_ID,Channel.ROOT_NAME,-1),
				 new ChannelTree(1,"用户管理模块",0),
				 new ChannelTree(2,"用户管理1",1),
				 new ChannelTree(3,"用户管理2",1),
				 new ChannelTree(6,"文章管理模块",0),
				 new ChannelTree(8,"文章管理2",6),
				 new ChannelTree(7,"文章管理1",6));
		List<ChannelTree> cts = groupDao.generateUserChannelTree(uid);
		TestUtil.assertListByClz(cts, actuals, ChannelTree.class, null);
	}

	@Test
	public void testClearGroupChannel() {
		int gid = 1;
		groupDao.clearGroupChannel(gid);
		List<Integer> ids = groupDao.listGroupChannelIds(gid);
		assertEquals(ids.size(), 0);
	}

	@Test
	public void testDeleteGroupChannel() {
		int gid = 1;
		int cid = 1;
		groupDao.deleteGroupChannel(gid, cid);
		GroupChannel gc = groupDao.loadGroupChannel(gid, cid);
		assertNull(gc);
	}
	
	@After
	public void tearDown() throws Exception {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
		this.resumeTable();
	}
}
