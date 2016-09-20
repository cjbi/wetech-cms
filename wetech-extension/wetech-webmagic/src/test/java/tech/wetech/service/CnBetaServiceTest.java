package tech.wetech.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.dbunit.DatabaseUnitException;
import org.dbunit.dataset.DataSetException;
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
import tech.wetech.webmagic.model.CnBeta;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class CnBetaServiceTest  extends AbstractDbUnitTestCase {
	
	@Inject
	private SessionFactory sessionFactory;
	
	@Inject
	private ICnBetaService cnBetaService;
	
	
	
	@Before
	public void setUp() throws DataSetException, SQLException, IOException {
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
		this.backupAllTable();
	}
	
	@After
	public void tearDown() throws FileNotFoundException, DatabaseUnitException, SQLException {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
//		this.resumeTable();
	}
	
	@Test
	public void testFetchCnBetaPage2Wordpress() {
		List<CnBeta> cnBetas = cnBetaService.fetchCnBetaPage2Wordpress();
		for(CnBeta cnBeta : cnBetas) {
			System.out.println(cnBeta.getId());
		}
	}
	
	@Test
	public void testCreateDate() {
		System.out.println(new Date());
	}
	
}
