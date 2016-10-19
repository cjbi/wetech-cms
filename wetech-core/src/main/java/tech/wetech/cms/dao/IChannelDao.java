package tech.wetech.cms.dao;


import java.util.List;

import tech.wetech.basic.dao.IBaseDao;
import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.ChannelType;


public interface IChannelDao extends IBaseDao<Channel> {
	/**
	 * 根据父id获取所有的子栏目
	 * @param pid
	 * @return
	 */
	public List<Channel> listByParent(Integer pid);
	/**
	 * 获取子栏目的最大的排序号
	 * @param pid
	 * @return
	 */
	public int getMaxOrderByParent(Integer pid);
	/**
	 * 把所有的栏目获取并生成一颗完整的树
	 * @return
	 */
	public List<ChannelTree> generateTree();
	/**
	 * 根据父类对象获取子类栏目，并且生成树列表
	 * @param pid
	 * @return
	 */
	public List<ChannelTree> generateTreeByParent(Integer pid);
	/**
	 * 通过一个数组来完成排序
	 * @param ids
	 */
	public void updateSort(Integer[] ids);
	/**
	 * 所有的可以发布文章的栏目，栏目的状态必须为启用状态
	 * @return
	 */
	public List<Channel> listPublishChannel();
	/**
	 * 根据栏目类型获取所有的首页栏目
	 * @return
	 */
	public List<Channel> listAllIndexChannel(ChannelType ct);
	
	public List<Channel> listTopNavChannel();
	/**
	 * 删除频道和组的对应关系
	 * @param cid
	 * @return
	 */
	public void deleteChannelGroups(int cid);
	/**
	 * 获取导航栏目中的第一个栏目
	 * @param cid
	 * @return
	 */
	public Channel loadFirstChannelByNav(int cid);
	
	public List<Channel> listUseChannelByParent(Integer cid);
	/**
	 * 通过类型来获取所有未停用的栏目
	 * @param ct
	 * @return
	 */
	public List<Channel> listChannelByType(ChannelType ct);
}
