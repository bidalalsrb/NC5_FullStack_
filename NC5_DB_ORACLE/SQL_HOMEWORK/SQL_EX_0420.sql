--1) SCORE 테이블과 동일한 구조를 갖는 SCORE_CHK를 생성하고 RESULT 60이상 90이하만 입력 가능하도록 하세요.
CREATE TABLE SCORE_CHK
(
    SNO    VARCHAR2(8) not null,
    CNO    VARCHAR2(8) not null,
    RESULT NUMBER(3) CHECK ( RESULT BETWEEN 60 AND 90),
    constraint PK_SC_CNO_SNO_CHK
        primary key (CNO, SNO)
)

--2) STUDENT 테이블과 동일한 구조를 갖는 STUDENT_COPY 테이블을 생성하면서 SNO은 PK로 SNAME은 NOT NULL로 SYEAR의 DEFAULT는 1로
--   설정하세요.
CREATE TABLE STUDENT_COPY
(
    SNO   VARCHAR2(8) PRIMARY KEY,
    SNAME VARCHAR2(20) NOT NULL,
    SEX   VARCHAR2(3),
    SYEAR NUMBER(1) DEFAULT 1,
    MAJOR VARCHAR2(20),
    AVR   NUMBER(4, 2)
)

--3) COURSE 테이블과 동일한 구조를 갖는 COURSE_CONTSRAINT 테이블을 생성하면서 CNO, CNAME을 PK로 PNO은 PROFESSOR_PK의 PNO을 참조하여
--   FK로 설정하고 ST_NUM은 DEFAULT 2로 설정하세요.
CREATE TABLE COURSE_CONTSRAINT
(
    CNO    VARCHAR2(8),
    CNAME  VARCHAR2(20),
    ST_NUM NUMBER DEFAULT 2,
    PNO    VARCHAR2(8)
        CONSTRAINT FK_CO_CO_PNO REFERENCES PROFESSOR_PK (PNO),
    CONSTRAINT PK_CO_CO_CNO_CNAME PRIMARY KEY (CNO, CNAME)
)


--4) 다음 구조를 갖는 테이블을 생성하세요.
--   T_SNS                              T_SNS_DETAIL                        T_SNS_UPLOADED
--   SNS_NO(PK)    SNS_NM               SNS_NO(PK, FK)   SNS_BEN            SNS_NO(PK, FK)    SNS_UPL_NO(PK)
--     1            페북                   1               4000                   1                  1
--     2           인스타                  2               10000                  1                  2
--     3           트위터                  3               30000                  2                  1
--                                                                               2                  2
CREATE TABLE T_SNS
(
    SNS_NO NUMBER PRIMARY KEY,
    SNS_NM VARCHAR2(10)
)

DROP TABLE T_SNS

ALTER TABLE T_SNS
    DROP PRIMARY KEY

CREATE TABLE T_SNS_DETAIL
(
    SNS_NO  NUMBER
        CONSTRAINT FK_SNS_NO REFERENCES T_SNS (SNS_NO),
    SNS_BEN NUMBER,
    CONSTRAINT PK_SNS_NO PRIMARY KEY (SNS_NO)
)

ALTER TABLE T_SNS_DETAIL
    DROP PRIMARY KEY



DROP TABLE T_SNS_DETAIL

CREATE TABLE T_SNS_UPLOADED
(
    SNO_NO     NUMBER
        CONSTRAINT FK_UPLOAD_NO REFERENCES T_SNS_DETAIL (SNS_NO),
    SNS_UPLOAD NUMBER,
    CONSTRAINT PK_UPLOAD_NO PRIMARY KEY (SNO_NO, SNS_UPLOAD)
)

--1) 다음 구조를 갖는 테이블을 생성하세요.
--PRODUCT 테이블 - PNO NUMBER PK              : 제품번호
--                PNMAE VARCHAR2(50)          : 제품이름
--                PRI NUMBER                  : 제품단가

CREATE TABLE PRODUCT
(
    PNO   NUMBER PRIMARY KEY,
    PNAME VARCHAR2(50),
    PRI   NUMBER
)

DROP TABLE PRODUCT


--PAYMENT 테이블 - MNO NUMBER PK              : 전표번호
--               PDATE DATE NOT NULL         : 판매일자
--                CNAME VARCHAR2(50) NOT NULL : 고객명
--                TOTAL NUMBER TOTAL > 0      : 총액

CREATE TABLE PAYMENT
(
    MNO   NUMBER PRIMARY KEY,
    PDATE VARCHAR2(50) NOT NULL,
    TOTAL NUMBER CHECK ( TOTAL > 0 )
)

ALTER TABLE PAYMENT
    DROP PRIMARY KEY

DROP TABLE PAYMENT


--PAYMENT_DETAIL - MNO NUMBER PK FK           : 전표번호
--                PNO NUMBER PK FK            : 제품번호
--                AMOUNT NUMBER NOT NULL      : 수량
--                PRICE NUMBER NOT NULL       : 단가
--                TOTAL_PRICE NUMBER NOT NULL TOTAL_PRICE > 0 : 금액

CREATE TABLE PAYMENT_DETAIL
(
    MNO         NUMBER
        CONSTRAINT FK_PA_DE_MNO REFERENCES PAYMENT (MNO),
    PNO         NUMBER
        CONSTRAINT FK_PA_DE_PNO REFERENCES PRODUCT (PNO),
    AMOUNT      NUMBER                           NOT NULL,
    PRICE       NUMBER                           NOT NULL,
    TOTAL_PRICE NUMBER CHECK ( TOTAL_PRICE > 0 ) NOT NULL,
    CONSTRAINT PK_PA_DE PRIMARY KEY (MNO, PNO)
)

DELETE PAYMENT_DETAIL

DROP TABLE PAYMENT_DETAIL