package tech.wetech.cms.web;

/**
 * JSON 数据请求返回内容
 *
 */
public class ResponseData {
	
	public static final ResponseData SUCCESS_NO_DATA = new ResponseData(true,"操作成功");
	public static final ResponseData FAILED_NO_DATA = new ResponseData(false,"操作失败");
	public static final ResponseData FAILED_DEL_OWNROLE = new ResponseData(false,"当前用户不能删除自己被授于的角色");
	
	private boolean success;
	private String type;
	private String requestURI;
	private String execptionTrace;
	private String message;
	private Object data;
	
	public ResponseData(boolean success) {
		this(success, null, null);
	}
	
	public ResponseData(boolean success, String message) {
		this(success, null, message);
	}
	
	public ResponseData(boolean success, String type, String message) {
		this.success = success;
		this.type = type;
		this.message = message;
	}
	
	public ResponseData(String message){
		this.message = message;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Object getMessage() {
		return message;
	}

	public void setMessage(String message) {
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

	public Object getData() {
		return data;
	}
	
	public void setData(Object data) {
		this.data = data;
	}
	
}
