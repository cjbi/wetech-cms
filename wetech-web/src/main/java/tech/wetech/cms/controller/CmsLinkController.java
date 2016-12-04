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

	/*------------------------------------------------------------*/
	@RequestMapping("/links")
	public String list(Model model, String type) {
		model.addAttribute("datas", cmsLinkService.findByType(type));
		model.addAttribute("types", cmsLinkService.listAllType());
		Map<String, Integer> m = cmsLinkService.getMinAndMaxPos();
		model.addAttribute("min", m.get("min"));
		model.addAttribute("max", m.get("max"));
		return "cmsLink/list";
	}

	/*@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute(new CmsLink());
		model.addAttribute("types", cmsLinkService.listAllType());
		return "cmsLink/add";
	}*/

	/*@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(@Validated CmsLink cmsLink, BindingResult br) {
		if (br.hasFieldErrors()) {
			return "cmsLink/add";
		}
		cmsLinkService.add(cmsLink);
		return "redirect:/admin/cmsLink/links";
	}*/

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable int id) {
		cmsLinkService.delete(id);
		return "redirect:/admin/cmsLink/links";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String update(@PathVariable int id, Model model) {
		model.addAttribute(cmsLinkService.load(id));
		model.addAttribute("types", cmsLinkService.listAllType());
		return "cmsLink/update";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	public String update(@PathVariable int id, @Validated CmsLink cmsLink, BindingResult br) {
		if (br.hasFieldErrors()) {
			return "cmsLink/update";
		}
		CmsLink tcl = cmsLinkService.load(id);
		tcl.setNewWin(cmsLink.getNewWin());
		tcl.setTitle(cmsLink.getTitle());
		tcl.setType(cmsLink.getType());
		tcl.setUrl(cmsLink.getUrl());
		tcl.setUrlClass(cmsLink.getUrlClass());
		tcl.setUrlId(cmsLink.getUrlId());
		cmsLinkService.update(tcl);
		return "redirect:/admin/cmsLink/links";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String show(@PathVariable int id, Model model) {
		model.addAttribute(cmsLinkService.load(id));
		return "cmsLink/show";
	}
}
