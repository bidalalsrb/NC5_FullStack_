package com.bit.springboard.coupling;

public class HyundaiCar implements Car {
	@Override
	public void engineOn() {
		System.out.println("HyundaiCar 시동을 건다");
	}
	@Override
	public void engineOff() {
		System.out.println("HyundaiCar 시동을 끈다.");
	}
	@Override
	public void speedUp() {
		System.out.println("HyundaiCar 속도를 올린다.");
	}
	@Override
	public void speedDown() {
		System.out.println("HyundaiCar 속도를 낮춘다.");
	}
}
