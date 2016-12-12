package tech.wetech.cms.controller;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tech.wetech.basic.model.SystemContext;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.model.BaseInfo;
import tech.wetech.cms.service.IAttachmentService;
import tech.wetech.cms.service.IIndexPicService;
import tech.wetech.cms.service.IIndexService;
import tech.wetech.cms.web.BaseInfoUtil;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

@RequestMapping("/admin/system")
@Controller
@AuthClass
public class SystemController {

	@Inject
	private IAttachmentService attachmentService;
	@Inject
	private IIndexPicService indexPicService;
	@Inject
	private IIndexService indexService;

	@RequestMapping("/baseInfo")
	public String baseInfo() {
		return "admin/system/baseInfo";
	}

	@RequestMapping("/clean")
	public String clean() {
		return "admin/system/clean";
	}

	@ResponseBody
	@RequestMapping("/clean/listNoUseAttachment")
	public Map<String, Object> listNoUseAttachment() {
		return DataTableMap.getMapData(attachmentService.findNoUseAttachment());
	}

	@ResponseBody
	@RequestMapping("/clean/listNoUseIndexPic")
	public List<String> listNoUseIndexPic() {
		return listNoUseIndexPic(indexPicService.listAllIndexPicName());
	}
	
	@ResponseBody
	@RequestMapping(value = "/baseInfo/edit", method = RequestMethod.POST)
	public ResponseData editBaseInfo(@Validated BaseInfo baseInfo, BindingResult br, HttpSession session) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		BaseInfo bi = BaseInfoUtil.getInstacne().write(baseInfo);
		session.getServletContext().setAttribute("baseInfo", bi);
		indexService.generateBottom();
		indexService.generateTop();
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	@ResponseBody
	@RequestMapping(value = "/clean/{name}")
	public ResponseData clean(@PathVariable String name, Model model) throws IOException {
		if (name.equals("cleanAtta")) {
			attachmentService.clearNoUseAttachment();
		} else if (name.equals("cleanIndexPic")) {
			indexPicService.cleanNoUseIndexPic(listNoUseIndexPic(indexPicService.listAllIndexPicName()));
		}
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	/*----------------------------------------------------------------*/

	@RequestMapping("/cleans")
	public String listCleans(Model model) {
		model.addAttribute("attNums", attachmentService.findNoUseAttachmentNum());
		model.addAttribute("indexPics", listNoUseIndexPicNum(indexPicService.listAllIndexPicName()));
		return "system/cleans";
	}

	private File[] listPicFile() {
		String path = SystemContext.getRealPath();
		File f = new File(path + "/resources/indexPic");
		File[] fs = f.listFiles(new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				if (pathname.isDirectory())
					return false;
				return true;
			}
		});
		return fs;
	}

	/**
	 * 获取没有使用的首页图片数量
	 * 
	 * @param pics
	 * @return
	 */
	private int listNoUseIndexPicNum(List<String> pics) {
		File[] fs = listPicFile();
		int count = 0;
		for (File file : fs) {
			if (!pics.contains(file.getName()))
				count++;
		}
		return count;
	}

	/**
	 * 获取没有使用的首页图片列表
	 * 
	 * @param pics
	 * @return
	 */
	private List<String> listNoUseIndexPic(List<String> pics) {
		File[] fs = listPicFile();
		List<String> npics = new ArrayList<String>();
		for (File f : fs) {
			if (!pics.contains(f.getName()))
				npics.add(f.getName());
		}
		return npics;
	}
}
