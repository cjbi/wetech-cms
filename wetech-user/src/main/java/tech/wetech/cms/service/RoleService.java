package tech.wetech.cms.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tech.wetech.cms.dao.IRoleDao;
import tech.wetech.cms.dao.IUserDao;
import tech.wetech.cms.model.CmsException;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.User;

@Service("roleService")
public class RoleService implements IRoleService {
	private IRoleDao roleDao;
	private IUserDao userDao;
	
	
	public IRoleDao getRoleDao() {
		return roleDao;
	}
	@Inject
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public IUserDao getUserDao() {
		return userDao;
	}
	@Inject
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public void add(Role role) {
		roleDao.add(role);
	}

	@Override
	public void delete(int id) {
		List<User> us = userDao.listRoleUsers(id);
		if(us!=null&&us.size()>0) throw new CmsException("删除的角色对象中还有用户，不能删除");
		roleDao.delete(id);
	}

	@Override
	public void update(Role role) {
		roleDao.update(role);
	}

	@Override
	public Role load(int id) {
		return roleDao.load(id);
	}

	@Override
	public List<Role> listRole() {
		return roleDao.listRole();
	}

	@Override
	public void deleteRoleUsers(int rid) {
		roleDao.deleteRoleUsers(rid);
	}

}
