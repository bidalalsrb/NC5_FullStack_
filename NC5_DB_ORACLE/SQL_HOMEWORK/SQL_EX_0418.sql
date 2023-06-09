--1) STUDENT 테이블을 참조하여 ST_TEMP 테이블을 만들고 모든 학생의 성적을 4.5만점 기준으로 수정하세요
CREATE TABLE ST_TEMP
AS
SELECT *
FROM STUDENT

UPDATE ST_TEMP
SET AVR = AVR * 1.125

select *
from ST_TEMP;

--2) PROFESSOR 테이블을 참조하여 PF_TEMP 테이블을 만들고 모든 교수의 부임일자를 100일 앞으로 수정하세요
CREATE TABLE PF_TEMP
AS
SELECT *
FROM PROFESSOR

UPDATE PF_TEMP
SET HIREDATE = HIREDATE - 100

select *
from PF_TEMP;

--3) ST_TEMP 테이블에서 화학과 2학년 학생의 정보를 삭제하세요

DELETE
FROM ST_TEMP
WHERE MAJOR = '화학'
  AND SYEAR = '2'

select *
from ST_TEMP;

--4) PF_TEMP 테이블에서 조교수의 정보를 삭제하세요
DELETE
FROM PF_TEMP
WHERE ORDERS = '조교수'

select *
from PF_TEMP;

--5) EMP 테이블을 참조하여 EMP2 테이블을 만들고 DNO = 30인 사원의 보너스를 15프로 상승시킨 값으로 변경하시고
--   DNO = 20인 사원의 급여를 10프로 상승시킨 값으로 변경하세요.
CREATE TABLE EMP2
AS
SELECT *
FROM EMP

update EMP2
set comm = comm * 1.15,
    dno  = 30

update EMP2
set SAL = EMP2.SAL * 1.1,
    dno=20



drop table EMP2

select *
from EMP2;

--6) 화학과 2학년 학생중 기말고사 성적의 등급이 A, B인 정보를 갖는 테이블 SCORE_STGR을 생성하세요.
-- (SNO, SNAME, MAJOR, SYEAR, RESULT, GRADE)
CREATE TABLE SCORE_STGR(sno, sname, major, syear, result, grade)
AS
SELECT SNO, ST.SNAME, ST.MAJOR, ST.SYEAR, C.RESULT, SG.GRADE
FROM SCGRADE sg,
     STUDENT st
         natural join C##MG.SCORE c
WHERE RESULT BETWEEN LOSCORE AND HISCORE
  AND GRADE IN ('A', 'B')
  AND MAJOR = '화학'
  AND SYEAR = '2'

drop table SCORE_STGR

select *
from SCORE_STGR
order by grade;
--7) 생물학과 학생중 평점이 2.7이상인 학생이 수강중인 과목의 정보를 갖는 테이블 ST_COURSEPF를 생성하세요.
-- (SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR)
CREATE TABLE ST_COURSEPF
AS
SELECT SNO,
       S.SNAME,
       CNO,
       CNAME,
       PNO,
       PNAME,
       S.AVR,
       RESULT
FROM STUDENT S
         NATURAL JOIN COURSE
         NATURAL JOIN PROFESSOR
         NATURAL JOIN C##MG.SCORE
WHERE MAJOR = '생물'
  AND AVR >= 2.7

drop table ST_COURSEPF

select *
from ST_COURSEPF;