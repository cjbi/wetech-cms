package tech.wetech.cms.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import tech.wetech.basic.dao.BaseDao;
import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.*;

@Repository("groupDao")
public class GroupDao extends BaseDao<Group> implements IGroupDao {

	@Override
	public List<Group> listGroup() {
		return this.list("from Group");
	}

	@Override
	public Pager<GroupFindModel> findGroup() {
		String sql = "select * from (select a.*,(select count(id) from t_user_group b where a.id=b.g_id) as userCount from t_group a) as t";
		return this.findBySql(sql,GroupFindModel.class,false);
	}

	@Override
	public void deleteGroupUsers(int gid) {
		this.updateByHql("delete UserGroup ug where ug.group.id=?",gid);
	}

	@Override
	public void addGroupChannel(Group group, Channel channel) {
		GroupChannel gc = this.loadGroupChannel(group.getId(), channel.getId());
		if(gc!=null) return;
		gc = new GroupChannel();
		gc.setGroup(group);
		gc.setChannel(channel);
		this.getSession().save(gc);
	}

	@Override
	public GroupChannel loadGroupChannel(int gid, int cid) {
		return (GroupChannel)this.queryObject("from GroupChannel where group.id=? and channel.id=?",
				new Object[]{gid,cid});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> listGroupChannelIds(int gid) {
		String hql = "select gc.channel.id from GroupChannel gc where gc.group.id=?";
		return this.getSession().createQuery(hql).setParameter(0, gid).list();
	}

	@Override
	public List<ChannelTree> generateGroupChannelTree(int gid) {
		String sql = "select c.id as id,c.name as name,c.pid as pid from " +
				"t_group_channel gc left join t_channel c on(gc.c_id=c.id) " +
				"where gc.g_id=?";
		List<ChannelTree> cts = this.listBySql(sql,gid,ChannelTree.class, false);
		ChannelDao.initTreeNode(cts);
		return cts;
	}

	@Override
	public List<ChannelTree> generateUserChannelTree(int uid) {
		String sql = "select distinct c.id as id,c.name as name,c.pid as pid from " +
				"t_group_channel gc left join t_channel c on(gc.c_id=c.id) left join t_user_group ug on(ug.g_id=gc.g_id)" +
				"where ug.u_id=?";
		List<ChannelTree> cts = this.listBySql(sql,uid,ChannelTree.class, false);
		ChannelDao.initTreeNode(cts);
		return cts;
	}

	@Override
	public void clearGroupChannel(int gid) {
		this.updateByHql("delete GroupChannel gc where gc.group.id=?",gid);
	}

	@Override
	public void deleteGroupChannel(int gid, int cid) {
		this.updateByHql("delete GroupChannel gc where gc.group.id=? and gc.channel.id=?",new Object[]{gid,cid});
	}

}
