package co.kh.dev.homepageproject.model;

import java.sql.Timestamp;

public class CommentMemberVO {
	private int num;
	private int numRef;
	private int Bnum;
	private String writer;
	private String pass;
	private int ref;
	private int step;
	private int depth;
	public CommentMemberVO(int num, int numRef, int bnum, String writer, String pass, int ref, int step, int depth,
			Timestamp regdate, String content, String ip) {
		super();
		this.num = num;
		this.numRef = numRef;
		Bnum = bnum;
		this.writer = writer;
		this.pass = pass;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.regdate = regdate;
		this.content = content;
		this.ip = ip;
	}

	private Timestamp regdate;
	private String content;
	private String ip;

	public CommentMemberVO() {
		super();
	}

	
	public CommentMemberVO(int num, int bnum, String writer, String pass, int ref,
			int step, int depth, Timestamp regdate, String content, String ip) {
		super();
		this.num = num;
		Bnum = bnum;
		this.writer = writer;
		this.pass = pass;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.regdate = regdate;
		this.content = content;
		this.ip = ip;
	}


	public int getBnum() {
		return Bnum;
	}


	public void setBnum(int bnum) {
		Bnum = bnum;
	}

	public int getNumRef() {
		return numRef;
	}
	
	
	public void setNumRef(int numRef) {
		this.numRef = numRef;
	}
	

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
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

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}


	@Override
	public String toString() {
		return "CommentMemberVO [num=" + num + ", numRef=" + numRef + ", Bnum=" + Bnum + ", writer=" + writer
				+ ", pass=" + pass + ", ref=" + ref + ", step=" + step + ", depth=" + depth + ", regdate=" + regdate
				+ ", content=" + content + ", ip=" + ip + "]";
	}

}
