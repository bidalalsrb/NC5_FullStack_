package com.bit.springboard.common;

import org.aspectj.lang.JoinPoint;

import com.bit.springboard.dto.BoardDTO;

public class AfterReturning {
	public void afterReturningLog(JoinPoint jp, Object returnobj) {
		//		returnObj : 포인트컵 메소드가 종료될 때 반환해주는 값
		//		두 번째 매개변수인 Object를 바인드 변수라고 하고 메소드의 리턴 값을 자동으로 매핑
		String methodName = jp.getSignature().getName();
		if (returnobj != null && returnobj instanceof BoardDTO) {
			BoardDTO board = (BoardDTO) returnobj;
			if (board.getBOARD_WRITER().equals("관리자")) {
				System.out.println("관리자가 작성한 글입니다.");
			}
		}
		if (returnobj != null) {
			System.out.println("[사후처리]" + methodName + "()의 리턴 값 : " 
					+ returnobj.toString());
		}
		else
			System.out.println("[사후처리]" + methodName + "()은 리턴값이 없습니다.");	

	}
}
