package tech.wetech.cms.dao;


import java.util.List;

import tech.wetech.basic.dao.IBaseDao;
import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.Topic;


public interface ITopicDao extends IBaseDao<Topic>{
	/**
	 * 根据栏目和标题和状态进行文章的检索
	 * @param cid
	 * @param title
	 * @return
	 */
	public Pager<Topic> find(Integer cid,String title,Integer status);
	/**
	 * 根据用户，栏目和标题和状态进行检索
	 * @param uid
	 * @param cid
	 * @param title
	 * @return
	 */
	public Pager<Topic> find(Integer uid,Integer cid,String title,Integer status);
	/**
	 * 根据关键字进行文章的检索，仅仅只是检索关键字类似的
	 * @param keyword
	 * @return
	 */
	public Pager<Topic> searchTopicByKeyword(String keyword);
	/**
	 * 通过某个条件来检索，该条件会在标题，内容和摘要中检索
	 * @param con
	 * @return
	 */
	public Pager<Topic> searchTopic(String con);
	/**
	 * 检索某个栏目的推荐文章，如果cid为空，表示检索全部的文章
	 * @param ci
	 * @return
	 */
	public Pager<Topic> findRecommendTopic(Integer ci);
	/**
	 * 根据栏目和文章的数量获取该栏目中的文章
	 * @param cid
	 * @param num
	 * @return
	 */
	public List<Topic> listTopicByChannelAndNumber(int cid,int num);
	
	public List<Topic> listTopicsByChannel(int cid);
	/**
	 * 判断所添加文章的栏目是否需要进行更新
	 * @param cid
	 * @return
	 */
	public boolean isUpdateIndex(int cid);
	/**
	 * 获取某个栏目中的最新的可用文章
	 * @param cid
	 * @return
	 */
	public Topic loadLastedTopicByColumn(int cid);
	/**
	 * 根据数目获取最新的可用文章
	 * @param num
	 * @return
	 */
	public List<Topic> listTopicsByNumber( int num);
}
