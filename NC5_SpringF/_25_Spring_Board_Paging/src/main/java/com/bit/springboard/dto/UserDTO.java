package com.bit.springboard.dto;

import java.sql.Date;

/*
 * DTO(Data Transfer Object): 데이터를 전송하는 객체. View-Controller-Model
 * 							  사이에서 테이블과 매핑되는 형태로 데이터를 주고 받는 객체
 * VO(Value Object): 의미상으로는 값을 전달하는 역할만 하는 객체지만 현업에서는 DTO동일한 역할을 한다.
 * Entity
 * */
public class UserDTO {
	private int id;
	private String userId;
	private String userPw;
	private String userName;
	private String userEmail;
	private String userTel;
	private Date userRegdate;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public Date getUserRegdate() {
		return userRegdate;
	}
	public void setUserRegdate(Date userRegdate) {
		this.userRegdate = userRegdate;
	}
	
	@Override
	public String toString() {
		return "UserDTO [id=" + id + ", userId=" + userId + ", userPw=" + userPw + ", userName=" + userName
				+ ", userEmail=" + userEmail + ", userTel=" + userTel + ", userRegdate=" + userRegdate + "]";
	}
}
