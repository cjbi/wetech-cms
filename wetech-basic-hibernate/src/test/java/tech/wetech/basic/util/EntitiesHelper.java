package tech.wetech.basic.util;

import java.util.List;

import org.junit.Assert;

import tech.wetech.basic.model.User;


public class EntitiesHelper {
	private static User baseUser = new User(1,"admin1");
	
	public static void assertUser(User expected,User actual) {
		Assert.assertNotNull(expected);
		Assert.assertEquals(expected.getId(), actual.getId());
		Assert.assertEquals(expected.getUsername(), actual.getUsername());
	}
	
	public static void assertUsers(List<User> expected,List<User> actuals) {
		for(int i=0;i<expected.size();i++) {
			User eu = expected.get(i);
			User au = actuals.get(i);
			assertUser(eu, au);
		}
	}
	
	public static void assertUser(User expected) {
		assertUser(expected, baseUser);
	}
}
