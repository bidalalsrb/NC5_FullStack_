package com.bit.springboard.dto;

import java.sql.Date;

/*
 * DTO (Data Transfer Object): 데이터를 전송하는 객체. View-Controller-Model 사이에서
 * 								테이블과 매핑되는 형태로 데이터를 주고 받는 객체
 * 
 * VO (Value Object) : 의미상으로는 값을 전달하는 역할만 하는 객체지만 현업에서는 DTO 동일한 역할을 한다.
 * 
 * ENTITY	
 */
public class UserDTO {
	private int id;
	private String user_Id;
	private String user_Pw;
	private String user_Name;
	private String user_Email;
	private String user_Tel;
	private Date User_RegDate;
	
	
	@Override
	public String toString() {
		return "UserDTO [id=" + id + ", user_Id=" + user_Id + ", user_Pw=" + user_Pw + ", user_Name=" + user_Name
				+ ", user_Email=" + user_Email + ", user_Tel=" + user_Tel + ", User_RegDate=" + User_RegDate + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUser_Id() {
		return user_Id;
	}
	public void setUser_Id(String user_Id) {
		this.user_Id = user_Id;
	}
	public String getUser_Pw() {
		return user_Pw;
	}
	public void setUser_Pw(String user_Pw) {
		this.user_Pw = user_Pw;
	}
	public String getUser_Name() {
		return user_Name;
	}
	public void setUser_Name(String user_Name) {
		this.user_Name = user_Name;
	}
	public String getUser_Email() {
		return user_Email;
	}
	public void setUser_Email(String user_Email) {
		this.user_Email = user_Email;
	}
	public String getUser_Tel() {
		return user_Tel;
	}
	public void setUser_Tel(String user_Tel) {
		this.user_Tel = user_Tel;
	}
	public Date getUser_RegDate() {
		return User_RegDate;
	}
	public void setUser_RegDate(Date user_RegDate) {
		User_RegDate = user_RegDate;
	}
	
}
