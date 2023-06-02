package com.bit.springboard.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.stereotype.Repository;

import com.bit.springboard.common.JDBCUtil;
import com.bit.springboard.dto.UserDTO;

@Repository("userDAO")
public class UserDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final String INSERT_USER = "INSERT INTO"
			+ " T_USER(USER_ID,USER_PW,USER_NAME)"
			+ " VALUES("
			+ " ?,"
			+ " ?,"
			+ " ?"
			+ " )";
	
	private final String GET_USER = "SELECT "
			+ " *"
			+ " FROM T_USER"
			+ " WHERE ID = ?";
			
	
		
	public void join(UserDTO userDTO) {
		System.out.println("유저 조인");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(INSERT_USER);
			
			stmt.setString(1,userDTO.getUser_Id());
			stmt.setString(2,userDTO.getUser_Pw());
			stmt.setString(3,userDTO.getUser_Name());
			
			stmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			JDBCUtil.close(stmt, conn);
		}
		

	}

	public UserDTO getUser(int id) {
		System.out.println("겟유저 실행");
		UserDTO userDTO = new UserDTO();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_USER);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if(rs.next()) {
				userDTO.setId(rs.getInt("ID"));
				userDTO.setUser_Id(rs.getString("USER_Id"));
				userDTO.setUser_Pw(rs.getString("USER_Pw"));
				userDTO.setUser_Name(rs.getString("USER_Name"));
				userDTO.setUser_Email(rs.getString("USER_Email"));
				userDTO.setUser_Tel(rs.getString("USER_Tel"));
				userDTO.setUser_RegDate(rs.getDate("USER_Regdate"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			JDBCUtil.close(rs,stmt,conn);
		}
		
		return userDTO;
	}
}
