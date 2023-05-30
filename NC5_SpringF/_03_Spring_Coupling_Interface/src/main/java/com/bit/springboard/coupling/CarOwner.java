package com.bit.springboard.coupling;

public class CarOwner {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//의존성이 두개가 생기면서 결합도가 높아진다.
		//또 다른 클래스가 만들어지면 계속해서 결합도는 높아질 수 밖에 없는 구조
		KiaCar kCar = new KiaCar();
		HyundaiCar hCar = new HyundaiCar();
		
		kCar.engineOn();
		kCar.speedUp();
		kCar.speedDown();
		kCar.engineOff();
		
		hCar.engineOn();
		hCar.speedUp();
		hCar.speedDown();
		hCar.engineOff();
		
		//다형성을 통해서 의존성을 하나로 낮춰서 결합도를 낮추는 방식
		Car car = new KiaCar();
		car.engineOn();
		car.speedUp();
		car.speedDown();
		car.engineOff();
		
		car = new HyundaiCar();
		car.engineOn();
		car.speedUp();
		car.speedDown();
		car.engineOff();
	}

}
