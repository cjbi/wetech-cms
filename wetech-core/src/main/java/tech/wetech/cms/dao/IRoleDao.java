package tech.wetech.cms.dao;

import java.util.List;

import tech.wetech.basic.dao.IBaseDao;
import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.RoleFindModel;

public interface IRoleDao extends IBaseDao<Role> {
	public List<Role> listRole();
	public Pager<RoleFindModel> findRole();
	public void deleteRoleUsers(int rid);
}
