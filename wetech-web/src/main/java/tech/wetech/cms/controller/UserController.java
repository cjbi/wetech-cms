package tech.wetech.cms.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.auth.AuthMethod;
import tech.wetech.cms.dto.UserDto;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.RoleType;
import tech.wetech.cms.model.User;
import tech.wetech.cms.service.IChannelService;
import tech.wetech.cms.service.IGroupService;
import tech.wetech.cms.service.IRoleService;
import tech.wetech.cms.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/user")
@AuthClass("login")
public class UserController {
	private IUserService userService;
	private IGroupService groupService;
	private IRoleService roleService;
	private IChannelService channelService;
	
	
	public IChannelService getChannelService() {
		return channelService;
	}
	@Inject
	public void setChannelService(IChannelService channelService) {
		this.channelService = channelService;
	}
	public IGroupService getGroupService() {
		return groupService;
	}
	@Inject
	public void setGroupService(IGroupService groupService) {
		this.groupService = groupService;
	}

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

	@RequestMapping("/users")
	public String list(Model model) {
		model.addAttribute("datas",userService.findUser());
		return "user/list";
	}
	
	private void initAddUser(Model model) {
		model.addAttribute("roles",roleService.listRole());
		model.addAttribute("groups", groupService.listGroup());
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("userDto",new UserDto());//user,user
		initAddUser(model);
		return "user/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(@Valid UserDto userDto,BindingResult br,Model model) {
		if(br.hasErrors()) {
			initAddUser(model);
			return "user/add";
		}
		userService.add(userDto.getUser(), userDto.getRoleIds(), userDto.getGroupIds());
		return "redirect:/admin/user/users";
	}
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.GET)
	public String update(@PathVariable int id,Model model) {
		User u = userService.load(id);
		model.addAttribute("userDto",new UserDto(u,
				userService.listUserRoleIds(id),
				userService.listUserGroupIds(id)));//user,user
		initAddUser(model);
		return "user/update";
	}
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.POST)
	public String update(@PathVariable int id,@Valid UserDto userDto,BindingResult br,Model model) {
		if(br.hasErrors()) {
			System.out.println(br.hasErrors());
			initAddUser(model);
			return "user/update";
		}
		User ou = userService.load(id);
		ou.setNickname(userDto.getNickname());
		ou.setPhone(userDto.getPhone());
		ou.setEmail(userDto.getEmail());
		ou.setStatus(userDto.getStatus());
		userService.update(ou, userDto.getRoleIds(), userDto.getGroupIds());
		return "redirect:/admin/user/users";
	}
	
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	public String delete(@PathVariable int id) {
		userService.delete(id);
		return "redirect:/admin/user/users";
	}
	
	@RequestMapping(value="/updateStatus/{id}",method=RequestMethod.GET)
	public String updateStatus(@PathVariable int id) {
		userService.updateStatus(id);
		return "redirect:/admin/user/users";
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String show(@PathVariable int id,Model model) {
		model.addAttribute(userService.load(id));
		model.addAttribute("gs",userService.listUserGroups(id));
		model.addAttribute("rs",userService.listUserRoles(id));
		return "user/show";
	}
	
	@RequestMapping("/showSelf")
	@AuthMethod
	public String showSelf(Model model,HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		model.addAttribute(user);
		model.addAttribute("gs",userService.listUserGroups(user.getId()));
		model.addAttribute("rs",userService.listUserRoles(user.getId()));
		return "user/show";
	}
	
	@RequestMapping(value="/updatePwd",method=RequestMethod.GET)
	@AuthMethod
	public String updatePwd(Model model,HttpSession session) {
		User u = (User)session.getAttribute("loginUser");
		model.addAttribute(u);
		return "user/updatePwd";
	}
	
	@RequestMapping(value="/updatePwd",method=RequestMethod.POST)
	@AuthMethod
	public String updatePwd(int id,String oldPwd,String password) {
		userService.updatePwd(id, oldPwd, password);
		return "redirect:/admin/user/showSelf";
	}
	
	/*@RequestMapping(value="/updatePwd",method=RequestMethod.POST)
	public String updatePwd(Model model,HttpSession session) {
		User u = (User)session.getAttribute("loginUser");
		model.addAttribute(u);
		return "user/updatePwd";
	}*/
	
	
	@RequestMapping(value="/updateSelf",method=RequestMethod.GET)
	@AuthMethod
	public String updateSelf(Model model,HttpSession session) {
		User u = (User)session.getAttribute("loginUser");
		model.addAttribute(new UserDto(u));
		return "user/updateSelf";
	}
	
	@RequestMapping(value="/updateSelf",method=RequestMethod.POST)
	@AuthMethod
	public String updateSelf(@Valid UserDto userDto,BindingResult br,Model model,HttpSession session) {
		if(br.hasErrors()) {
			return "user/updateSelf";
		}
		User ou = userService.load(userDto.getId());
		ou.setNickname(userDto.getNickname());
		ou.setPhone(userDto.getPhone());
		ou.setEmail(userDto.getEmail());
		userService.update(ou);
		session.setAttribute("loginUser", ou);
		return "redirect:/admin/user/showSelf";
	}
	
	@RequestMapping("/listChannels/{uid}")
	public String listChannels(@PathVariable int uid,Model model) {
		model.addAttribute(userService.load(uid));
		List<Role> rs = userService.listUserRoles(uid);
		for(Role r:rs) {
			if(r.getRoleType()==RoleType.ROLE_ADMIN) {
				model.addAttribute("uAdmin",1);
			}
		}
		return "/user/listChannel";
	}
	
	@RequestMapping("/userTree/{uid}")
	public @ResponseBody List<ChannelTree> groupTree(@PathVariable Integer uid,@RequestParam Integer isAdmin) {
		if(isAdmin!=null&&isAdmin==1) {
			return channelService.generateTree();
		}
		return groupService.generateUserChannelTree(uid);
	}
	
}
