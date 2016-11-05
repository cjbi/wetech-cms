package tech.wetech.cms.dao;

import java.util.List;

import tech.wetech.basic.dao.IBaseDao;
import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.Role;


public interface IRoleDao extends IBaseDao<Role> {
	public List<Role> listRole();
	public Pager<Role> findRole();
	public void deleteRoleUsers(int rid);
}
