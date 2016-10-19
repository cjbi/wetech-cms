package tech.wetech.cms.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
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
import tech.wetech.basic.util.AbstractDbUnitTestCase;
import tech.wetech.cms.model.IndexPic;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class IndexPicDaoTest extends AbstractDbUnitTestCase{
	@Inject
	private SessionFactory sessionFactory;
	
	@Inject
	private IIndexPicDao indexPicDao;
	@Before
	public void setUp() throws SQLException, IOException, DatabaseUnitException {
		//此时最好不要使用Spring的Transactional来管理，因为dbunit是通过jdbc来处理connection，再使用spring在一些编辑操作中会造成事务shisu
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
	}
	
	@Test
	public void testAdd() {
		IndexPic ip = new IndexPic();
		ip.setCreateDate(new Date());
		ip.setLinkType(1);
		ip.setNewName("abc");
		ip.setTitle("123");
		indexPicDao.add(ip);
	}
	
	@Test
	public void testDelete() {
//		indexPicDao.delete(8);
	}
	
	@Test
	public void testMaxAndMin() {
		System.out.println(indexPicDao.getMinAdnMaxPos());
	}
	
	@Test
	public void testSetPos() {
//		indexPicDao.updatePos(11, 1, 3);
	}
	
	
	@After
	public void tearDown() throws DatabaseUnitException, SQLException, IOException {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
	}
}
