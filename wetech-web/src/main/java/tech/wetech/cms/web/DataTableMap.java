package tech.wetech.cms.web;

import java.util.HashMap;
import java.util.Map;

import tech.wetech.basic.model.Pager;

/**
 * @author cjbi
 */
public class DataTableMap {

	/**
	 * 将数据封装为map，以便传到前台供datatables读取数据；支持后台分页
	 * @param pager 分页对象
	 *  json.sEcho Tracking flag for DataTables to match requests
	 *  json.iTotalRecords Number of records in the data set, not accounting for filtering
	 *  json.iTotalDisplayRecords Number of records in the data set, accounting for filtering
	 *  json.aaData The data to display on this page
	 *  [json.sColumns] Column ordering (sName, comma separated)
	 * @return Data the data from the server (nuking the old) and redraw the table
	 */
	public static Map<String,Object> getMapData(Pager<?>  pager){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("aaData", pager.getDatas().toArray());
//		map.put("sEcho","1");
		map.put("iTotalRecords",pager.getTotal());
		map.put("iTotalDisplayRecords",pager.getTotal());
		return map;
	}

}

