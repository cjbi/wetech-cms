package tech.wetech.cms.backup;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Timestamp;
import java.util.Date;

import org.junit.Test;

import tech.wetech.basic.util.JsonUtil;

public class CmdTest {

	@Test
	public void testSimpleCmd() {
		try {
			String cmd = "cmd /c dir c:\\";
			Process proc = Runtime.getRuntime().exec(cmd);
			BufferedReader br = new BufferedReader(new InputStreamReader(proc.getInputStream(),"utf-8"));
			String str = null;
			while((str=br.readLine())!=null) {
				System.out.println(str);
			}
			br.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testTimeStamp() {
		JsonUtil js  = JsonUtil.getInstance();
		Timestamp t = new Timestamp(new Date().getTime());
		System.out.println(js.obj2json(t));
	}
	
	
	@Test
	public void testMySql() {
		try {
			String cmd = "cmd /c mysqldump -uroot -p123456 cms_study";
			Process proc = Runtime.getRuntime().exec(cmd);
			BufferedReader br = new BufferedReader(new InputStreamReader(proc.getInputStream()));
			BufferedWriter bw = new BufferedWriter(new FileWriter("d:/wetech_cms.sql"));
			String str = null;
			while ((str = br.readLine()) != null) {
				bw.write(str);
				System.out.println(str);
				bw.newLine();
			}
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testResume() {
		try {
			String cmd = "cmd /c mysql -uroot -p123456 cms_study";
			Process proc = Runtime.getRuntime().exec(cmd);
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(proc.getOutputStream()));
			BufferedReader br = new BufferedReader(new FileReader("d:/wetech_cms.sql"));
			String str = null;
			while((str=br.readLine())!=null) {
				bw.write(str);
				System.out.println(str);
				bw.newLine();
			}
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
