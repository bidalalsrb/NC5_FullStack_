package chap04_controlStatement;

public class _10_duplicatedBreak {
	public static void main(String[] args) {
		// 외내부 for문이 몇번 실행 됐는지
		int iCnt = 0;
		int jCnt = 0;
		// 외부 for문의 break는 for문 전체를 종료
		for (int i = 0; i < 5; i++) {

			if (i == 3) {
				break;
			}
			iCnt++;
			// 내부 for문의 break는 내부 for문만 종료
			for (int j = 0; j < 5; j++) {

				if (j == 2) {
					break;
				}
				jCnt++;
			}
		}
		System.out.println(iCnt);
		System.out.println(jCnt);
	}
}
