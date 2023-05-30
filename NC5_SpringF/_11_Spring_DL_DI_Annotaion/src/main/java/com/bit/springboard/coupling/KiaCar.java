package com.bit.springboard.coupling;

public class KiaCar implements Car{
	String model;
	//bean init-mehtod에서 사용할 메소드 선언
	public void initMethod() {
		this.model = "k3";
		System.out.println("KiaCar 객체 생성");
	}
	public void destroyMethod() {
		this.model = "";
		System.out.println("KiaCar 객체 삭제 전 동작");
	}
	@Override
	public void engineOn() {
		System.out.println("KiaCar 시동을 건다");
	}
	@Override
	public void engineOff() {
		System.out.println("KiaCar 시동을 끈다.");
	}
	@Override
	public void speedUp() {
		System.out.println("KiaCar 속도를 올린다.");
	}
	@Override
	public void speedDown() {
		System.out.println("KiaCar 속도를 낮춘다.");
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	
}
