package com.bit.springboard.common;

import org.aspectj.lang.JoinPoint;

public class Before {
	public void beforeLog(JoinPoint jp) {
		//		Signature 객체는 체이닝 기법 가능
		//		현재 실행중인 포인트컷 메소드의 이름
		String methodName = jp.getSignature().getName();
		//		현재 실행중인 포인트컷 메소드의 매개변수 Object 배열로 받기
		Object[] methodArgs = jp.getArgs();
		if (methodArgs.length != 0) {
			System.out.println("[사전처리]" + methodName +
					" ()의 매개변수 정보 : " + methodArgs[0].toString());		
		}
		else
			System.out.println("[사전처리]" + methodName + "()는 매개변수가 없습니다.");

	}
}
