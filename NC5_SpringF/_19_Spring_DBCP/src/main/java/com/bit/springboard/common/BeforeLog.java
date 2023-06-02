package com.bit.springboard.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;


@Service
//3. 애즈팩트 설정
@Aspect
public class BeforeLog {
//	//	1. 포인트컷 설정
//	@Pointcut("execution(* com.bit.springboard.service..*Impl.*(..))")
//	public void allpointcut() {
//	}

	//2. 어드바이스 설정
//	@Before("allPointcut()")  같은 클래스내의 포인트 컷
//	포인트 컷 클래스의 포인트 컷 설정
	@Before("PointcutCommon.allpointcut()")
	
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
