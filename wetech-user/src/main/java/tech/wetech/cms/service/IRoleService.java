package tech.wetech.cms.service;

import java.util.List;

import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.Role;

public interface IRoleService {
	public void add(Role role);
	public void delete(int id);
	public void update(Role role);
	public Role load(int id);
	public List<Role> listRole();
	public Pager<Role> findRole();
	public void deleteRoleUsers(int rid);
}
