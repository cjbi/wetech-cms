package tech.wetech.cms.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
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

import tech.wetech.basic.model.Pager;
import tech.wetech.basic.model.SystemContext;
import tech.wetech.basic.test.util.EntitiesHelper;
import tech.wetech.basic.util.AbstractDbUnitTestCase;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.Group;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.RoleType;
import tech.wetech.cms.model.User;
import tech.wetech.cms.model.UserGroup;
import tech.wetech.cms.model.UserRole;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class UserDaoTest extends AbstractDbUnitTestCase{
	@Inject
	private SessionFactory sessionFactory;
	@Inject
	private IUserDao userDao;
	@Inject
	private IRoleDao roleDao;
	@Inject
	private IGroupDao groupDao;
	
	@Before
	public void setUp() throws SQLException, IOException, DatabaseUnitException {
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
	
	@Test
	public void testListUserRoles() throws DatabaseUnitException, SQLException {
		List<Role> actuals = Arrays.asList(new Role(2,"文章发布人员",RoleType.ROLE_PUBLISH),new Role(3,"文章审核人员",RoleType.ROLE_AUDIT));
		List<Role> roles = userDao.listUserRoles(2);
		EntitiesHelper.assertRoles(roles, actuals);
	}
	
	@Test
	public void testListUserRoleIds() throws Exception {
		List<Integer> actuals = Arrays.asList(2,3);
		List<Integer> expected = userDao.listUserRoleIds(2);
		EntitiesHelper.assertObjects(expected, actuals);
	}
	
	@Test
	public void testListUserGroups() throws DatabaseUnitException, SQLException {
		List<Group> actuals = Arrays.asList(new Group(1,"财务处"),new Group(3,"宣传部"));
		List<Group> roles = userDao.listUserGroups(3);
		EntitiesHelper.assertGroups(roles, actuals);
	}
	
	@Test
	public void testListUserGroupIds() throws DatabaseUnitException, SQLException {
		List<Integer> actuals = Arrays.asList(1,3);
		List<Integer> expected = userDao.listUserGroupIds(3);
		EntitiesHelper.assertObjects(expected, actuals);
	}
	
	@Test
	public void testLoadUserRole() throws DatabaseUnitException, SQLException {
		int uid = 1;
		int rid = 1;
		UserRole ur = userDao.loadUserRole(uid, rid);
		User au = new User(1,"admin1","123","admin1","admin1@admin.com","110",1);
		Role ar = new Role(1,"管理员",RoleType.ROLE_ADMIN);
		EntitiesHelper.assertUser(ur.getUser(), au);
		EntitiesHelper.assertRole(ur.getRole(), ar);
	}
	
	@Test
	public void testLoadUserGroup() throws DatabaseUnitException, SQLException {
		int uid = 2;
		int gid = 1;
		UserGroup ug = userDao.loadUserGroup(uid, gid);
		User au = new User(2,"admin2","123","admin1","admin1@admin.com","110",1);
		Group ag = new Group(1,"财务处");
		EntitiesHelper.assertUser(ug.getUser(), au);
		EntitiesHelper.assertGroup(ug.getGroup(), ag);
	}
	
	@Test
	public void testLoadUserName() throws DatabaseUnitException, SQLException {
		User au = EntitiesHelper.getBaseUser();
		String username = "admin1";
		User eu = userDao.loadByUsername(username);
		EntitiesHelper.assertUser(eu, au);
	}
	
	@Test
	public void testListRoleUsers() throws DatabaseUnitException, SQLException {
		int rid = 2;
		List<User> aus = Arrays.asList(new User(2,"admin2","123","admin1","admin1@admin.com","110",1),
									   new User(3,"admin3","123","admin1","admin1@admin.com","110",1));
		List<User> eus = userDao.listRoleUsers(rid);
		EntitiesHelper.assertUsers(eus, aus);
	}
	
	@Test
	public void testListRoleUsersByRoleType() throws DatabaseUnitException, SQLException {
		List<User> aus = Arrays.asList(new User(2,"admin2","123","admin1","admin1@admin.com","110",1),
									   new User(3,"admin3","123","admin1","admin1@admin.com","110",1));
		List<User> eus = userDao.listRoleUsers(RoleType.ROLE_PUBLISH);
		EntitiesHelper.assertUsers(eus, aus);
	}
	
	@Test
	public void testListGroupUsers() throws DatabaseUnitException, SQLException {
		List<User> aus = Arrays.asList(new User(2,"admin2","123","admin1","admin1@admin.com","110",1),
				   new User(3,"admin3","123","admin1","admin1@admin.com","110",1));
		List<User> eus = userDao.listGroupUsers(1);
		EntitiesHelper.assertUsers(eus, aus);
	}
	
	@Test
	public void testAddUserGroup() throws DatabaseUnitException, SQLException {
		Group group = groupDao.load(1);
		User user = userDao.load(1);
		userDao.addUserGroup(user, group);
		UserGroup ur = userDao.loadUserGroup(1, 1);
		assertNotNull(ur);
		assertEquals(ur.getGroup().getId(), 1);
		assertEquals(ur.getUser().getId(), 1);
	}
	
	@Test
	public void testAddUserRole() throws DatabaseUnitException, SQLException {
		Role role = roleDao.load(1);
		User user = userDao.load(1);
		userDao.addUserRole(user, role);
		UserRole ur = userDao.loadUserRole(1, 1);
		assertNotNull(ur);
		assertEquals(ur.getRole().getId(), 1);
		assertEquals(ur.getUser().getId(), 1);
	}
	
	@Test
	public void testDeleteUserRoles() throws DatabaseUnitException, SQLException {
		int uid = 2;
		userDao.deleteUserRoles(uid);
		List<Role> urs = userDao.listUserRoles(uid);
		assertTrue(urs.size()<=0);
	}
	
	@Test
	public void testDeleteUserGroups() throws DatabaseUnitException, SQLException {
		int uid = 2;
		userDao.deleteUserGroups(uid);
		List<Group> ugs = userDao.listUserGroups(uid);
		assertTrue(ugs.size()<=0);
	}
	
	@Test
	public void testDeleteUserRole() throws DatabaseUnitException, SQLException {
		int uid = 1;
		int rid = 1;
		userDao.deleteUserRole(uid,rid);
		assertNull(userDao.loadUserRole(uid, rid));
	}
	
	@Test
	public void testDeleteUserGroup() throws DatabaseUnitException, SQLException {
		int uid = 1;
		int gid = 2;
		userDao.deleteUserGroup(uid,gid);
		assertNull(userDao.loadUserGroup(uid, gid));
	}
	
	@Test
	public void testFindUser() {
		SystemContext.setPageOffset(0);
		SystemContext.setPageSize(15);
		List<User> actuals = Arrays.asList(new User(1,"admin1","123","admin1","admin1@admin.com","110",1),
				   new User(2,"admin2","123","admin1","admin1@admin.com","110",1),
				   new User(3,"admin3","123","admin1","admin1@admin.com","110",1));
		Pager<User> pages = userDao.findUser();
		assertNotNull(pages);
		assertEquals(pages.getTotal(), 3);
		EntitiesHelper.assertUsers(pages.getDatas(), actuals);
	}
	
	@After
	public void tearDown() throws DatabaseUnitException, SQLException, IOException {
		SessionHolder holder = (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
		Session s = holder.getSession(); 
		s.flush();
		TransactionSynchronizationManager.unbindResource(sessionFactory);
		//this.resumeTable();
	}
}
