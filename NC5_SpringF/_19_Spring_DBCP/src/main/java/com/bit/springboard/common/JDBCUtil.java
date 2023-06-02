package com.bit.springboard.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//DAO 클래스에서 DB Connection이나 DB Connection close 해주는 메소드
//DAO 공통적으로 사용될 메소드 정의 

public class JDBCUtil {
	public static Connection getConnection() {

		try {
			//사용할 DBMS의 드라이버 클래스 로드
			Class.forName("com.mysql.cj.jdbc.Driver");

			//			DriverManager 클래스의 getConnection메소드로 Connection을 얻어서 리턴
			//			매개변수로 url, username, password
			return DriverManager.getConnection
					("JDBC:mysql://localhost:3306/study_db?serverTimezone=UTC","study","1234");

		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	//	2개의 close 메소드
	//	resultSet이 없는 메소드(insert, delete, update)
	//	resultSet이 있는 메소드(select)

	//	resultSet이 없는 메소드(insert, delete, update)
	public static void close(PreparedStatement stmt, Connection conn) {
		if(stmt!=null) {
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}finally {
				stmt=null;
			}
		}

		if(conn!=null) {
			try {
				if(!conn.isClosed()) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
				// TODO: handle exception
			}finally {
				conn = null;
			}
		}
	}	

	//	resultSet이 있는 메소드(select)
	public static void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
		
		if(rs!=null) {
			try {
				if(!rs.isClosed()) {
					rs.close();
				}
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}finally {
				stmt=null;
			}
		}
		if(stmt!=null) {
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}finally {
				stmt=null;
			}
		}

		if(conn!=null) {
			try {
				if(!conn.isClosed()) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
				// TODO: handle exception
			}finally {
				conn = null;
			}
		}

	}







}