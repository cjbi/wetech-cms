package tech.wetech.cms.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tech.wetech.basic.model.SystemContext;
import tech.wetech.basic.util.BackupFileUtil;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.service.IIndexService;

@AuthClass
@Controller
@RequestMapping("/admin/backup")
public class BackupController {
	
	@Inject
	private IIndexService indexService;
	
	@RequestMapping({ "/backup", "/", "" })
	public String backup(Model model) {
		return "admin/backup";
	}
	
	
	
	/*---------------------------------------------------*/
	
	@RequestMapping(value="/backup/add",method=RequestMethod.GET)
	public String backup() {
		return "backup/add";
	}
	
	@RequestMapping(value="/backup/add",method=RequestMethod.POST)
	public String backup(String backupFilename) {
		BackupFileUtil bfu = BackupFileUtil.getInstance(SystemContext.getRealPath());
		bfu.backup(backupFilename);
		return "redirect:/admin/backups";
	}
	
	@RequestMapping(value="/backups")
	public String list(Model model) {
		BackupFileUtil bfu = BackupFileUtil.getInstance(SystemContext.getRealPath());
		model.addAttribute("backups",bfu.listBackups());
		return "backup/list";
	}
	
	@RequestMapping("delete/{name}")
	public String delete(@PathVariable String name,String type) {
		BackupFileUtil bfu = BackupFileUtil.getInstance(SystemContext.getRealPath());
		bfu.delete(name+"."+type);
		return "redirect:/admin/backups";
	}
	
	@RequestMapping("resume/{name}")
	public String resume(@PathVariable String name,String type) {
		BackupFileUtil bfu = BackupFileUtil.getInstance(SystemContext.getRealPath());
		bfu.resume(name+"."+type);
		indexService.generateTop();
		indexService.generateBody();
		indexService.generateBottom();
		return "redirect:/admin/backups";
	}
	
}
