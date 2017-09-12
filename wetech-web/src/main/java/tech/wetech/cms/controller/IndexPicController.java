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
}
