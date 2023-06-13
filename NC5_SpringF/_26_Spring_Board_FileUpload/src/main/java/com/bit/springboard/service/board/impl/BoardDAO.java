package com.bit.springboard.service.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.dto.BoardFileDTO;
import com.bit.springboard.dto.Criteria;

//DAO(Data Access Object): DB에 직접 접근하는 객체 
//					=> Boot에서는 Mapper 인터페이스나 Repository  인터페이스 사용 
//JDBC Template 사용방식2
//JDBC Template 필드로 선언후 의존성 주입 받아서 사용
@Repository("boardDAO")
public class BoardDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//글 등록
	public void insertBoard(BoardDTO boardDTO,List<BoardFileDTO> boardFileList) {
		System.out.println("insertBoard 실행");
		
		mybatis.insert("BoardDAO.insertBoard", boardDTO);
		
		for(BoardFileDTO boardFileDTO : boardFileList) {
			//매퍼에서 selectKey로 꺼내온 boardNo 세      
			boardFileDTO.setBoardNO(boardDTO.getBoardNo());
			//List 매퍼로 보낼 때는 하나씩 꺼내서 보내도 되고
			mybatis.insert("BoardDAO.insertBoardFile",boardFileDTO);
		}
		//List자체를 매퍼로 보낼 수도 있다.
	}
	
	//글 수정
	public void updateBoard(BoardDTO boardDTO) {
		System.out.println("updateBoard 실행");
		
		mybatis.update("BoardDAO.updateBoard", boardDTO);
	}
	
	//글 삭제
	public void deleteBoard(int boardNo) {
		System.out.println("deleteBoard 실행");
		
		mybatis.delete("BoardDAO.deleteBoard", boardNo);
	}
	
	//글 상세 조회
	public BoardDTO getBoard(int boardNo) {
		System.out.println("getBoard 실행");
		
		return mybatis.selectOne("BoardDAO.getBoard", boardNo);
	}
	
	//글 목록 조회
	public List<BoardDTO> getBoardList(Map<String, String> paramMap,
			Criteria cri) {
		System.out.println("getBoardList 실행");
		
		Map<String, Object> sqlParamMap = 
							new HashMap<String, Object>();
		
		sqlParamMap.put("search", paramMap);
		cri.setStartNum((cri.getPageNum()-1 ) * cri.getAmount());
		sqlParamMap.put("page", cri);
		
		return mybatis.selectList("BoardDAO.getBoardList", sqlParamMap);
	}
	
	//조회수 올리기
	public void updateBoardCnt(int boardNo) {
		// TODO Auto-generated method stub
		mybatis.update("BoardDAO.updateBoardCnt", boardNo);
	}

	public int getBoardTotal(Map<String, String> paramMap) {
		// TODO Auto-generated method stub
		return mybatis.selectOne("BoardDAO.getBoardTotal", paramMap);
	}

	public List<BoardFileDTO> getboardFileList(int boardNo) {
		// TODO Auto-generated method stub
		return mybatis.selectList("BoardDAO.getBoardFileList",boardNo);
	}

	public BoardFileDTO getboardFile(BoardFileDTO boardFileDTO) {
		// TODO Auto-generated method stub
		return mybatis.selectOne("BoardDAO.getBoardFile", boardFileDTO);
	}

	
	
	
	
	
	
	
	
	
	
	
	
}
