package tech.wetech.cms.web;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

import tech.wetech.cms.model.BaseInfo;

public class BaseInfoUtil {
	private static BaseInfoUtil biu;
	private static Properties prop;
	
	private BaseInfoUtil() throws IOException {
		if(prop==null) {
			prop = new Properties();
			prop.load(new InputStreamReader(BaseInfoUtil.class.getClassLoader().getResourceAsStream("baseinfo.properties"),"utf-8"));
		}
	}
	
	public static BaseInfoUtil getInstacne() {
		try {
			if(biu==null) {
				biu = new BaseInfoUtil();
			}
			return biu;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public BaseInfo read() {
		BaseInfo bi = new BaseInfo();
		bi.setAddress(prop.getProperty("address"));
		bi.setEmail(prop.getProperty("email"));
		bi.setName(prop.getProperty("name"));
		bi.setName2(prop.getProperty("name2"));
		bi.setPhone(prop.getProperty("phone"));
		bi.setRecordCode(prop.getProperty("recordCode"));
		bi.setZipCode(prop.getProperty("zipCode"));
		bi.setDomainName(prop.getProperty("domainName"));
		bi.setIndexPicNumber(Integer.parseInt(prop.getProperty("indexPicNumber")));
		bi.setDesc(prop.getProperty("desc"));
		String w = prop.getProperty("indexPicSize");
		
		String[] ws = w.split("\\*");
		bi.setIndexPicWidth(Integer.parseInt(ws[0]));
		bi.setIndexPicHeight(Integer.parseInt(ws[1]));
		return bi;
	}
	
	public BaseInfo write(BaseInfo bi) {
		FileOutputStream fos = null;
		try {
			prop.setProperty("address", bi.getAddress());
			prop.setProperty("email", bi.getEmail());
			prop.setProperty("name", bi.getName());
			prop.setProperty("name2", bi.getName2());
			prop.setProperty("phone",bi.getPhone());
			prop.setProperty("recordCode",bi.getRecordCode());
			prop.setProperty("zipCode",bi.getZipCode());
			prop.setProperty("indexPicNum", String.valueOf(bi.getIndexPicNumber()));
			prop.setProperty("domainName",bi.getDomainName());
            prop.setProperty("desc",bi.getDesc());
			prop.setProperty("indexPicSize", bi.getIndexPicWidth()+"*"+bi.getIndexPicHeight());
			String path = BaseInfoUtil.class.getClassLoader().getResource("baseinfo.properties").getPath();
//			System.out.println(path);
			fos = new FileOutputStream(path);
			prop.store(fos,null);
			return bi;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(fos!=null) fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
