package tech.wetech.cms.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tech.wetech.basic.util.EnumUtils;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.RoleType;
import tech.wetech.cms.service.IRoleService;
import tech.wetech.cms.service.IUserService;

@Controller
@RequestMapping("/admin/role")
@AuthClass
public class RoleController {
	private IRoleService roleService;
	private IUserService userService;

	public IRoleService getRoleService() {
		return roleService;
	}
	@Inject
	public void setRoleService(IRoleService roleService) {
		this.roleService = roleService;
	}

	public IUserService getUserService() {
		return userService;
	}
	@Inject
	public void setUserService(IUserService userService) {
		this.userService = userService;
	}



	@RequestMapping("/roles")
	public String list(Model model) {
		model.addAttribute("roles", roleService.listRole());
		return "role/list";
	}
	
	@RequestMapping("/{id}")
	public String show(@PathVariable int id,Model model) {
		model.addAttribute(roleService.load(id));
		model.addAttribute("us",userService.listRoleUsers(id));
		return "role/show";
	}
	
	@RequestMapping("/delete/{id}")
	public String delete(@PathVariable int id) {
		roleService.delete(id);
		return "redirect:/admin/role/roles";
	}
	
	@RequestMapping("/clearUsers/{id}")
	public String clearUsers(@PathVariable int id) {
		roleService.deleteRoleUsers(id);
		return "redirect:/admin/role/roles";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute(new Role());
		model.addAttribute("types", EnumUtils.enum2Name(RoleType.class));
		return "role/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Role role) {
		roleService.add(role);
		return "redirect:/admin/role/roles";
	}
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.GET)
	public String update(@PathVariable int id,Model model) {
		model.addAttribute(roleService.load(id));
		model.addAttribute("types", EnumUtils.enum2Name(RoleType.class));
		return "role/update";
	}
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.POST)
	public String update(@PathVariable int id,Role role) {
		Role er = roleService.load(id);
		er.setName(role.getName());
		er.setRoleType(role.getRoleType());
		roleService.update(er);
		return "redirect:/admin/role/roles";
	}
}
