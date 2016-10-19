package tech.wetech.cms.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import tech.wetech.basic.dao.BaseDao;
import tech.wetech.cms.model.Role;

@Repository("roleDao")
public class RoleDao extends BaseDao<Role> implements IRoleDao {

	@Override
	public List<Role> listRole() {
		return this.list("from Role");
	}

	@Override
	public void deleteRoleUsers(int rid) {
		this.updateByHql("delete UserRole ur where ur.role.id=?",rid);
	}


}
