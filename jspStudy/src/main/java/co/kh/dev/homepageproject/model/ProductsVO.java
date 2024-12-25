package co.kh.dev.homepageproject.model;

import java.sql.Timestamp;

public class ProductsVO {
	private int num;
	private String name;
	private Timestamp regdate;
	private String content;
	private int price;
	private int amount;
	private String tag;
	private String imgUrl;
	private String searchCheck;

	public ProductsVO() {}

	public ProductsVO(int num, String name, Timestamp regdate, String content,
			int price, int amount, String tag, String imgUrl) {
		super();
		this.num = num;
		this.name = name;
		this.regdate = regdate;
		this.content = content;
		this.price = price;
		this.amount = amount;
		this.tag = tag;
		this.imgUrl = imgUrl;
	}

	public String getSearchCheck() {
		return searchCheck;
	}
	
	public void setSearchCheck(String searchCheck) {
		this.searchCheck = searchCheck;
	}
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	@Override
	public String toString() {
		return "ProductsVO [num=" + num + ", name=" + name 
				+ ", regdate=" + regdate + ", content=" + content + ", price=" + price + ", amount=" + amount
				+ ", tag=" + tag + ", imgUrl=" + imgUrl + "]";
	}
	
	
	
}
