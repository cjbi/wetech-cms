package tech.wetech.service;

import java.util.List;

import tech.wetech.webmagic.model.CnBeta;

public interface ICnBetaService {
	
	/**抓取cnBeta网页并发布到wordpress **/
	public List<CnBeta> fetchCnBetaPage2Wordpress();
	
}
