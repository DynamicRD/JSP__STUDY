package co.kh.dev.login.model;

public class LoginVO {
	private String id;
	private String pass;
	private String name;
	private boolean successFlag;
	
	

	public LoginVO() {}

	public LoginVO(String id, String pass, String name) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
	}

	public LoginVO(String id, String pass) {
		super();
		this.id = id;
		this.pass = pass;
	}

	public LoginVO(String id) {
		super();
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isSuccessFlag() {
		return successFlag;
	}

	public void setSuccessFlag(boolean successFlag) {
		this.successFlag = successFlag;
	}
	@Override
	public String toString() {
		return "LoginVO [id=" + id + ", pass=" + pass + ", name=" + name + "]";
	}
	
}
