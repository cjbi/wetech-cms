package tech.wetech.cms.dao;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)//让junit工作在spring环境中
@ContextConfiguration("/beans.xml")//在classes中spring的配置文件
//transactionManager表示在spring配置文件中所声明的事务对象
//defaultRollback=true表示操作会自动回滚，这样你在单元测试中所作的操作都不会影响数据库中的数据
@TransactionConfiguration(transactionManager="txManager", defaultRollback=true)
@Transactional
public class UserTest {
	/**
	 * 能够自动将IUserDao对象注入到测试单元中
	 */
	@Inject
	private IUserDao userDao;
	
	@Test
	public void testLoad() {
		/*
		 * 由于使用了Transactional标签，如果使用hibernate整个操作都是在一个session中
		 * 所以不存在延迟加载的问题
		
		User u = userDao.load(1);
		u.setNickname("ddd");
		//此时可以完成更新，但是当测试结束不会影响数据库
		userDao.update(u);
		System.out.println(u.getNickname());
		*/
	}
}
