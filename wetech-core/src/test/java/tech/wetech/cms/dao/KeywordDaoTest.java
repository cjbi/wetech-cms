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
import tech.wetech.basic.test.util.TestUtil;
import tech.wetech.basic.util.AbstractDbUnitTestCase;
import tech.wetech.cms.model.Keyword;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class KeywordDaoTest extends AbstractDbUnitTestCase{
	@Inject
	private SessionFactory sessionFactory;
	
	@Inject
	private IKeywordDao keywordDao;
	
	@Before
	public void setUp() throws SQLException, IOException, DatabaseUnitException {
		//此时最好不要使用Spring的Transactional来管理，因为dbunit是通过jdbc来处理connection，再使用spring在一些编辑操作中会造成事务shisu
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
		this.backupAllTable();
		IDataSet ds = createDateSet("topic");
		DatabaseOperation.TRUNCATE_TABLE.execute(dbunitCon, ds);
		DatabaseOperation.CLEAN_INSERT.execute(dbunitCon,ds);
	}
	
	@Test
	public void testFindNoUseKeyword() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Pager<Keyword> ks = keywordDao.findNoUseKeyword();
		Assert.assertEquals(ks.getTotal(), 3);
		List<Keyword> ls = Arrays.asList(new Keyword(1,"ab",1),
				new Keyword(6,"abc",6,"abc","abc"),
				new Keyword(7,"bcd",7,"bcd","bcd"));
		TestUtil.assertListByClz(ls, ks.getDatas(), Keyword.class, null);
	}
	
	@Test
	public void testFindUseKeyword() {
		List<Keyword> ks = keywordDao.findUseKeyword();
		for(Keyword k:ks) {
			System.out.println(k.getName()+","+k.getTimes());
		}
	}
	
	@Test
	public void testClearNoUseKeyword() {
		keywordDao.clearNoUseKeyword();
		Pager<Keyword> ks = keywordDao.findNoUseKeyword();
		Assert.assertEquals(ks.getTotal(), 0);
		Assert.assertEquals(ks.getDatas().size(), 0);
	}
	
	@Test
	public void testListKeywordByCon() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		List<Keyword> ks = keywordDao.listKeywordByCon("bc");
		Assert.assertEquals(ks.size(), 4);
		List<Keyword> ls = Arrays.asList(new Keyword(2,"bc",2),
				new Keyword(5,"fg",5,"fg","bc"),
				new Keyword(6,"abc",6,"abc","abc"),
				new Keyword(7,"bcd",7,"bcd","bcd"));
		TestUtil.assertListByClz(ls, ks, Keyword.class,null);
	}
	
	@Test
	public void testAddOrUpdate() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		keywordDao.addOrUpdate("bc");
		Keyword k = keywordDao.load(2);
		Keyword kk = new Keyword(2, "bc", 2+1,"bc","bc");
		TestUtil.assertObjByClz(k, kk, Keyword.class,null);
	}
	
	@Test
	public void testAddOrUpdateAdd() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		keywordDao.addOrUpdate("招生政策");
		Keyword k = keywordDao.load(11);
		Keyword kk = new Keyword(11, "招生政策", "zhaoshengzhengce","zszc");
		TestUtil.assertObjByClz(k, kk, Keyword.class, new String[]{"times"});
	}

	
	@After
	public void tearDown() throws DatabaseUnitException, SQLException, IOException {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
		this.resumeTable();
	}
}
