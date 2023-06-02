package com.bit.springboard.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit.springboard.common.JDBCUtil;
import com.bit.springboard.dto.BoardDTO;

//DAO ( Data Access Object) : DB에 직접 접근하는 객체 
//         					  => Boot에서는 Mapper 인터페이스나 Repository 인터페이스 사용
@Repository("boardDAO")
public class BoardDAO {
	//	JDBC 관련 변수
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	//	쿼리 등록
	private final String INSERT_BOARD = "INSERT INTO"
			+ " T_BOARD(BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER)"
			+ "VALUES ("
			+ "?,"
			+ "?,"
			+ "?"
			+ ")";

	private final String GET_BOARD = "SELECT "
			+ "BOARD_NO"
			+ ", BOARD_TITLE"
			+ ", BOARD_CONTENT"
			+ ", BOARD_WRITER"
			+ ", BOARD_REGDATE"
			+ ", BOARD_CNT"
			+ " FROM T_BOARD"
			+ " WHERE BOARD_NO = ?";

	private final String UPDATE_BOARD = "UPDATE T_BOARD SET"
			+ " BOARD_TITLE = ?"
			+ " ,BOARD_CONTENT = ?"
			+ " WHERE BOARD_NO = ?";

	private final String DELETE_BOARD = "DELETE FROM T_BOARD WHERE BOARD_NO = ?";

	private final String GET_BOARDLIST = "SELECT * FROM T_BOARD"; 


	//	글 등록
	public void insertBoard(BoardDTO boardDTO) {
		System.out.println("등록 완료");
		try {
			//			DB Connection 객체 얻기
			conn = JDBCUtil.getConnection();
			//			실행될 쿼리문 stmt에 담기
			stmt = conn.prepareStatement(INSERT_BOARD);
			//			쿼리문 실행될 대 넘길 파라미터 셋팅
			stmt.setString(1, boardDTO.getBOARD_TITLE());
			stmt.setString(2, boardDTO.getBOARD_CONTENT());
			stmt.setString(3, boardDTO.getBOARD_WRITER());

			//			쿼리문 실행
			//			insert, delete, update는 executeUpdate 사용
			//			select는 executeQuery 사용
			stmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	//	글 수정
	public void updateBoard(BoardDTO boardDTO) {
		System.out.println("업데이트 실행");

		try {
			conn = JDBCUtil.getConnection();

			stmt = conn.prepareStatement(UPDATE_BOARD);

			stmt.setString(1, boardDTO.getBOARD_TITLE());
			stmt.setString(2, boardDTO.getBOARD_CONTENT());
			stmt.setInt(3, boardDTO.getBOARD_NO());

			stmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			JDBCUtil.close(stmt,conn);
		}

	}

	//	글 삭제
	public void deleteBoard(int boardNo) {
		System.out.println("딜리트 실행");

		try {
			conn = JDBCUtil.getConnection();

			stmt = conn.prepareStatement(DELETE_BOARD);

			stmt.setInt(1, boardNo);

			stmt.executeUpdate();



		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			JDBCUtil.close(stmt, conn);
		}

	}

	//	글 상세 조회
	public BoardDTO getBoard(int boardNO) {
		System.out.println("getBoard 실행");
		BoardDTO boardDTO = new BoardDTO();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_BOARD);
			stmt.setInt(1, boardNO);
			rs = stmt.executeQuery();
			if (rs.next()) {
				boardDTO.setBOARD_NO(rs.getInt("BOARD_NO"));
				boardDTO.setBOARD_TITLE(rs.getString("BOARD_TITLE"));
				boardDTO.setBOARD_CONTENT(rs.getString("BOARD_CONTENT"));
				boardDTO.setBOARD_WRITER(rs.getString("BOARD_WRITER"));
				boardDTO.setBOARD_REGDATE(rs.getDate("BOARD_REGDATE"));
				boardDTO.setBOARD_CNT(rs.getInt("BOARD_CNT"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return boardDTO;
	}

	//	글 목록 조회
	public List<BoardDTO> getBoardList() {
		System.out.println("겟보드리스트 실행");

		List<BoardDTO> boardList  = new ArrayList<BoardDTO>();

		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_BOARDLIST);

			rs = stmt.executeQuery();
			
			while (rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				
				boardDTO.setBOARD_NO(rs.getInt("BOARD_NO"));
				boardDTO.setBOARD_TITLE(rs.getString("BOARD_TITLE"));
				boardDTO.setBOARD_CONTENT(rs.getString("BOARD_CONTENT"));
				boardDTO.setBOARD_WRITER(rs.getString("BOARD_WRITER"));
				boardDTO.setBOARD_REGDATE(rs.getDate("BOARD_REGDATE"));
				boardDTO.setBOARD_CNT(rs.getInt("BOARD_CNT"));
			
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			JDBCUtil.close(rs,stmt, conn);
		}


		return boardList;
	}
}
