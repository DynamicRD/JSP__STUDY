package co.kh.dev.tempmember.model;

public class TempMemberVO {
	 private String id;
	 private String passwd;
	 private String name;
	 private String memNum1;
	 private String memNum2;
	 private String eMail;
	 private String phone;
	 private String zipcode;
	 private String address;
	 private String job;
	public TempMemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TempMemberVO(String id, String passwd, String name, String memNum1, String memNum2, String eMail,
			String phone, String zipcode, String address, String job) {
		super();
		this.id = id;
		this.passwd = passwd;
		this.name = name;
		this.memNum1 = memNum1;
		this.memNum2 = memNum2;
		this.eMail = eMail;
		this.phone = phone;
		this.zipcode = zipcode;
		this.address = address;
		this.job = job;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMemNum1() {
		return memNum1;
	}
	public void setMemNum1(String memNum1) {
		this.memNum1 = memNum1;
	}
	public String getMemNum2() {
		return memNum2;
	}
	public void setMemNum2(String memNum2) {
		this.memNum2 = memNum2;
	}
	public String geteMail() {
		return eMail;
	}
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	@Override
	public String toString() {
		return "TempMemberVO [id=" + id + ", passwd=" + passwd + ", name=" + name + ", memNum1=" + memNum1
				+ ", memNum2=" + memNum2 + ", eMail=" + eMail + ", phone=" + phone + ", zipcode=" + zipcode
				+ ", address=" + address + ", job=" + job + "]";
	}
	 
}
