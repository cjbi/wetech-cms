package tech.wetech.cms.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import tech.wetech.basic.dao.BaseDao;
import tech.wetech.basic.model.Pager;
import tech.wetech.cms.model.IndexPic;

@Repository("indexPicDao")
public class IndexPicDao extends BaseDao<IndexPic> implements IIndexPicDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<IndexPic> listIndexPicByNum(int num) {
		String hql = "from IndexPic where status=1 order by pos";
		return this.getSession().createQuery(hql)
					.setFirstResult(0).setMaxResults(num).list();
	}
	
	@Override
	public IndexPic add(IndexPic ip) {
		//让其他的元素的序号先增加1
		String hql = "update IndexPic ip set ip.pos=ip.pos+1 where pos>=?";
		this.getSession().createQuery(hql).setParameter(0, 1).executeUpdate();
		ip.setPos(1);
		super.add(ip);
		return ip;
	}
	
	public void delete(int id) {
		IndexPic ip = this.load(id);
		int pos = ip.getPos();
		String hql = "update IndexPic ip set ip.pos=ip.pos-1 where pos>?";
		this.getSession().createQuery(hql).setParameter(0, pos).executeUpdate();
		this.getSession().delete(ip);
	}

	@Override
	public Pager<IndexPic> findIndexPic() {
		return this.find("from IndexPic order by pos");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> listAllIndexPicName() {
		String hql = "select ip.newName from IndexPic ip";
		return this.getSession().createQuery(hql).list();
	}

	@Override
	public Map<String, Integer> getMinAdnMaxPos() {
		String hql = "select max(pos),min(pos) from IndexPic";
		Object[] obj = (Object[])this.getSession().createQuery(hql).uniqueResult();
		Map<String,Integer> mm = new HashMap<String,Integer>();
		mm.put("max", (Integer)obj[0]);
		mm.put("min", (Integer)obj[1]);
		return mm;
	}

	@Override
	public void updatePos(int id, int oldPos, int newPos) {
		IndexPic ip = this.load(id);
		if(oldPos==newPos) {
			return;
		}
		String hql = "";
		if(oldPos<newPos) {
			hql = "update IndexPic set pos=pos-1 where pos>? and pos<=?";
		} else {
			hql = "update IndexPic set pos=pos+1 where pos<? and pos>=?";
		}
		this.getSession().createQuery(hql)
			.setParameter(0, oldPos)
			.setParameter(1, newPos).executeUpdate();
		ip.setPos(newPos);
		this.update(ip);
	}


}
