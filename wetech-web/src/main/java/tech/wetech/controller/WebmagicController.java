package tech.wetech.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import tech.wetech.service.ICnBetaService;
import tech.wetech.webmagic.model.CnBeta;

@Controller
@RequestMapping("/console")
public class WebmagicController {
	
	@Inject
	private ICnBetaService cnBetaService;
	
	@RequestMapping("/webmagic")
	public String webmagic() {
		return "/console/webmagic";
	}
	
	@RequestMapping("fetchCnBetaPage2Wordpress")
	public String fetchCnBetaPage2Wordpress(HttpServletRequest request) {
		List<CnBeta> cnBetas = cnBetaService.fetchCnBetaPage2Wordpress();
		int count = cnBetas.size();
		request.setAttribute("msg", "成功的条数："+count);
		return "redirect:/console/webmagic";
	}

}
