-- 1. CONSTRAINT
-- 1-1 PRIMARY KEY
-- 단일 컬럼 PK 테이블 생성
CREATE TABLE EMP_PK1
(
--     CONSTRAINT 제약조건명을 생략하면 제약조건명을 SYSTEM에서 자동으로 생성해준다.
    ENO   NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB   VARCHAR2(10),
    MGR   NUMBER,
    HDATE DATE,
    DNO   NUMBER
)

CREATE TABLE DEPT_PK1
(
    DNO      NUMBER,
    DNAME    VARCHAR2(10),
    LOC      VARCHAR2(10),
    DIRECTOR NUMBER,
    CONSTRAINT PK_DEPT_DNO PRIMARY KEY (DNO)
)

-- 중복허용 확인
INSERT INTO DEPT_PK1
VALUES (2, '개발1', '부산', 2)

-- PK에 NULL 저장
INSERT INTO EMP_PK1
VALUES (2, NULL, NULL, NULL, NULL, NULL)

SELECT *
FROM DEPT_PK1

SELECT *
FROM EMP_PK1

-- 다중 컬럼 PK 지정
-- 다중 컬럼 PK 지정시 아래 방법은 허용안됨
CREATE TABLE SCORE_PK
(
    CNO    NUMBER PRIMARY KEY,
    SNO    NUMBER PRIMARY KEY,
    RESULT NUMBER
)

-- 다중 컬럼 PK 지정 방식
CREATE TABLE SCORE_PK
(
    CNO    NUMBER,
    SNO    NUMBER,
    RESULT NUMBER,
    CONSTRAINT PK_SCORE_CNO_SNO PRIMARY KEY (CNO, SNO)
);

-- 다중 컬럼 PK는 다중 컬럼이 PK쌍이 된다.
-- PK로 지정된 모든 컬럼의 값이 중복돼야 중복으로 인식
INSERT INTO SCORE_PK
VALUES (1, 1, 100);
INSERT INTO SCORE_PK
VALUES (1, 2, 99);
INSERT INTO SCORE_PK
VALUES (1, 3, 98);
INSERT INTO SCORE_PK
VALUES (1, 1, 97);

ROLLBACK;
COMMIT;

select *
from SCORE_PK;

-- PK 추가
ALTER TABLE DEPT
    ADD CONSTRAINT PK_DEP_DNO PRIMARY KEY (DNO)

-- PK 수정
ALTER TABLE DEPT
    DROP CONSTRAINT PK_DEP_DNO

--  SCORE 테이블에 CNO, SNO PK 추가
ALTER TABLE C##MG.SCORE
    ADD CONSTRAINT PK_SC_CNO_SNO PRIMARY KEY (CNO, SNO)

select *
from C##MG.SCORE;

-- 1-2 FOREIGN KEY(테이블간의 관계를 맺어줌)
-- DEPT_PK1의 DNO을 참조하여 EMP_PK1의 DNO을 FK로 생성
DROP TABLE EMP_PK1

CREATE TABLE EMP_PK_FK1
(
    ENO   NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB   VARCHAR2(10),
    MGR   NUMBER,
    HDATE DATE,
    SAL   NUMBER(10, 3),
    COMM  NUMBER(5, 2),
    DNO   NUMBER
        CONSTRAINT FK_EMP_DMP REFERENCES DEPT_PK1
)

-- FK에 데이터 추가
-- FK는 NULL(X), 중복데이터 허용, INDEX도 아님
INSERT INTO EMP_PK_FK1
VALUES (1, '홍길동', '개발', 0, SYSDATE, 3000, 300, 2)

INSERT
INTO EMP_PK_FK1
VALUES (2, '장길산', '분석', 0, SYSDATE, 3200, 320, 2)

INSERT INTO EMP_PK_FK1
VALUES (3, '임꺽정', '개발', 0, SYSDATE, 3000, 300, 1)

-- 부모테이블에 없는 값은 저장할 수 없다.
INSERT INTO EMP_PK_FK1
VALUES (4, '고기천', '괸리', 0, SYSDATE, 3000, 300, 4)

select *
from EMP_PK_FK1;

SELECT A.*, B.DNAME, B.LOC, B.DIRECTOR
FROM EMP_PK_FK1 A
         JOIN DEPT_PK1 B on A.DNO = B.DNO

-- CASCADE 옵션이 없을 때 부모테이블의 데이터의 수정이나 삭제가 불가능(자식테이블에서 부모테이블에 데이터를 점유)
-- 점유된 데이터를 자식테이블에서 제거하면 부모테이블에서 수정/삭제 가능
-- 점유안된 데이터들은 바로 부모테이블에서도 수정/삭제 가능
-- 부모테이블의 데이터는 자식테이블에서 사용중이기 때문에 함부로 삭제/수정을 할 수 없도록 막아놓음
-- 자식테이블의 데이터를 먼저 삭제나 다른 데이터로 변경하고 부모테이블의 데이터를 삭제/수정을 해야 한다.
DELETE
FROM DEPT_PK1
WHERE DNO = 1

UPDATE DEPT_PK1
SET DNO = 3
WHERE DNO = 1

UPDATE EMP_PK_FK1
SET DNO = 3
WHERE DNO = 2
  and JOB = '개발'

UPDATE DEPT_PK1
SET LOC   = '천안',
    DNAME = '개발3'
WHERE DNO = 2

INSERT INTO DEPT_PK1
VALUES (1, '개발1', '서울', 1)

-- DEPT_PK1(부모) DNO 2,3은 EMP_PK_FK1(자식)점유, DNO 1은 점유되어 있지 않기 때문에
-- DNO 2,3은 수정/삭제 불가능, DNO 1은 수정/삭제가 가능

-- DNO 3의 데이터 점유를 해지(DNO1로 보내고) DNO3 데이터 부모테이블(DEPT_PK1)에서 삭제

UPDATE EMP_PK_FK1
SET DNO = 2
WHERE DNO = 3

DELETE DEPT_PK1
WHERE DNO = 3

-- CASCADE 옵션 추가된 FK 생성
CREATE TABLE EMP_PK_FK2
(
    ENO   NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB   VARCHAR2(10),
    MGR   NUMBER,
    HDATE DATE,
    SAL   NUMBER(10, 3),
    COMM  NUMBER(5, 2),
    DNO   NUMBER,
    CONSTRAINT FK_EMP_DNO100 FOREIGN KEY (DNO) REFERENCES DEPT_PK1 (DNO)
        ON DELETE CASCADE
)

INSERT INTO EMP_PK_FK2
VALUES (1, '장길산', '개발', 0, SYSDATE, 3000, 300, 2)

INSERT INTO EMP_PK_FK2
VALUES (2, '홍길동', '개발', 0, SYSDATE, 3000, 300, 2)

INSERT INTO DEPT_PK1
VALUES (1, '개발1', '서울', 0)

INSERT INTO DEPT_PK1
VALUES (2, '개발2', '서울', 0)

select *
from DEPT_PK1;

-- DELETE CASCADE 옵션일 때 부모데이터 삭제
-- 오라클에서는 UPDATE CASCADE는 지원안됨
-- DELETE CASCADE 옵션은 부모테이블 데이터를 삭제할 수 있게 해주는데
-- 부모테이블에서 삭제되는 데이터를 참조하고 있는 자식테이블의 데이터도 같이 삭제된다.
-- UPDATE CASCADE 옵션은 부모테이블의 데이터를 수정할 수 있다.
-- 부모테이블에서 수정되는 데이터를 참조하고 있는 자식테이블의 데이터도 같이 수정된다.

ALTER TABLE EMP_PK_FK1
    DROP CONSTRAINT FK_EMP_DMP

DELETE DEPT_PK1
WHERE DNO = 1;

select *
from DEPT_PK1;

select *
from EMP_PK_FK2;


-- FK 관계의 종류
-- 1:1 부모테이블 데이터 1개당 자식테이블 데이터 1개가 생성되는 구조
-- 부모테이블의 PK, UK컬럼이 자식테이블의 FK면서 PK,UK로 잡혀야 한다.
CREATE TABLE T_USER
(
    USER_ID   VARCHAR2(20) PRIMARY KEY,
    PASSWORD  VARCHAR2(50),
    JOIN_DATE DATE
);

INSERT INTO T_USER
VALUES ('GOGI', '1234', SYSDATE) -- 하나만 존재

CREATE TABLE T_USER_DETAIL
(
    USER_ID    VARCHAR2(20) PRIMARY KEY,
    USER_NAME  VARCHAR2(20),
    USER_EMAIL VARCHAR2(100),
    USER_TEL   NUMBER(11),
    CONSTRAINT FK_USER_ID FOREIGN KEY (USER_ID) REFERENCES T_USER (USER_ID)
)

INSERT INTO T_USER_DETAIL
VALUES ('GOGI', NULL, NULL, NULL)

-- 1:N 관계
-- 부모테이블의 데이터 1개로 자식테이블 데이터 여러개를 생성할 수 있는 관계
-- DEPT_PK1과 EMP_PK_FK2은 1:N 관계
-- DEPT_PK1의 PK인 DNO으로 EMP_PK_FK2에서는 여러개의 데이터(중복)을 생성할 수 있기 때문에 1:N 관계
-- T_BOARD와 T_BOARD_FILE을 1:N관계로 만들어보기

DROP TABLE T_BOARD_FILE

CREATE TABLE T_BOARD_FILE
(
    BOARD_NO        NUMBER,
    BOARD_FILE_NO   NUMBER,
    BOARD_FILE_NM   VARCHAR2(200),
    BOARD_FILE_PATH VARCHAR2(2000),
    ORIGIN_FILE_NM  VARCHAR2(200),
    CONSTRAINT T_BOARD_FILE_PK PRIMARY KEY (BOARD_NO, BOARD_FILE_NO),
    CONSTRAINT FK_BOARD_BOARD_NO FOREIGN KEY (BOARD_NO) REFERENCES T_BOARD (BOARD_NO)
);

INSERT INTO T_BOARD
VALUES (1, NULL, NULL, NULL, NULL, NULL)

INSERT INTO T_BOARD_FILE
VALUES (1, 3, NULL, NULL, NULL)

-- 1-3 Unique Key
CREATE TABLE EMP_UK
(
    ENO   NUMBER
        CONSTRAINT UK_EMP_ENO UNIQUE,
    ENAME VARCHAR2(20)
)

-- 데이터 저장
INSERT INTO EMP_UK
VALUES (1, '홍길동')

INSERT INTO EMP_UK
VALUES (2, '장길산')

-- NULL값은 중복저장 가능
INSERT INTO EMP_UK
VALUES (NULL, '홍길동5')

SELECT *
FROM EMP_UK

-- 1-4 CHECK
CREATE TABLE EMP_CHK
(
    ENO   NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB   VARCHAR2(10),
    MGR   NUMBER,
    SAL   NUMBER(11, 3),
    COMM  NUMBER(5, 2),
    CONSTRAINT CHK_EMP_SAL CHECK ( SAL >= 3000 ),
    CONSTRAINT CHK_EMP_COMM CHECK ( COMM BETWEEN 100 AND 1000)
)

-- CHECK 조건에 맞지 않는 데이터 지정
INSERT INTO EMP_CHK
VALUES (1, NULL, NULL, 0, 3000, 500)

select *
from EMP_CHK;

-- 1-5 NOT NULL
CREATE TABLE EMP_NOT_NULL
(
    ENO   NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20) NOT NULL,
    JOB   VARCHAR2(10) NOT NULL,
    MGR   NUMBER,
    HDATE DATE         NOT NULL,
    DNO   NUMBER       NOT NULL
)

-- NOT NULL으로 지정된 컬럼에 NULL을 저장하면 에러가 발생.
INSERT INTO EMP_NOT_NULL
VALUES (1, '홍길동', '개발', 0, SYSDATE, 0)

-- 1-6 DEFAULT
CREATE TABLE EMP_DEF
(
    ENO   NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20)                 NOT NULL,
    JOB   VARCHAR2(10) DEFAULT '개발'    NOT NULL,
    MGR   NUMBER,
    HDATE DATE         DEFAULT SYSDATE NOT NULL,
    DNO   NUMBER                       NOT NULL
)

-- DEFAULT로 지정된 컬럼 제외한 데이터 저장
INSERT INTO EMP_DEF(ENO, ENAME, MGR, DNO)
VALUES (1, '홍길동', 0, 1)

select *
from EMP_DEF;
-- 모든 제약 조건 추가된 테이블 생성
CREATE TABLE FACTORY
(
    FNO   NUMBER PRIMARY KEY,
    FNAME VARCHAR2(50) NOT NULL,
    LOC   VARCHAR2(10) DEFAULT '서울'
)

CREATE TABLE GOODS
(
    GNO   NUMBER PRIMARY KEY,
    GNAME VARCHAR2(50),
    PRI   NUMBER DEFAULT 10000,
    FNO   NUMBER
        CONSTRAINT FK_GOODS REFERENCES FACTORY (FNO) NOT NULL
)

CREATE TABLE PROD
(
    PNO   NUMBER PRIMARY KEY,
    GNO   NUMBER
        CONSTRAINT FK_PROD REFERENCES GOODS (GNO) NOT NULL,
    PRICE NUMBER DEFAULT 7000,
    PDATE DATE
)
