package tech.wetech.cms.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import tech.wetech.basic.dao.BaseDao;
import tech.wetech.basic.model.Pager;
import tech.wetech.basic.util.*;
import tech.wetech.cms.model.Keyword;

@Repository("keywordDao")
public class KeywordDao extends BaseDao<Keyword> implements IKeywordDao {
	
	@SuppressWarnings("unchecked")
	private Map<String,Integer> getExistKeyword2Map() {
		String hql = "select t.keyword from Topic t";
		List<String> allKeys = this.getSession().createQuery(hql).list();
		Map<String,Integer> keys = new HashMap<String,Integer>();
		for(String ak:allKeys) {
			String[] ks = ak.split("\\|");
			for(String k:ks) {
				if("".equals(k.trim())) continue;
				if(keys.containsKey(k)) {
					keys.put(k, keys.get(k)+1);
				} else {
					keys.put(k, 1);
				}
			}
		}
		return keys;
	}
	
	private Set<String> getExistKeywords() {
		return getExistKeyword2Map().keySet();
	}

	@Override
	public Pager<Keyword> findNoUseKeyword() {
		String hql = "from Keyword where name not in (:ks)";
		//得到一组存在的关键字的名称
		Set<String> ks = getExistKeywords();
		Map<String,Object> alias = new HashMap<String,Object>();
		alias.put("ks", ks);
		return this.findByAlias(hql, alias);
	}

	@Override
	public void clearNoUseKeyword() {
		String hql = "delete Keyword k where k.name not in(:ks)";
		//得到一组存在的关键字的名称
		Set<String> ks = getExistKeywords();
		this.getSession().createQuery(hql).setParameterList("ks", ks).executeUpdate();
	}

	@Override
	public List<Keyword> findUseKeyword() {
		Map<String,Integer> allKeys = getExistKeyword2Map();
		Set<String> keys = allKeys.keySet();
		List<Keyword> ks = new ArrayList<Keyword>();
		for(String k:keys) {
			ks.add(new Keyword(k,allKeys.get(k)));
		}
		Collections.sort(ks);
		return ks;
	}

	@Override
	public List<Keyword> listKeywordByCon(String con) {
		String hql = "from Keyword where " +
				"name like '%"+con+"%' or nameFullPy like '%"+con+"%' or nameShortPy like '%"+con+"%'";
		return this.list(hql);
	}

	@Override
	public void addOrUpdate(String name) {
		Keyword k = (Keyword)this.queryObject("from Keyword where name=?", name);
		if(k==null) {
			k = new Keyword();
			k.setName(name);
			k.setNameFullPy(PinyinUtil.str2Pinyin(name, null));
			k.setNameShortPy(PinyinUtil.strFirst2Pinyin(name));
			k.setTimes(1);
			this.add(k);
		} else {
			k.setTimes(k.getTimes()+1);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> listKeywordStringByCon(String con) {
		String hql = "select name from Keyword where " +
				"name like '%"+con+"%' or nameFullPy like '%"+con+"%' or nameShortPy like '%"+con+"%'";
		return this.getSession().createQuery(hql).list();
	}

}
