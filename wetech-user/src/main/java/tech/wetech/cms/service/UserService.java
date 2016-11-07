package tech.wetech.cms.service;

import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.stereotype.Service;

import tech.wetech.basic.model.Pager;
import tech.wetech.basic.util.SecurityUtil;
import tech.wetech.cms.dao.IGroupDao;
import tech.wetech.cms.dao.IRoleDao;
import tech.wetech.cms.dao.IUserDao;
import tech.wetech.cms.model.CmsException;
import tech.wetech.cms.model.Group;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.User;

@Service("userService")
public class UserService implements IUserService {
	private IUserDao userDao;
	private IRoleDao roleDao;
	private IGroupDao groupDao;

	public IUserDao getUserDao() {
		return userDao;
	}

	@Inject
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	public IRoleDao getRoleDao() {
		return roleDao;
	}

	@Inject
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public IGroupDao getGroupDao() {
		return groupDao;
	}

	@Inject
	public void setGroupDao(IGroupDao groupDao) {
		this.groupDao = groupDao;
	}

	private void addUserRole(User user, int rid) {
		// 1、检查角色对象是否存在，如果不存在，就抛出异常
		Role role = roleDao.load(rid);
		if (role == null)
			throw new CmsException("要添加的用户角色不存在");
		// 2、检查用户角色对象是否已经存在，如果存在，就不添加
		userDao.addUserRole(user, role);
	}

	private void addUserGroup(User user, int gid) {
		Group group = groupDao.load(gid);
		if (group == null)
			throw new CmsException("要添加用户的组对象不存在");
		userDao.addUserGroup(user, group);
	}

	@Override
	public void add(User user, Integer[] rids, Integer[] gids) {
		User tu = userDao.loadByUsername(user.getUsername());
		if (tu != null)
			throw new CmsException("添加的用户对象已经存在，不能添加");
		user.setCreateDate(new Date());
		try {
			user.setPassword(SecurityUtil.md5(user.getUsername(), user.getPassword()));
		} catch (NoSuchAlgorithmException e) {
			throw new CmsException("密码加密失败:" + e.getMessage());
		}
		userDao.add(user);
		// 添加角色对象
		for (Integer rid : rids) {
			this.addUserRole(user, rid);
		}
		// 添加用户组对象
		for (Integer gid : gids) {
			addUserGroup(user, gid);
		}
	}

	@Override
	public void delete(int id) {
		// TODO 需要进行用户是否有文章的判断

		// 1、删除用户管理的角色对象
		userDao.deleteUserGroups(id);
		// 2、删除用户管理的组对象
		userDao.deleteUserRoles(id);
		userDao.delete(id);
	}

	@Override
	public void update(User user, Integer[] rids, Integer[] gids) {
		// 1、获取用户已经存在的组id和角色id
		List<Integer> erids = userDao.listUserRoleIds(user.getId());
		List<Integer> egids = userDao.listUserGroupIds(user.getId());
		// 2、判断，如果erids中不存在rids就要进行添加
		for (Integer rid : rids) {
			if (!erids.contains(rid)) {
				addUserRole(user, rid);
			}
		}
		for (Integer gid : gids) {
			if (!egids.contains(gid)) {
				addUserGroup(user, gid);
			}
		}
		// 3、进行删除
		for (Integer erid : erids) {
			if (!ArrayUtils.contains(rids, erid)) {
				userDao.deleteUserRole(user.getId(), erid);
			}
		}

		for (Integer egid : egids) {
			if (!ArrayUtils.contains(gids, egid)) {
				userDao.deleteUserGroup(user.getId(), egid);
			}
		}
	}

	@Override
	public void updateStatus(int id) {
		User u = userDao.load(id);
		if (u == null)
			throw new CmsException("修改状态的用户不存在");
		if (u.getStatus() == 0)
			u.setStatus(1);
		else
			u.setStatus(0);
		userDao.update(u);
	}

	@Override
	public Pager<User> findUser() {
		return userDao.findUser();
	}
	
	@Override
	public Pager<User> findUser(String SearchCode, String searchValue) {
		return userDao.findUser(SearchCode, searchValue);
	}

	@Override
	public User load(int id) {
		return userDao.load(id);
	}

	@Override
	public List<Role> listUserRoles(int id) {
		return userDao.listUserRoles(id);
	}

	@Override
	public List<Group> listUserGroups(int id) {
		return userDao.listUserGroups(id);
	}

	@Override
	public List<Integer> listUserRoleIds(int id) {
		return userDao.listUserRoleIds(id);
	}

	@Override
	public List<Integer> listUserGroupIds(int id) {
		return userDao.listUserGroupIds(id);
	}

	@Override
	public List<User> listGroupUsers(int gid) {
		return userDao.listGroupUsers(gid);
	}

	@Override
	public List<User> listRoleUsers(int rid) {
		return userDao.listRoleUsers(rid);
	}

	@Override
	public User login(String username, String password) {
		User user = userDao.loadByUsername(username);
		if (user == null)
			throw new CmsException("用户名或者密码不正确");
		try {
			if (!SecurityUtil.md5(username, password).equals(user.getPassword())) {
				throw new CmsException("用户名或者密码不正确");
			}
		} catch (NoSuchAlgorithmException e) {
			throw new CmsException("密码加密失败:" + e.getMessage());
		}
		if (user.getStatus() == 0)
			throw new CmsException("用户已经停用，请与管理员联系");
		return user;
	}

	@Override
	public void update(User user) {
		userDao.update(user);
	}

	@Override
	public void updatePwd(int uid, String oldPwd, String newPwd) {
		try {
			User u = userDao.load(uid);
			if (!SecurityUtil.md5(u.getUsername(), oldPwd).equals(u.getPassword())) {
				throw new CmsException("原始密码输入不正确");
			}
			u.setPassword(SecurityUtil.md5(u.getUsername(), newPwd));
			userDao.update(u);
		} catch (NoSuchAlgorithmException e) {
			throw new CmsException("更新密码失败:" + e.getMessage());
		}
	}


}
