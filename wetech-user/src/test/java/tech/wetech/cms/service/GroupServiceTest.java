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

import tech.wetech.basic.model.Pager;
import tech.wetech.cms.dao.IGroupDao;
import tech.wetech.cms.dao.IUserDao;
import tech.wetech.cms.model.CmsException;
import tech.wetech.cms.model.Group;
import tech.wetech.cms.model.GroupFindModel;
import tech.wetech.cms.model.User;
import tech.wetech.cms.service.IGroupService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/test-beans.xml")
public class GroupServiceTest {
	@Inject
	private IGroupService groupService;
	@Inject
	private IUserDao userDao;
	@Inject
	private IGroupDao groupDao;
	private Group baseGroup = new Group(1,"财务处");

	@Test
	public void testAdd() {
		reset(groupDao);
		expect(groupDao.add(baseGroup)).andReturn(baseGroup);
		replay(groupDao);
		groupService.add(baseGroup);
		verify(groupDao);
	}

	@Test
	public void testDeleteNoUsers() {
		reset(groupDao,userDao);
		int gid = 1;
		expect(userDao.listGroupUsers(gid)).andReturn(null);
		groupDao.delete(gid);
		expectLastCall();
		replay(groupDao,userDao);
		groupService.delete(gid);
		verify(groupDao,userDao);
	}
	
	@Test(expected=CmsException.class)
	public void testDeleteHasUsers() {
		reset(groupDao,userDao);
		int gid = 1;
		List<User> us = Arrays.asList(new User());
		expect(userDao.listGroupUsers(gid)).andReturn(us);
		groupDao.delete(gid);
		expectLastCall();
		replay(groupDao,userDao);
		groupService.delete(gid);
		verify(groupDao,userDao);
	}

	@Test
	public void testLoad() {
		reset(groupDao);
		int id = 1;
		expect(groupDao.load(id)).andReturn(baseGroup);
		replay(groupDao);
		groupService.load(id);
		verify(groupDao);
	}

	@Test
	public void testUpdate() {
		reset(groupDao);
		groupDao.update(baseGroup);
		expectLastCall();
		replay(groupDao);
		groupService.update(baseGroup);
		verify(groupDao);
	}

	@Test
	public void testListGroup() {
		reset(groupDao);
		expect(groupDao.listGroup()).andReturn(new ArrayList<Group>());
		expectLastCall();
		replay(groupDao);
		groupService.listGroup();
		verify(groupDao);
	}

	@Test
	public void testFindGroup() {
		reset(groupDao);
		expect(groupDao.findGroup()).andReturn(new Pager<GroupFindModel>());
		expectLastCall();
		replay(groupDao);
		groupService.findGroup();
		verify(groupDao);
	}

	@Test
	public void testDeleteGroupUsers() {
		reset(groupDao);
		int gid = 1;
		groupDao.deleteGroupUsers(gid);
		expectLastCall();
		replay(groupDao);
		groupService.deleteGroupUsers(gid);
		verify(groupDao);
	}

}
