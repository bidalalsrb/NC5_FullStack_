package com.bit.springboard.common;
import org.aspectj.lang.JoinPoint;


public class AfterThrowing {
	public void afterThrowingLog(JoinPoint jp, Exception exception) {
		String methodName = jp.getSignature().getName();
		System.out.println("[예외 처리] " + methodName 
				+ "()실행 중 발생한 예외 : " + exception.getMessage());;
	}
}
