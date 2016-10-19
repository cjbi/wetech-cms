package tech.wetech.cms.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

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

import tech.wetech.cms.dao.IGroupDao;
import tech.wetech.cms.dao.IRoleDao;
import tech.wetech.cms.dao.IUserDao;
import tech.wetech.cms.model.ChannelTree;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class UserService1Test {
	@Inject
	private SessionFactory sessionFactory;
	@Inject
	private IUserDao userDao;
	@Inject
	private IRoleDao roleDao;
	@Inject
	private IGroupDao groupDao;
	
	@Before
	public void setUp() throws SQLException, IOException {
		//此时最好不要使用Spring的Transactional来管理，因为dbunit是通过jdbc来处理connection，再使用spring在一些编辑操作中会造成事务shisu
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
//		this.backupAllTable();
//		IDataSet ds = createDateSet("t_user");
//		DatabaseOperation.CLEAN_INSERT.execute(dbunitCon,ds);
	}
	
	@Test
	public void testUserChannel() {
		List<ChannelTree> cts = groupDao.generateUserChannelTree(5);
		System.out.println(cts);
	}
	
	
	@After
	public void tearDown() throws SQLException, IOException {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
		//this.resumeTable();
	}
}
