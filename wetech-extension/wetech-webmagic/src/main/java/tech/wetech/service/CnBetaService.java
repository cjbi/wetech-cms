package tech.wetech.service;

import java.util.List;
import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import tech.wetech.webmagic.model.CnBeta;
import tech.wetech.webmagic.pipeline.CnBetaPageModelPipeline;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.model.OOSpider;

/**
 * @author cjb
 */
@Service("cnBetaService")
public class CnBetaService implements ICnBetaService {

	@Inject
	private CnBetaPageModelPipeline cnBetaPageModelPipeline;

	@Override
	@Scheduled(cron = "0 0 3 * * ?") // Spring 定时任务
	public List<CnBeta> fetchCnBetaPage2Wordpress() {
		// 启动爬虫
		OOSpider.create(Site.me().setSleepTime(1000), cnBetaPageModelPipeline, CnBeta.class)
				.addUrl("http://www.cnbeta.com").thread(5).run();
		System.out.println("====================SUCCESS====================");
		return cnBetaPageModelPipeline.getResult();
	}

}
