package com.bit.springboard.common;

import org.aspectj.lang.ProceedingJoinPoint;

public class Around {
	public Object aroundLog(ProceedingJoinPoint pjp) throws Throwable {
		System.out.println("[사전 처리] 비즈니스 로직 전 실행");
		Object retruObj = pjp.proceed();
		System.out.println("[사후 처리] 비즈니스 로직 후 실행");
		return retruObj;
	}
}
