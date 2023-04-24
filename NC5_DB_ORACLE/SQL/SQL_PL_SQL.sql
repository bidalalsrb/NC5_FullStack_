--1. PL/SQL
SET SERVEROUTPUT ON;

CREATE TABLE STUDENT_RECODE
AS
SELECT *
FROM STUDENT;

--1-6.레코드
-- 레코드는 다양한 데이터타입의 변수를 갖는 데이터들의 집합
DECLARE
    --레코드 선언부
    TYPE STU_REC IS RECORD
                    (
                        SNO   VARCHAR2(8) NOT NULL := '11012',
                        SNAME STUDENT.SNAME%TYPE,
                        SEX   STUDENT.SEX%TYPE,
                        SYEAR NUMBER(1, 0) DEFAULT 1,
                        MAJOR STUDENT.MAJOR%TYPE,
                        AVR   STUDENT.AVR%TYPE
                    );
    --레코드 변수 선언
    STUDENTREC STU_REC;
BEGIN
    STUDENTREC.SNO := '11011';
    STUDENTREC.SNAME := '문동주';
    STUDENTREC.SEX := '여';
    STUDENTREC.MAJOR := '생물';
    STUDENTREC.AVR := 4.0;
    STUDENTREC.SYEAR := 3;

    --데이터 수정
    UPDATE STUDENT_RECODE
    SET
        ROW = STUDENTREC
    WHERE SNO = '11011';
END;
/

select *
FROM STUDENT_RECODE
WHERE SNO = '11011';

-- 레코드인에 레코드 변수 선언
DECLARE
    TYPE SCORE_REC IS RECORD
                      (
                          CNO    SCORE.CNO%TYPE,
                          SNO    SCORE.SNO%TYPE,
                          RESULT SCORE.RESULT%TYPE
                      );

    TYPE STU_REC IS RECORD
                    (
                        SNO      VARCHAR2(8) NOT NULL := '11012',
                        SNAME    STUDENT.SNAME%TYPE,
                        SEX      STUDENT.SEX%TYPE,
                        SYEAR    NUMBER(1, 0) DEFAULT 1,
                        MAJOR    STUDENT.MAJOR%TYPE,
                        AVR      STUDENT.AVR%TYPE,
                        SCOREERC SCORE_REC
                    );
    STUDENTREC STU_REC;
BEGIN
    SELECT ST.SNO,
           ST.SNAME,
           ST.SEX,
           ST.SYEAR,
           ST.MAJOR,
           ST.AVR,
           SC.CNO,
           SC.SNO,
           SC.RESULT
    INTO STUDENTREC.SNO,STUDENTREC.SNAME,STUDENTREC.SEX,STUDENTREC.SYEAR
        ,STUDENTREC.MAJOR,STUDENTREC.AVR,STUDENTREC.SCOREERC.CNO,STUDENTREC.SCOREERC.SNO
        ,STUDENTREC.SCOREERC.RESULT
    FROM STUDENT ST
             JOIN SCORE SC on ST.SNO = SC.SNO
    WHERE ST.SNO = '915601'
      AND SC.CNO = '2368';
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.SNO);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.SNAME);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.SYEAR);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.MAJOR);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.AVR);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.SCOREERC.RESULT);
END;
/

-- 1-7 연관배열
-- 동일한 데이터 타입의 데이터들을 모아놓은 자료형
DECLARE
    TYPE NUM_ARRAY IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;

    NUM    NUMBER := 0;
    NUMARR NUM_ARRAY;
BEGIN
    LOOP
        NUM := NUM + 1;
        NUMARR(NUM) := NUM;
        EXIT WHEN NUM > 5;
    end loop;
    DBMS_OUTPUT.ENABLE(1);
    DBMS_OUTPUT.PUT_LINE(NUMARR(1));
    DBMS_OUTPUT.PUT_LINE(NUMARR(2));
    DBMS_OUTPUT.PUT_LINE(NUMARR(3));
    DBMS_OUTPUT.PUT_LINE(NUMARR(4));
    DBMS_OUTPUT.PUT_LINE(NUMARR(5));
end;
/


SELECT *
FROM STUDENT_RECODE

DECLARE
    --레코드 선언부
    TYPE STU_REC IS RECORD
                    (
                        SNO   VARCHAR2(8) NOT NULL := '11012',
                        SNAME STUDENT.SNAME%TYPE,
                        SEX   STUDENT.SEX%TYPE,
                        SYEAR NUMBER(1, 0) DEFAULT 1,
                        MAJOR STUDENT.MAJOR%TYPE,
                        AVR   STUDENT.AVR%TYPE
                    );
--     레코드 타입의 배열 선언
    TYPE STUDENT_ARRAY IS TABLE OF STU_REC
        INDEX BY PLS_INTEGER;

    STUARR STUDENT_ARRAY;
    IDX    NUMBER := 1;
BEGIN
    LOOP
        STUARR(IDX).SNO := 10000 + IDX;
        STUARR(IDX).SNAME := 'A';
        STUARR(IDX).SYEAR := MOD(IDX, 4) + 1;
        STUARR(IDX).MAJOR := '컴공';

        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SNO);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SNAME);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SYEAR);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).MAJOR);

        IDX := IDX + 1;
        EXIT WHEN IDX > 10;

    end loop;
end;


--

DECLARE
    --레코드 선언부
    TYPE STU_REC IS RECORD
                    (
                        SNO   VARCHAR2(8) NOT NULL := '11012',
                        SNAME STUDENT.SNAME%TYPE,
                        SEX   STUDENT.SEX%TYPE,
                        SYEAR NUMBER(1, 0) DEFAULT 1,
                        MAJOR STUDENT.MAJOR%TYPE,
                        AVR   STUDENT.AVR%TYPE
                    );
--     레코드 타입의 배열 선언
    TYPE STUDENT_ARRAY IS TABLE OF STU_REC
        INDEX BY PLS_INTEGER;

    STUARR STUDENT_ARRAY;
    IDX    NUMBER := 1;
BEGIN
    LOOP
        STUARR(IDX).SNO := 10000 + IDX;
        STUARR(IDX).SNAME := 'A';
        STUARR(IDX).SYEAR := MOD(IDX, 4) + 1;
        STUARR(IDX).MAJOR := '컴공';

        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SNO);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SNAME);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SYEAR);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).MAJOR);

        IDX := IDX + 1;
        EXIT WHEN IDX > 10;

    end loop;
end;


-- ROWTYPE을 이용해서 연관배열 생성
DECLARE
    TYPE STU_ARRAY IS TABLE OF STUDENT%ROWTYPE
        INDEX BY PLS_INTEGER;
    IDX    NUMBER := 1;
    STUARR STU_ARRAY;
BEGIN
    LOOP
        STUARR(IDX).SNO := 20000 + IDX;
        STUARR(IDX).SNAME := 'B' || IDX;
        STUARR(IDX).MAJOR := '소프트웨어';
        STUARR(IDX).SYEAR := MOD(IDX, 4) + 1;

        INSERT INTO STUDENT_RECODE
        VALUES STUARR(IDX);

        IDX := IDX + 1;
        EXIT WHEN IDX > 10;

    end loop;
end;
/

select *
from student_recode
where sno like '2000%';

-- 연관배열의 메소드
DECLARE
    TYPE STU_ARRAY IS TABLE OF STUDENT%ROWTYPE
        INDEX BY PLS_INTEGER;
    STUARR STU_ARRAY;
BEGIN
    STUARR(1).SNO := 20000 + 1;
    STUARR(1).SNAME := 'B' || 1;
    STUARR(1).MAJOR := '소프트웨어';
    STUARR(1).SYEAR := 1;

    STUARR(2).SNO := 20000 + 2;
    STUARR(2).SNAME := 'B' || 2;
    STUARR(2).MAJOR := '소프트웨어';
    STUARR(2).SYEAR := 2;

    STUARR(3).SNO := 20000 + 3;
    STUARR(3).SNAME := 'B' || 3;
    STUARR(3).MAJOR := '소프트웨어';
    STUARR(3).SYEAR := 3;

    STUARR(10).SNO := 20000 + 10;
    STUARR(10).SNAME := 'B' || 10;
    STUARR(10).MAJOR := '소프트웨어';
    STUARR(10).SYEAR := 4;

    --     EXIST 함수는 TRUE/FALSE를 리턴하기 때문에 출력하는 매개변수로 사용불가
--      IF나 CASE 조건절에 사용한다.
--     DBMS_OUTPUT.PUT_LINE(STUARR.EXISTS(4));
    DBMS_OUTPUT.PUT_LINE(STUARR.COUNT);
    DBMS_OUTPUT.PUT_LINE(STUARR.FIRST);
    DBMS_OUTPUT.PUT_LINE(STUARR.LAST);
    DBMS_OUTPUT.PUT_LINE(STUARR.PRIOR(10));
    DBMS_OUTPUT.PUT_LINE(STUARR.NEXT(10));

    STUARR.DELETE(3);
--     DBMS_OUTPUT.PUT_LINE(STUARR.EXISTS(3));

    IF STUARR.EXISTS(3) THEN
        DBMS_OUTPUT.PUT_LINE('3번 INDEX 있음');
    ELSE
        DBMS_OUTPUT.PUT_LINE('3번 INDEX 없음');
    end if;
    DBMS_OUTPUT.PUT_LINE(STUARR.COUNT);
end;


-- 1-8 커서
-- 한 행만 가져오는 커서
DECLARE
    CURSOR CURST IS
        SELECT SNO,
               SNAME,
               MAJOR,
               SYEAR
        FROM STUDENT
        WHERE SNO = '915301';

    TYPE STREC IS RECORD
                  (
                      SNO   VARCHAR2(8),
                      SNAME VARCHAR2(20),
                      MAJOR VARCHAR2(20),
                      SYEAR NUMBER(1, 0)
                  );
    STUREC STREC;
BEGIN    OPEN CURST;
    FETCH CURST INTO STUREC;
    DBMS_OUTPUT.PUT_LINE(STUREC.SNO);
    DBMS_OUTPUT.PUT_LINE(STUREC.SNAME);
    DBMS_OUTPUT.PUT_LINE(STUREC.MAJOR);
    DBMS_OUTPUT.PUT_LINE(STUREC.SYEAR);
    CLOSE CURST;
end;

-- 여러개의 행을 담고 있는 커서의 처리 방식1
DECLARE
    CURSOR CURST IS
        SELECT SNO, SNAME, SEX, SYEAR, MAJOR, AVR
        FROM STUDENT
        WHERE SYEAR = 1;
    STROW STUDENT%rowtype;
BEGIN
    OPEN CURST;
    LOOP
        FETCH CURST INTO STROW;
        DBMS_OUTPUT.PUT_LINE(STROW.SNO);
        DBMS_OUTPUT.PUT_LINE(STROW.SNAME);
        DBMS_OUTPUT.PUT_LINE(STROW.SYEAR);
        DBMS_OUTPUT.PUT_LINE(STROW.MAJOR);
        DBMS_OUTPUT.PUT_LINE(CURST%ROWCOUNT);

        EXIT WHEN CURST%NOTFOUND;
    end loop;
    CLOSE CURST;
end;

-- 여러행을 담고있는 CURSOR의 FOR 루프 처리
DECLARE
    CURSOR CURST IS
        SELECT SNO, SNAME, SEX, SYEAR, MAJOR, AVR
        FROM STUDENT
        WHERE SYEAR = 1;
BEGIN
    --     자동 OPEN, FETCH, CLOSE 실행
    FOR STROW IN CURST
        LOOP
            DBMS_OUTPUT.PUT_LINE(STROW.SNO);
            DBMS_OUTPUT.PUT_LINE(STROW.SNAME);
            DBMS_OUTPUT.PUT_LINE(STROW.SYEAR);
            DBMS_OUTPUT.PUT_LINE(STROW.MAJOR);
        end loop;
END;

-- 커서의 파라미터
-- 고정된 쿼리 결과가 아닌 유동적인 쿼리의 결과를 커서에 담아준다.
DECLARE
    CURSOR CURST(PARAM_SYEAR NUMBER) IS SELECT SNO, SNAME, MAJOR, SYEAR
                                        FROM STUDENT
                                        WHERE SYEAR = PARAM_SYEAR;
    TYPE STREC IS RECORD
                  (
                      SNO   STUDENT.SNO%TYPE,
                      SNAME STUDENT.SNAME%TYPE,
                      MAJOR STUDENT.MAJOR%TYPE,
                      SYEAR STUDENT.SYEAR%TYPE
                  );
    STUREC STREC;
BEGIN
    OPEN CURST(2);
    LOOP
        FETCH CURST INTO STUREC;

        EXIT WHEN CURST%NOTFOUND;
--            2학년
        DBMS_OUTPUT.PUT_LINE(STUREC.SNO);
        DBMS_OUTPUT.PUT_LINE(STUREC.SNAME);
        DBMS_OUTPUT.PUT_LINE(STUREC.MAJOR);
        DBMS_OUTPUT.PUT_LINE(STUREC.SYEAR);
    end loop;

    CLOSE CURST;

    OPEN CURST(4);

    LOOP
        FETCH CURST INTO STUREC;
--              4학년
        EXIT WHEN CURST%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(STUREC.SNO);
        DBMS_OUTPUT.PUT_LINE(STUREC.SNAME);
        DBMS_OUTPUT.PUT_LINE(STUREC.MAJOR);
        DBMS_OUTPUT.PUT_LINE(STUREC.SYEAR);
    end loop;
end;

-- 묵시적 커서
-- 실행된 쿼리문의 결과를 담고있는 커서
-- 따로 커서를 선언하지 않는다.
BEGIN
    UPDATE STUDENT
    SET SYEAR = 0
    WHERE SYEAR = 1;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
end;

select *
from STUDENT
WHERE SYEAR = 0;

-- 1-9 예외처리
-- EXCEPTION으로 예외처리부를 작성한다.
-- UPDATE 시 에러발생 처리 ROLLBACK
DECLARE
    VAL_SNO VARCHAR2(10);
BEGIN
    VAL_SNO := 'A';
    UPDATE STUDENT
    SET SYEAR = VAL_SNO
    WHERE SNO = '915301';
    DBMS_OUTPUT.PUT_LINE('예외발생 시 실행 안됨');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('값이 부적합');
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('롤백 완료');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('행이 너무 많음');
        ROLLBACK ;
        DBMS_OUTPUT.PUT_LINE('롤백 완료');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE('오류');
end;
/
--