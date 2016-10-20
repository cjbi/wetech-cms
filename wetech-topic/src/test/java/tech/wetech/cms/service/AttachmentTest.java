package tech.wetech.cms.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.inject.Inject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import tech.wetech.basic.model.SystemContext;
import tech.wetech.cms.model.Attachment;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class AttachmentTest {
	
	@Inject
	private IAttachmentService attachmentService;

	@Test
	public void testAddAttachment() throws IOException {
		SystemContext.setRealPath("D:\\");
		Attachment attach = new Attachment();
		attach.setIsAttach(0);
		attach.setIsImg(1);
		attach.setIsIndexPic(0);
		attach.setNewName("aaaaa.jpg");
		attach.setOldName("abc.jpg");
		attach.setSize(111111);
		attach.setSuffix("jpg");
		InputStream is = new FileInputStream("D:/1.jpg");
		attachmentService.add(attach, is);
		System.out.println(attach.getId());
	}
}
