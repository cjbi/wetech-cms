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
import tech.wetech.basic.util.TestUtil;
import tech.wetech.cms.model.Attachment;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class AttachmentDaoTest extends AbstractDbUnitTestCase{
	@Inject
	private SessionFactory sessionFactory;
	
	@Inject
	private IAttachmentDao attachmentDao;
	
	@Before
	public void setUp() throws SQLException, IOException, DatabaseUnitException {
		//此时最好不要使用Spring的Transactional来管理，因为dbunit是通过jdbc来处理connection，再使用spring在一些编辑操作中会造成事务shisu
		Session s = sessionFactory.openSession();
		TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(s));
		this.backupAllTable();
		IDataSet ds = createDateSet("topic");
		DatabaseOperation.CLEAN_INSERT.execute(dbunitCon,ds);
	}
	
	@Test
	public void testFindNoUseAttachment() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Pager<Attachment> as = attachmentDao.findNoUseAttachment();
		Assert.assertEquals(as.getTotal(), 2);
		List<Attachment> ls = Arrays.asList(new Attachment(5,"bb5","aa5","gif","gif",123,1,0,1),
				new Attachment(8,"bb8","aa8","ppt","ppt",123,0,0,1));
		TestUtil.assertListByClz(ls, as.getDatas(),Attachment.class, 
				new String[]{"createDate","topic",});
	}
	
	@Test
	public void testClearNoUseAttachment() {
		attachmentDao.clearNoUseAttachment();
		Pager<Attachment> as = attachmentDao.findNoUseAttachment();
		Assert.assertEquals(as.getTotal(), 0);
		Assert.assertEquals(as.getDatas().size(), 0);
	}
	
	@Test
	public void testListByTopic() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		List<Attachment> as = attachmentDao.listByTopic(1);
		Assert.assertEquals(as.size(), 3);
		List<Attachment> ls = Arrays.asList(new Attachment(1,"bb1","aa1","txt","txt",123,1,0,1),
				new Attachment(3,"bb3","aa3","jpg","jpg",123,1,0,0),
				new Attachment(6,"bb6","aa6","ppt","ppt",123,0,0,1));
		TestUtil.assertListByClz(ls, as, Attachment.class, 
				new String[]{"createDate","topic"});
	}
	
	@Test
	public void testDeleteByTopic() {
		attachmentDao.deleteByTopic(1);
		List<Attachment> as = attachmentDao.listByTopic(1);
		Assert.assertEquals(as.size(), 0);
	}
	
	@Test
	public void testListIndexPic() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		List<Attachment> as = attachmentDao.listIndexPic(4);
//		Assert.assertEquals(as.size(), 3);
		List<Attachment> ls = Arrays.asList(new Attachment(1,"bb1","aa1","txt","txt",123,1,0,1),
				new Attachment(3,"bb3","aa3","jpg","jpg",123,1,0,0),
				new Attachment(7,"bb7","aa7","gif","gif",123,1,1,0));
//		TestUtil.assertListByClz(ls, as, Attachment.class, new String[]{"createDate","topic"});
	}
	
	@Test
	public void testFindChannelPic() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Pager<Attachment> as = attachmentDao.findChannelPic(7);
		Assert.assertEquals(as.getTotal(), 2);
		List<Attachment> ls = Arrays.asList(new Attachment(1,"bb1","aa1","txt","txt",123,1,0,1),
				new Attachment(7,"bb7","aa7","gif","gif",123,1,1,0));
		TestUtil.assertListByClz(ls, as.getDatas(), Attachment.class, 
				new String[]{"createDate","topic"});
	}
	
	@Test
	public void testListAttachByTopic() throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		List<Attachment> as = attachmentDao.listAttachByTopic(1);
		Assert.assertEquals(as.size(), 2);
		List<Attachment> ls = Arrays.asList(new Attachment(1,"bb1","aa1","txt","txt",123,1,0,1),
				new Attachment(6,"bb6","aa6","ppt","ppt",123,0,0,1));
		TestUtil.assertListByClz(ls, as, Attachment.class, 
				new String[]{"createDate","topic"});
	}
	
	@Test
	public void testListAllPic() {
		Pager<Attachment> atts = attachmentDao.listAllIndexPic();
		for(Attachment att:atts.getDatas()) {
			System.out.println(att.getId()+"."+att.getTopic().getTitle());
		}
	}
	
	@Test
	public void testFindNoUseNum() {
		System.out.println(attachmentDao.findNoUseAttachmentNum());
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
