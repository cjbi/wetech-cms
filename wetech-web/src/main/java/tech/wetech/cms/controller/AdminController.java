package tech.wetech.cms.controller;

import javax.servlet.http.HttpSession;

import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.auth.AuthMethod;
import tech.wetech.cms.web.CmsSessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AuthClass("login")
public class AdminController {

	@RequestMapping("/admin")
	@AuthMethod
	public String main() {
		return "admin/main";
	}
	
	@AuthMethod
	@RequestMapping("/admin/logout")
	public String logout(HttpSession session) {
		CmsSessionContext.removeSession(session);
		session.invalidate();
		return "redirect:/login";
	}
}
