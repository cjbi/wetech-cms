package tech.wetech.basic.util;

import java.util.List;

import junit.framework.Assert;
import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.Group;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.User;


@SuppressWarnings("deprecation")
public class EntitiesHelper {
	private static User baseUser = new User(1,"admin1","123","admin1","admin1@admin.com","110",1);
	
	public static User getBaseUser() {
		return baseUser;
	}
	
	public static void assertUser(User expected,User actual) {
		Assert.assertNotNull(expected);
		Assert.assertEquals(expected.getId(), actual.getId());
		Assert.assertEquals(expected.getUsername(), actual.getUsername());
		Assert.assertEquals(expected.getNickname(), actual.getNickname());
//		Assert.assertEquals(expected.getPassword(), actual.getPassword());
		Assert.assertEquals(expected.getPhone(), actual.getPhone());
		Assert.assertEquals(expected.getStatus(), actual.getStatus());
		Assert.assertEquals(expected.getEmail(), actual.getEmail());
	}
	
	public static void assertObjects(List<?> expected,List<?> actuals) {
		for(int i=0;i<expected.size();i++) {
			Object eo = expected.get(i);
			Object ao = actuals.get(i);
			Assert.assertEquals(eo, ao);
		}
	}
	
	public static void assertUsers(List<User> expected,List<User> actuals) {
		for(int i=0;i<expected.size();i++) {
			User eu = expected.get(i);
			User au = actuals.get(i);
			assertUser(eu, au);
		}
	}
	
	public static void assertRole(Role expected,Role actual) {
		Assert.assertNotNull(expected);
		Assert.assertEquals(expected.getId(), actual.getId());
		Assert.assertEquals(expected.getName(), actual.getName());
		Assert.assertEquals(expected.getRoleType(), actual.getRoleType());
	}
	
	public static void assertRoles(List<Role> expected,List<Role> actuals) {
		for(int i=0;i<expected.size();i++) {
			Role er = expected.get(i);
			Role ar = actuals.get(i);
			assertRole(er, ar);
		}
	}
	
	public static void assertGroup(Group expected,Group actual) {
		Assert.assertNotNull(expected);
		Assert.assertEquals(expected.getId(), actual.getId());
		Assert.assertEquals(expected.getName(), actual.getName());
	}
	
	public static void assertGroups(List<Group> expected,List<Group> actuals) {
		for(int i=0;i<expected.size();i++) {
			Group er = expected.get(i);
			Group ar = actuals.get(i);
			assertGroup(er, ar);
		}
	}
	
	public static void assertChannel(Channel expected,Channel actual) throws Exception{
		TestUtil.assertObjByClz(expected, actual, Channel.class, new String[]{"parent"});
	}
	
	public static void assertUser(User expected) {
		assertUser(expected, baseUser);
	}
}
