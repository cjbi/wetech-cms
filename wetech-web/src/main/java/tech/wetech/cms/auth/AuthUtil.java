package tech.wetech.cms.auth;

import java.io.File;
import java.io.FilenameFilter;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class AuthUtil {
	/**
	 * 初始化系统的角色所访问的功能信息
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String,Set<String>> initAuth(String pname) {
		try {
			Map<String,Set<String>> auths = new HashMap<String, Set<String>>();
			String[] ps = getClassByPackage(pname);
			for(String p:ps) {
				String pc = pname+"."+p.substring(0,p.lastIndexOf(".class"));
				//得到了类的class对象
				Class clz = Class.forName(pc);
				if(!clz.isAnnotationPresent(AuthClass.class)) continue;
//				System.out.println(pc);
				//获取每个类中的方法，以此确定哪些角色可以访问哪些方法
				Method[] ms = clz.getDeclaredMethods();
				/*
				 * 遍历method来判断每个method上面是否存在相应的AuthMethd
				 * 如果存在就直接将这个方法存储到auths中，如果不存在就不存储
				 * 不存储就意味着该方法只能由超级管理员访问
				 */
				for(Method m:ms) {
					if(!m.isAnnotationPresent(AuthMethod.class)) continue;
					//如果存在就要获取这个Annotation
					AuthMethod am = m.getAnnotation(AuthMethod.class);
					String roles = am.role();
					//可能一个action可以被多个角色所访问，使用，进行分割
					String[] aRoles = roles.split(",");
					for(String role:aRoles) {
						Set<String> actions = auths.get(role);
						if(actions==null) {
							actions = new HashSet<String>();
							auths.put(role, actions);
						}
						actions.add(pc+"."+m.getName());
					}
				}
			}
			return auths;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 根据包获取所有的类
	 * @param pname
	 * @return
	 */
	private static String[] getClassByPackage(String pname) {
		String pr = pname.replace(".", "/");
		String pp = AuthUtil.class.getClassLoader().getResource(pr).getPath();
		File file = new File(pp);
		String[] fs = file.list(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				if(name.endsWith(".class")) return true;
				return false;
			}
		});
		return fs;
	}
	
	public static void main(String[] args) {
		System.out.println(initAuth("tech.wetech.cms.controller"));
	}
}
