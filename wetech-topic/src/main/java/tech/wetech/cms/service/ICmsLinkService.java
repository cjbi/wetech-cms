package tech.wetech.cms.service;

import java.util.List;
import java.util.Map;

import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.CmsLink;

public interface ICmsLinkService {
	public void add(CmsLink cl);
	public void delete(int id);
	public void update(CmsLink cl);
	public CmsLink load(int id);
	/**
	 * 根据类型获取超链接，如果type为空就获取所有的超链接，排序方式根据pos
	 * @param type
	 * @return
	 */
	public Pager<CmsLink> findByType(String type);
	/**
	 * 获取某个类型中的所有链接，不进行分页
	 * @param type
	 * @return
	 */
	public List<CmsLink> listByType(String type);
	/**
	 * 获取超链接的所有类型
	 * @return
	 */
	public List<String> listAllType();
	/**
	 * 获取最大和最小的排序号
	 * @return
	 */
	public Map<String,Integer> getMinAndMaxPos();
	/**
	 * 更新排序
	 * @param id
	 * @param oldPos
	 * @param newPos
	 */
	public void updatePos(int id,int oldPos,int newPos);
	
}
