package tech.wetech.cms.dwr;

import java.util.List;

import javax.inject.Inject;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;

import tech.wetech.cms.model.Group;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.service.IAttachmentService;
import tech.wetech.cms.service.ICmsLinkService;
import tech.wetech.cms.service.IGroupService;
import tech.wetech.cms.service.IIndexPicService;
import tech.wetech.cms.service.IRoleService;


@RemoteProxy(name = "dwrService")
public class DwrService implements IDwrService {

	@Inject
	private IGroupService groupService;
	@Inject
	private IRoleService roleService;
	@Inject
	private IAttachmentService attachmentService;
	@Inject
	private IIndexPicService indexPicService;
	@Inject
	private ICmsLinkService cmsLinkService;

	@Override
	@RemoteMethod
	public void addGroupChannel(int gid, int cid) {
		groupService.addGroupChannel(gid, cid);
	}

	@Override
	@RemoteMethod
	public void deleteGroupChannel(int gid, int cid) {
		groupService.deleteGroupChannel(gid, cid);
	}

	@Override
	@RemoteMethod
	public void updateIndexPic(int aid) {
		System.out.println("dwrservice:" + aid);
		attachmentService.updateIndexPic(aid);
	}

	@Override
	@RemoteMethod
	public void updateAttachInfo(int aid) {
		attachmentService.updateAttachInfo(aid);
	}

	@Override
	@RemoteMethod
	public void deleteAttach(int id) {
		attachmentService.delete(id);
	}

	@Override
	@RemoteMethod
	public void updatePicPos(int id, int oldPos, int newPos) {
		indexPicService.updatePos(id, oldPos, newPos);
	}

	@Override
	@RemoteMethod
	public void updateLinkPos(int id, int oldPos, int newPos) {
		cmsLinkService.updatePos(id, oldPos, newPos);
	}

	@Override
	@RemoteMethod
	public List<Group> listGroup() {
		return groupService.listGroup();
	}

	@Override
	@RemoteMethod
	public List<Role> listRole() {
		return roleService.listRole();
	}

}
