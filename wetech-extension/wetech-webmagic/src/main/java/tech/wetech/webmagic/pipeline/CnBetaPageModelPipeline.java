package tech.wetech.webmagic.pipeline;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import tech.wetech.webmagic.model.CnBeta;
import tech.wetech.wordpress.SimpleWordPressRpcClient;
import us.codecraft.webmagic.Task;
import us.codecraft.webmagic.pipeline.PageModelPipeline;

/**
 * cnBeta数据处理管线
 * @author cjb
 */
@Component("cnBetaPageModelPipeline")
public class CnBetaPageModelPipeline implements PageModelPipeline<CnBeta> {
	
	private List<CnBeta> cnBetas = new ArrayList<CnBeta>();
	
	@Inject	
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public void process(CnBeta cnBeta, Task task) {
		
		if(cnBeta != null) {
			System.out.println(cnBeta.getId()+":"+cnBeta.getNewsTitle());
			//如果数据库不存在，就添加到数据库
			if(!isExist(cnBeta.getId())) {
				String sql = "insert into t_cnbeta (id, author, content, date, introduction, news_title, url, news_where, create_date) values(?,?,?,?,?,?,?,?,?)";
				Object[] args = new Object[]{cnBeta.getId(), cnBeta.getAuthor(), cnBeta.getContent(), cnBeta.getDate(), 
						cnBeta.getIntroduction(), cnBeta.getNewsTitle(), cnBeta.getUrl(), cnBeta.getWhere(),new Date()};
				jdbcTemplate.update(sql, args);
				
				// 通过xmlrpc发布到wordpress
				Map<String, Object> params = new HashMap<>();
				params.put("post_title", cnBeta.getNewsTitle());
				params.put("post_excerpt", cnBeta.getIntroduction());
				params.put("post_content", cnBeta.getContent());
				List<String> categories = new ArrayList<>();
				categories.add("cnBeta");
				params.put("terms_names", Collections.singletonMap("category", categories));
				SimpleWordPressRpcClient.sendRequest("wp.newPost", params);
				cnBetas.add(cnBeta);
			}
		}
	}
	
	private boolean isExist(int id) {
		String sql = "select * from t_cnbeta where id=?";
		Object[] args = new Object[]{id};
//		CnBeta cnBeta = jdbcTemplate.queryForObject(sql,args, new BeanPropertyRowMapper<CnBeta>(CnBeta.class));
		List<CnBeta> cnBetas = jdbcTemplate.query(sql, args, new BeanPropertyRowMapper<CnBeta>(CnBeta.class));
		if(cnBetas.size()>0) {
			return true;
		} 
		return false;
	}
	
	public List<CnBeta> getResult() {
		return cnBetas;
	}

}
