package co.kh.dev.homepageproject.model;

import java.sql.Timestamp;

public class BasketVO {
	private int num;          // num (NUMBER(7,0))
    private String id;        // ID (VARCHAR2(20))
    private int pNum;         // p_num (NUMBER(7,0))
    private String name;      // name (VARCHAR2(50))
    private Timestamp regDate; // REGDATE (TIMESTAMP(6))
    private int price;        // price (NUMBER(7,0))
    private String imgUrl;    // imgUrl (VARCHAR2(50))
    private int amount;       // amount (NUMBER(5,0))
	public BasketVO() {
		super();
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public BasketVO(int num, String id, int pNum, String name, Timestamp regDate, int price, String imgUrl,
			int amount) {
		super();
		this.num = num;
		this.id = id;
		this.pNum = pNum;
		this.name = name;
		this.regDate = regDate;
		this.price = price;
		this.imgUrl = imgUrl;
		this.amount = amount;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	@Override
	public String toString() {
		return "BasketVO [num=" + num + ", id=" + id + ", pNum=" + pNum + ", name=" + name + ", regDate=" + regDate
				+ ", price=" + price + ", imgUrl=" + imgUrl + ", amount=" + amount + "]";
	}
}
