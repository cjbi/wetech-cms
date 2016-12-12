package tech.wetech.cms.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import tech.wetech.basic.model.SystemContext;

public class SystemContextFilter implements Filter {
	// private Integer pageSize;

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		Integer offset = 0;
		Integer pageSize = 10;
		try {
			// pager.offset是pager-taglib的默认分页偏移量，start是datatables的默认分页偏移量，目前两种都用到了，所以这块要判断下
			offset = Integer.parseInt(req.getParameter("pager.offset") != null ? req.getParameter("pager.offset") : req.getParameter("start"));
			pageSize = Integer.parseInt(req.getParameter("order") != null ? "" : req.getParameter("length"));
		} catch (NumberFormatException e) {
		}
		try {
			SystemContext.setOrder(req.getParameter("order"));
			SystemContext.setSort(req.getParameter("sort"));
			SystemContext.setPageOffset(offset);
			SystemContext.setPageSize(pageSize);
			SystemContext.setRealPath(((HttpServletRequest) req).getSession().getServletContext().getRealPath("/"));
			chain.doFilter(req, resp);
		} finally {
			SystemContext.removeOrder();
			SystemContext.removeSort();
			SystemContext.removePageOffset();
			SystemContext.removePageSize();
			SystemContext.removeRealPath();
		}
	}

	@Override
	public void init(FilterConfig cfg) throws ServletException {
		// try {
		// pageSize = Integer.parseInt(cfg.getInitParameter("pageSize"));
		// } catch (NumberFormatException e) {
		// pageSize = 15;
		// }
	}

	@Override
	public void destroy() {

	}

}
