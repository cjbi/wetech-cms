package tech.wetech.cms.web;

/**
 * JSON 数据请求返回内容
 *
 */
public class ResponseData {
	//~ Static fields ==================================================================================================
	public static final ResponseData SUCCESS_NO_DATA = new ResponseData(true,"操作成功");
	public static final ResponseData FAILED_NO_DATA = new ResponseData(false);
	public static final ResponseData FAILED_DEL_OWNROLE = new ResponseData(false,"当前用户不能删除自己被授于的角色");
	
	//~ Instance fields ================================================================================================
	private boolean success;
	private String type;
	private Object message;
	private String requestURI;
	private String execptionTrace;
	private String mess;
	
	//~ Constructors ===================================================================================================
	public ResponseData(boolean success) {
		this(success, null, null);
	}
	
	public ResponseData(boolean success, Object message) {
		this(success, null, message);
	}
	
	public ResponseData(boolean success, String type, Object message) {
		this.success = success;
		this.type = type;
		this.message = message;
	}
	
	public ResponseData(String message){
		this.message = message;
	}

	//~ Methods ========================================================================================================
	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Object getMessage() {
		return message;
	}

	public void setMessage(Object message) {
		this.message = message;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRequestURI() {
		return requestURI;
	}

	public void setRequestURI(String requestURI) {
		this.requestURI = requestURI;
	}

	public String getExecptionTrace() {
		return execptionTrace;
	}

	public void setExecptionTrace(String execptionTrace) {
		this.execptionTrace = execptionTrace;
	}

	public String getMess() {
		return mess;
	}

	public void setMess(String mess) {
		this.mess = mess;
	}
}
