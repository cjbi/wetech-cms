package tech.wetech.cms.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;
import tech.wetech.basic.util.JsonUtil;
import tech.wetech.cms.auth.AuthMethod;
import tech.wetech.cms.dto.AjaxObj;
import tech.wetech.cms.dto.IndexPicDto;
import tech.wetech.cms.model.BaseInfo;
import tech.wetech.cms.model.IndexPic;
import tech.wetech.cms.service.IAttachmentService;
import tech.wetech.cms.service.IIndexPicService;
import tech.wetech.cms.service.IIndexService;
import tech.wetech.cms.web.BaseInfoUtil;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

@Controller
@RequestMapping("/admin/pic")
public class IndexPicController {

	@Inject
	private IIndexPicService indexPicService;
	@Inject
	private IAttachmentService attachmentService;
	@Inject
	private IIndexService indexService;

	public final static String FILE_PATH = "/resources/indexPic";
	public final static int T_W = 120;

	private void initIndexPic(Model model) {
		Map<String, Integer> mm = indexPicService.getMinAdnMaxPos();
		model.addAttribute("min", mm.get("min"));
		model.addAttribute("max", mm.get("max"));
	}

	@RequestMapping("/indexPic")
	public String indexPic(Model model) {
		initIndexPic(model);
		return "admin/indexPic/indexPic";
	}

	@ResponseBody
	@RequestMapping("/listIndexPic")
	public Map<String, Object> listIndexPic() {
		return DataTableMap.getMapData(indexPicService.findIndexPic());
	}

	@RequestMapping(value = "/indexPic/add", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	public String add(Model model) {
		return "admin/indexPic/add";
	}

	@RequestMapping(value = "/indexPic/edit/{id}", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	public String edit(@PathVariable int id, Model model) {
		model.addAttribute("indexPic", indexPicService.load(id));
		return "admin/indexPic/edit";
	}

	@ResponseBody
	@RequestMapping(value = "/indexPic/add", method = RequestMethod.POST)
	public ResponseData add(@Validated IndexPic indexPic, HttpSession session, BindingResult br, MultipartFile image) {
		if (br.hasFieldErrors()) {
			return ResponseData.FAILED_NO_DATA;
		}
		// 处理图片流数据
		String realPath = session.getServletContext().getRealPath("");
		String oldName = image.getOriginalFilename();
		String newName = new Date().getTime() + "." + FilenameUtils.getExtension(oldName);

		try {
			// 对图片流进行压缩，生成文件和缩略图保存到指定文件夹
			writeIndexPic(realPath, newName, image.getInputStream());
		} catch (IOException e) {
			e.printStackTrace();
			return new ResponseData(false, e.getMessage());
		}

		indexPic.setOldName(oldName);
		indexPic.setNewName(newName);
		indexPicService.add(indexPic);
		if (indexPic.getStatus() != 0) {
			indexService.generateBody();
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/indexPic/edit", method = RequestMethod.POST)
	public ResponseData edit(int id, @Validated IndexPic indexPic, HttpSession session, BindingResult br, MultipartFile image) {
		if (br.hasErrors()) {
			return ResponseData.FAILED_NO_DATA;
		}
		IndexPic tip = indexPicService.load(id);

		String newName = tip.getNewName();
		String oldName = tip.getOldName();
		if (image != null) {
			// 处理图片流数据
			String realPath = session.getServletContext().getRealPath("");
			oldName = image.getOriginalFilename();

			try {
				// 对图片流进行压缩，生成文件和缩略图保存到指定文件夹
				writeIndexPic(realPath, newName, image.getInputStream());
			} catch (IOException e) {
				e.printStackTrace();
				return new ResponseData(false, e.getMessage());
			}
		}

		tip.setLinkType(indexPic.getLinkType());
		tip.setLinkUrl(indexPic.getLinkUrl());
		tip.setNewName(newName);
		tip.setOldName(oldName);
		tip.setStatus(indexPic.getStatus());
		tip.setSubTitle(indexPic.getSubTitle());
		tip.setTitle(indexPic.getTitle());
		indexPicService.update(tip);
		indexService.generateBody();
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/indexPic/delete")
	public ResponseData delete(Long[] ids) {
		for (Long id : ids) {
			indexPicService.delete(id.intValue());
		}
		indexService.generateBody();
		return ResponseData.SUCCESS_NO_DATA;
	}

	private void writeIndexPic(String realPath, String newName, InputStream file) throws IOException {

		BaseInfo baseInfo = BaseInfoUtil.getInstacne().read();
		int pw = baseInfo.getIndexPicWidth();
		int ph = baseInfo.getIndexPicHeight();
		BufferedImage bi = ImageIO.read(file);
		// 按照baseInfo配置来写原图
		Thumbnails.of(bi).size(pw, ph).toFile(realPath + FILE_PATH + "/" + newName);
		// 写缩略图
		Thumbnails.of(bi).scale((double) T_W / (double) bi.getWidth()).toFile(realPath + FILE_PATH + "/thumbnail/" + newName);
	}
	/*-----------------------------------------------------*/

	@RequestMapping("/newPics")
	public String listNewPic(Model model) {
		model.addAttribute("datas", attachmentService.listAllPic());
		return "pic/listNewPic";
	}

	@RequestMapping("/indexPics")
	public String listIndexPic(Model model) {
		Map<String, Integer> mm = indexPicService.getMinAdnMaxPos();
		model.addAttribute("min", mm.get("min"));
		model.addAttribute("max", mm.get("max"));
		model.addAttribute("datas", indexPicService.findIndexPic());
		return "pic/listIndexPic";
	}

	@RequestMapping(value = "/addIndexPic", method = RequestMethod.GET)
	public String addIndexPic(Model model) {
		IndexPic ip = new IndexPic();
		ip.setStatus(1);
		model.addAttribute("indexPic", ip);
		return "pic/addIndexPic";
	}

	@RequestMapping(value = "/addIndexPic", method = RequestMethod.POST)
	public String addIndexPic(@Validated IndexPic indexPic, BindingResult br) {
		if (br.hasFieldErrors()) {
			return "pic/addIndexPic";
		}
		indexPicService.add(indexPic);
		if (indexPic.getStatus() != 0) {
			indexService.generateBody();
		}
		return "redirect:/jsp/common/addSuc.jsp";
	}

	@RequestMapping(value = "/updateIndexPic/{id}", method = RequestMethod.GET)
	public String updateIndexPic(@PathVariable int id, Model model) {
		IndexPic ip = indexPicService.load(id);
		model.addAttribute("indexPic", ip);
		return "pic/updateIndexPic";
	}

	@RequestMapping(value = "/updateIndexPic/{id}", method = RequestMethod.POST)
	public String updateIndexPic(@PathVariable int id, @Validated IndexPic indexPic, BindingResult br) {
		if (br.hasErrors()) {
			return "pic/updateIndexPic";
		}
		IndexPic tip = indexPicService.load(id);
		tip.setLinkType(indexPic.getLinkType());
		tip.setLinkUrl(indexPic.getLinkUrl());
		tip.setNewName(indexPic.getNewName());
		tip.setOldName(indexPic.getOldName());
		tip.setStatus(indexPic.getStatus());
		tip.setSubTitle(indexPic.getSubTitle());
		tip.setTitle(indexPic.getTitle());
		indexPicService.update(tip);
		indexService.generateBody();
		return "redirect:/jsp/common/updateSuc.jsp";
	}

	@RequestMapping(value = "/indexPic/{id}")
	public String showIndexPic(@PathVariable int id, Model model) {
		model.addAttribute("indexPic", indexPicService.load(id));
		return "pic/showIndexPic";
	}

	@RequestMapping(value = "/deleteIndexPic/{id}")
	public String deleteIndexPic(@PathVariable int id) {
		indexPicService.delete(id);
		indexService.generateBody();
		return "redirect:/admin/pic/indexPics";
	}

	@RequestMapping(value = "updateIndexPicStatus/{id}")
	public String updateIndexPicStatus(@PathVariable int id) {
		indexPicService.updateStatus(id);
		indexService.generateBody();
		return "redirect:/admin/pic/indexPics";
	}

	@RequestMapping(value = "/uploadIndexPic", method = RequestMethod.POST)
	public void uploadIndexPic(HttpSession session, HttpServletResponse resp, MultipartFile pic) {
		resp.setContentType("text/plain;charset=utf-8");
		AjaxObj ao = new AjaxObj();
		PrintWriter out = null;
		try {
			out = resp.getWriter();
			String oldName = pic.getOriginalFilename();
			String newName = new Date().getTime() + "." + FilenameUtils.getExtension(oldName);
			String realPath = session.getServletContext().getRealPath("");
			File f = new File(realPath + FILE_PATH + "/temp");
			System.out.println(realPath + FILE_PATH + "/temp");
			if (!f.exists()) {
				f.mkdirs();
			}
			BaseInfo baseInfo = (BaseInfo) session.getServletContext().getAttribute("baseInfo");
			double w = baseInfo.getIndexPicWidth();
			double h = baseInfo.getIndexPicHeight();
			BufferedImage bi = ImageIO.read(pic.getInputStream());
			double nw = bi.getWidth();
			double nh = bi.getHeight();
			if (nw > w && nw / nh < w / h) {
				// 图片的大小符合要求
				// 判断是否进行缩放
				Builder<BufferedImage> b = Thumbnails.of(bi);
				if (nw - w > 150) {
					b.scale((w + 150) / nw);
				} else {
					b.scale(1.0);
				}
				BufferedImage bi2 = b.asBufferedImage();
				b.toFile(realPath + FILE_PATH + "/temp/" + newName);
				IndexPicDto ipd = new IndexPicDto();
				ipd.setNewName(newName);
				ipd.setOldName(oldName);
				ipd.setIndexPicHeight(new Double(h).intValue());
				ipd.setIndexPicWidth(new Double(w).intValue());
				ipd.setImgWidth(bi2.getWidth());
				ipd.setImgHeight(bi2.getHeight());
				ao.setObj(ipd);
				ao.setResult(1);
			} else {
				ao.setResult(0);
				ao.setMsg("图片的尺寸不在有效范围中");
			}

		} catch (IOException e) {
			ao.setResult(0);
			ao.setMsg(e.getMessage());
		}
		out.println(JsonUtil.getInstance().obj2json(ao));
		out.flush();
	}

	@RequestMapping(value = "/confirmPic", method = RequestMethod.POST)
	public @ResponseBody AjaxObj confirmPic(HttpSession session, int x, int y, int w, int h, String newName) {
		AjaxObj ao = new AjaxObj();
		try {
			BaseInfo baseInfo = (BaseInfo) session.getServletContext().getAttribute("baseInfo");
			int pw = baseInfo.getIndexPicWidth();
			int ph = baseInfo.getIndexPicHeight();
			String path = session.getServletContext().getRealPath("");
			String tpath = path + FILE_PATH + "/temp/" + newName;
			File tf = new File(tpath);
			BufferedImage bi = ImageIO.read(tf);
			String npath = path + FILE_PATH + "/" + newName;
			String ttpath = path + FILE_PATH + "/thumbnail/" + newName;
			Builder<BufferedImage> b = Thumbnails.of(bi);
			// 写原图
			BufferedImage bi2 = b.sourceRegion(x, y, w, h).size(pw, ph).asBufferedImage();
			b.toFile(npath);
			// 写缩略图
			Thumbnails.of(bi2).scale((double) T_W / (double) pw).toFile(ttpath);
			tf.delete();
			ao.setResult(1);
			return ao;
		} catch (IOException e) {
			e.printStackTrace();
			ao.setResult(0);
			ao.setMsg(e.getMessage());
		}
		return ao;
	}
}
