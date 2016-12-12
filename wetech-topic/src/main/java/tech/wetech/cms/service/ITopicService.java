package tech.wetech.cms.service;

import java.util.List;
import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.Topic;

public interface ITopicService {
	/**
	 * 添加带有附件信息的文章
	 * @param topic 文章对象
	 * @param cid 文章的栏目
	 * @param uid 文章的用户
	 * @param aids 文章的附件id数组
	 */
	public void add(Topic topic,int cid,int uid,Integer[] aids);
	/**
	 * 添加不带附件信息的文章对象
	 * @param topic
	 * @param cid
	 * @param uid
	 */
	public void add(Topic topic,int cid,int uid);
	
	/**
	 * 删除文章，先删除文章的附件信息，还得删除附件的文件对象
	 * @param id
	 */
	public void delete(int id);
	/**
	 * 更新文章，带附件信息更新
	 * @param topic
	 * @param cid
	 * @param aids
	 */
	public void update(Topic topic,int cid,Integer[] aids);
	/**
	 * 没有带附件信息的文章更新
	 * @param topic
	 */
	public void update(Topic topic,int cid);
	/**
	 * 更新文章的状态
	 * @param tid
	 */
	public void updateStatus(int tid);
	
	public Topic load(int id);
	
	/**
	 * 根据标题和状态进行文章的检索
	 * @param title
	 * @param status
	 * @return
	 */
	public Pager<Topic> find(String title, Integer status);
	
	/**
	 * 根据栏目和标题和状态进行文章的检索
	 * @param cid
	 * @param title
	 * @return
	 */
	public Pager<Topic> find(Integer cid,String title,Integer status);
	/**
	 * 根据用户、栏目、标题题和状态进行检索
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
	
	public List<Topic> listTopicByChannelAndNumber(int cid,int num);
	
	public List<Topic> listTopicByChannel(int cid);
	
	/**
	 * 判断所添加文章的栏目是否需要进行更新
	 * @param cid
	 * @return
	 */
	public boolean isUpdateIndex(int cid);
	
	public Topic loadLastedTopicByColumn(int cid);
	/**
	 * 通过数量获取最新的文章
	 * @param num
	 * @return
	 */
	public List<Topic> listTopicsByNumber(int num);
	/**
	 * 通过数量获取推荐的文章
	 * @param num
	 * @return
	 */
	public List<Topic> listRecommendTopicByNumber(int num);
}
