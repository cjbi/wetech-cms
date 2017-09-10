package tech.wetech.cms.service;

import java.util.List;

import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.RoleFindModel;

public interface IRoleService {
	public void add(Role role);
	public void delete(int id);
	public void update(Role role);
	public Role load(int id);
	public List<Role> listRole();
	public Pager<RoleFindModel> findRole();
	public void deleteRoleUsers(int rid);
}
