package tech.wetech.cms.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import tech.wetech.basic.dao.BaseDao;
import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.CmsLink;

@Repository("cmsLinkDao")
public class CmsLinkDao extends BaseDao<CmsLink> implements ICmsLinkDao {
	
	public CmsLink add(CmsLink cl) {
		Map<String,Integer> m = this.getMinAndMaxPos();
		if(m.get("max")==null) {
			cl.setPos(1);
		} else {
			cl.setPos(m.get("max")+1);
		}
		this.getSession().save(cl);
		return cl;
	}

	/**
	 * 需要更新排序的位置
	 */
	@Override
	public void delete(int id) {
		CmsLink cl = this.load(id);
		String hql = "update CmsLink set pos=pos-1 where pos>?";
		this.getSession().createQuery(hql).setParameter(0,cl.getPos()).executeUpdate();
		this.getSession().delete(cl);
	}


	@Override
	public Pager<CmsLink> findByType(String type) {
		String hql = null;
		if(type==null||"".equals(type.trim())) {
			hql = "from CmsLink";
		} else {
			hql = "from CmsLink where type='"+type+"'";
		}
		hql+=" order by pos";
		return this.find(hql);
	}

	@Override
	public List<CmsLink> listByType(String type) {
		return this.list("from CmsLink where type=? order by pos",type);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> listAllType() {
		String hql = "select type from CmsLink group by type";
		return (List<String>)this.getSession().createQuery(hql).list();
	}

	@Override
	public Map<String, Integer> getMinAndMaxPos() {
		String hql = "select max(pos),min(pos) from CmsLink";
		Object[] objs = (Object[])this.getSession().createQuery(hql).uniqueResult();
		Map<String,Integer> m = new HashMap<String,Integer>();
		m.put("min", (Integer)objs[1]);
		m.put("max", (Integer)objs[0]);
		return m;
	}

	@Override
	public void updatePos(int id, int oldPos, int newPos) {
		CmsLink cl = this.load(id);
		if(oldPos==newPos) {
			return;
		}
		String hql = "";
		if(oldPos<newPos) {
			hql = "update CmsLink set pos=pos-1 where pos>? and pos<=?";
		} else {
			hql = "update CmsLink set pos=pos+1 where pos<? and pos>=?";
		}
		this.getSession().createQuery(hql)
			.setParameter(0, oldPos)
			.setParameter(1, newPos).executeUpdate();
		cl.setPos(newPos);
		this.update(cl);
	}

}
