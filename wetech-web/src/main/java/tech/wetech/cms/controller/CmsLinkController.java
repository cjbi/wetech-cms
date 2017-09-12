package tech.wetech.cms.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.model.CmsLink;
import tech.wetech.cms.service.ICmsLinkService;
import tech.wetech.cms.service.IIndexService;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

@Controller
@AuthClass
@RequestMapping("/admin/cmsLink")
public class CmsLinkController {

	@Inject
	private ICmsLinkService cmsLinkService;
	@Inject
	private IIndexService indexService;

	@RequestMapping({ "/cmsLink", "/", "" })
	public String cmsLink(Model model) {
		return "admin/cmsLink";
	}
	
	@ResponseBody
	@RequestMapping("/getMinAndMaxPos")
	public Map<String, Integer> getMinAndMaxPos() {
		return cmsLinkService.getMinAndMaxPos();
	}
	
	@ResponseBody
	@RequestMapping("/listAllType")
	public List<String> listAllType() {
		return cmsLinkService.listAllType();
	}
	
	
	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(String type) {
		return DataTableMap.getMapData(cmsLinkService.findByType(type));
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseData add(@Validated CmsLink cl, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		cmsLinkService.add(cl);
		//生成首页静态化
		indexService.generateCmsLink();
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ResponseData edit( @Validated  CmsLink cl, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		CmsLink ocl = cmsLinkService.load(cl.getId());
		ocl.setId(ocl.getId());
		ocl.setNewWin(cl.getNewWin());
		ocl.setPos(cl.getPos());
		ocl.setTitle(cl.getTitle());
		ocl.setType(cl.getType());
		ocl.setUrl(cl.getUrl());
		ocl.setUrlClass(cl.getUrlClass());
		ocl.setUrlId(cl.getUrlId());
		cmsLinkService.update(ocl);
		//生成首页静态化
		indexService.generateCmsLink();
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete")
	public ResponseData delete(Long[] ids) {
		for (Long id : ids) {
			cmsLinkService.delete(id.intValue());
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

}
