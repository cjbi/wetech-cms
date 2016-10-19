package tech.wetech.basic.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import org.apache.commons.io.output.FileWriterWithEncoding;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreemarkerUtil {
	private static FreemarkerUtil util;
	private static Configuration cfg;
	private FreemarkerUtil() {
	}
	
	public static FreemarkerUtil getInstance(String pname) {
		if(util==null) {
			cfg = new Configuration();
			cfg.setClassForTemplateLoading(FreemarkerUtil.class, pname);
			cfg.setDefaultEncoding("utf-8");
			util = new FreemarkerUtil();
		}
		return util;
	}
	
	private Template getTemplate(String fname) {
		try {
			return cfg.getTemplate(fname);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 通过标准输出流输出模板的结果
	 * @param root 数据对象
	 * @param fname 模板文件
	 */
	public void sprint(Map<String,Object> root,String fname) {
		try {
			Template template  = getTemplate(fname);
			template.setEncoding("utf-8");
			template.process(root, new PrintWriter(System.out));
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 基于文件的输出
	 * @param root
	 * @param fname
	 * @param outpath
	 */
	public void fprint(Map<String,Object> root,String fname,String outpath) {
		try {
			Template template  = getTemplate(fname);
			template.setEncoding("utf-8");
			template.process(root, new FileWriterWithEncoding(outpath, "utf-8"));
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
