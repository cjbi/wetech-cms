package tech.wetech.cms.web;

/**
 * JSON 数据请求返回内容
 *
 */
public class ResponseData {
	
	public static final ResponseData SUCCESS_NO_DATA = new ResponseData(true,"操作成功");
	public static final ResponseData FAILED_NO_DATA = new ResponseData(false,"操作失败");
	public static final ResponseData FAILED_DEL_OWNROLE = new ResponseData(false,"当前用户不能删除自己被授于的角色");
	
	private boolean status;
	private String type;
	private String requestURI;
	private String execptionTrace;
	private String message;
	private Object data;
	
	public ResponseData(boolean status) {
		this(status, null, null);
	}
	
	public ResponseData(boolean status, String message) {
		this(status, null, message);
	}
	
	public ResponseData(boolean status, String type, String message) {
		this.status = status;
		this.type = type;
		this.message = message;
	}
	
	public ResponseData(boolean status, String message, Object data) {
		super();
		this.status = status;
		this.message = message;
		this.data = data;
	}

	public ResponseData(boolean status, String type, String message, Object data) {
		super();
		this.status = status;
		this.type = type;
		this.message = message;
		this.data = data;
	}

	public ResponseData(String message){
		this.message = message;
	}
	
	public boolean getStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
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
