package tech.wetech.basic.dao;


/**
 * 公共的DAO处理对象，这个对象中包含了Hibernate的所有基本操作和对SQL的操作
 * @author cjb
 *
 * @param <T>
 */
public interface IBaseDao<T> {
	/**
	 * 添加对象
	 * @param t
	 * @return
	 */
	public T add(T t);
	/**
	 * 更新对象
	 * @param t
	 */
	public void update(T t);
	/**
	 * 根据id删除对象
	 * @param id
	 */
	public void delete(int id);
	/**
	 * 根据id加载对象
	 * 如果加载不到会报 OjectNotFoundException异常
	 * @param id
	 * @return
	 */
	public T load(int id);
	/**
	 * 根据id查询对象
	 * @param id
	 * @return
	 */
	public T get(int id);
	
}

