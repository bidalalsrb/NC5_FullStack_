package chap18_enum;

import chap18_enum.enums.RGB;
import chap18_enum.enums.ValueMonth;

public class _03_useOfEnumValue {
    public static void main(String[] args) {
        // enum의 객체를 만들 때 생성자가 자동으로 호출
        // 호출한 상수 값이 생성자의 매개변수로 들어가서
        // 선언되어 있는 변수에 대입된다.
//        ValueMonth mar = ValueMonth.MAR;
//        System.out.println(mar.getMonthVal());
//
//        //여러형태의 enum 객체 생성
//        ValueMonth jan = ValueMonth.JAN;
        ValueMonth feb = ValueMonth.valueOf("FEB");
        ValueMonth apr = Enum.valueOf(ValueMonth.class, "APR");
//
//
//        System.out.println("jan : " + jan);
//        System.out.println("feb : " + feb);
//        System.out.println("apr : " + apr);
//
//        //enum 객체 배열
//        ValueMonth[] vmArr = ValueMonth.values();
//        for(ValueMonth v : vmArr){
//            System.out.println(v.name() + "은 " + v.ordinal() + "인덱스에 있씁니다");

        RGB red = RGB.RED;
        RGB green = RGB.valueOf("GREEN");
        RGB blue = Enum.valueOf(RGB.class, "BLUE");

        System.out.println(red);
        System.out.println(green);
        System.out.println(blue);
        System.out.println("");
        RGB[] rgbArr = RGB.values();
        for (RGB r : rgbArr) {
            System.out.println(r);
        }

    }
}
