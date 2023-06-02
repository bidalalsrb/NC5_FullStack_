package com.bit.springboard.service.impl;

import java.sql.ResultSet;

import org.springframework.jdbc.core.RowMapper;

import com.bit.springboard.dto.BoardDTO;

public class BoardRowMapper implements RowMapper<BoardDTO>{
	public BoardDTO mapRow(ResultSet rs, int rowNum) {
		BoardDTO boardDTO = new BoardDTO();

		try {
			boardDTO.setBOARD_NO(rs.getInt("BOARD_NO"));	
			boardDTO.setBOARD_TITLE(rs.getString("BOARD_TITLE"));	
			boardDTO.setBOARD_CONTENT(rs.getString("BOARD_CONTENT"));	
			boardDTO.setBOARD_WRITER(rs.getString("BOARD_WRITER"));	
			boardDTO.setBOARD_REGDATE(rs.getDate("BOARD_REGDATE"));	
			boardDTO.setBOARD_CNT(rs.getInt("BOARD_CNT"));	
		} catch (Exception se) {
			// TODO: handle exception
			System.out.println(se.getMessage());
		}
		return boardDTO;		
	}
}
