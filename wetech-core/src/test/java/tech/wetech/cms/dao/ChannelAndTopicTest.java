package tech.wetech.cms.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.dbunit.DatabaseUnitException;
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

import tech.wetech.cms.model.Channel;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class ChannelAndTopicTest {
	@Inject
	private SessionFactory sessionFactory;
	@Inject
	private IChannelDao channelDao;
	
	@Before
	public void setUp() throws SQLException, IOException, DatabaseUnitException {
		//此时最好不要使用Spring的Transactional来管理，因为dbunit是通过jdbc来处理connection，再使用spring在一些编辑操作中会造成事务shisu
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
	}
	
	@Test
	public void testTopNav() {
		List<Channel> cs = channelDao.listTopNavChannel();
		for(Channel c:cs) {
			System.out.println(c.getId()+","+c.getName()+","+c.getCustomLink()+","+c.getCustomLinkUrl());
		}
	}
	
	@After
	public void tearDown() throws DatabaseUnitException, SQLException, IOException {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
	}
}
