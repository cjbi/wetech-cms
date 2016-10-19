package tech.wetech.cms.service;

import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.expectLastCall;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.reset;
import static org.easymock.EasyMock.verify;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import tech.wetech.cms.dao.IRoleDao;
import tech.wetech.cms.dao.IUserDao;
import tech.wetech.cms.model.CmsException;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.RoleType;
import tech.wetech.cms.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/test-beans.xml")
public class RoleServiceTest {
	@Inject
	private IRoleService roleService;
	@Inject
	private IUserDao userDao;
	@Inject
	private IRoleDao roleDao;
	private Role baseRole = new Role(1,"管理员",RoleType.ROLE_ADMIN);

	@Test
	public void testAdd() {
		reset(roleDao);
		expect(roleDao.add(baseRole)).andReturn(baseRole);
		replay(roleDao);
		roleService.add(baseRole);
		verify(roleDao);
	}

	@Test
	public void testDeleteNoUsers() {
		reset(roleDao,userDao);
		int gid = 1;
		expect(userDao.listRoleUsers(gid)).andReturn(null);
		roleDao.delete(gid);
		expectLastCall();
		replay(roleDao,userDao);
		roleService.delete(gid);
		verify(roleDao,userDao);
	}
	
	@Test(expected=CmsException.class)
	public void testDeleteHasUsers() {
		reset(roleDao,userDao);
		int gid = 1;
		List<User> us = Arrays.asList(new User());
		expect(userDao.listRoleUsers(gid)).andReturn(us);
		roleDao.delete(gid);
		expectLastCall();
		replay(roleDao,userDao);
		roleService.delete(gid);
		verify(roleDao,userDao);
	}

	@Test
	public void testLoad() {
		reset(roleDao);
		int id = 1;
		expect(roleDao.load(id)).andReturn(baseRole);
		replay(roleDao);
		roleService.load(id);
		verify(roleDao);
	}

	@Test
	public void testUpdate() {
		reset(roleDao);
		roleDao.update(baseRole);
		expectLastCall();
		replay(roleDao);
		roleService.update(baseRole);
		verify(roleDao);
	}

	@Test
	public void testListRole() {
		reset(roleDao);
		expect(roleDao.listRole()).andReturn(new ArrayList<Role>());
		expectLastCall();
		replay(roleDao);
		roleService.listRole();
		verify(roleDao);
	}


	@Test
	public void testDeleteRoleUsers() {
		reset(roleDao);
		int rid = 1;
		roleDao.deleteRoleUsers(rid);
		expectLastCall();
		replay(roleDao);
		roleService.deleteRoleUsers(rid);
		verify(roleDao);
	}

}
