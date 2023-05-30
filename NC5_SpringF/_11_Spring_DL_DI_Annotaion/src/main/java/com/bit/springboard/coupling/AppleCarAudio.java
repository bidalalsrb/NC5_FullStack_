package com.bit.springboard.coupling;

import org.springframework.stereotype.Component;

@Component
public class AppleCarAudio implements CarAudio{
	public AppleCarAudio() {
		System.out.println("애플 카오디오 객체 생성");
	}
	
	public void volumeUp() {
		System.out.println("애플 카오디오 소리 증가");
	}
	
	public void volumeDown() {
		System.out.println("애플 카오디오 소리 감소");
	}
}
