package tech.wetech.cms.dwr;

public interface IDwrService {
	/**
	 * 添加GroupChannel对象
	 * @param group
	 * @param channel
	 */
	public void addGroupChannel(int gid,int cid);
	
	/**
	 * 删除用户栏目
	 * @param gid
	 * @param cid
	 */
	public void deleteGroupChannel(int gid,int cid);
	
	public void updateIndexPic(int aid);
	
	public void updateAttachInfo(int aid);
	
	public void deleteAttach(int id);
	
	public void updatePicPos(int id, int oldPos, int newPos);
	
	public void updateLinkPos(int id,int oldPos,int newPos);
}
