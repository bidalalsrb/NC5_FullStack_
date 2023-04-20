-- 1. OUTER JOIN 연습
CREATE TABLE BOARD_FILE
(
    BOARD_NO    NUMBER,
    BOARD_TITLE VARCHAR2(50)
);

CREATE TABLE BOARD_FILE
(
    BOARD_NO NUMBER,
    FILE_NM  VARCHAR2(50)
);

DROP TABLE BOARD_FILE

select *
from BOARD_FILE;

select *
from BOARD;

INSERT INTO BOARD_FILE
VALUES (10, 'a');
INSERT INTO BOARD_FILE
VALUES (11, 'a');
INSERT INTO BOARD_FILE
VALUES (12, 'a');
INSERT INTO BOARD_FILE
VALUES (13, 'a');

select A.BOARD_TITLE, BF.BOARD_NO
from BOARD A
         LEFT OUTER JOIN BOARD_FILE BF on A.BOARD_TITLE = BF.FILE_NM;

select A.*, BF.BOARD_NO
from BOARD A
         INNER JOIN BOARD_FILE BF on A.BOARD_TITLE = BF.FILE_NM;


select A.BOARD_TITLE, B.BOARD_NO, NVL(B.FILE_NM, 'NO FILE')
from BOARD A
         FULL OUTER JOIN BOARD_FILE B
                         ON A.BOARD_NO = B.BOARD_NO;

--  2. INNER JOIN
-- SCORE 테이블의 모든 데이터와 추가로 STUDENT 테이블의 학생이름 조회
select SC.*, ST.SNAME
from C##MG.SCORE SC
         INNER JOIN STUDENT ST on SC.SNO = ST.SNO;
-- 모든 사원정보와 부서명 동시에 조회
select st.*, D.DNAME
from EMP st
         INNER JOIN DEPT D
                    on st.dno = D.DNO;
select st.*, d.DNAME, d.LOC
from EMP st,
     DEPT d
where st.DNO = D.DNO;

-- 비등가 조인
select SC.*, gr.grade
from C##MG.SCORE SC
         inner join SCGRADE gr
                    on SC.RESULT between gr.LOSCORE and gr.HISCORE;
select e.*, d.GRADE
from EMP e
         inner join SALGRADE D
                    on e.SAL between d.LOSAL and d.HISAL
order by SAL desc;

-- CrossJoin
-- 조인 조건을 명시하지 않으면 의미없는 데이터가 조회된다.
select A.ENO, A.ENAME, A.DNO, B.DNAME
from EMP A,
     DEPT B;

-- 셀프조인
-- FROM절의 테이블과 조인되는 테이블이 같을 때
-- 사원의 사수의 이름 조회
SELECT A.ENO, A.ENAME, A.MGR, B.ENO, B.ENAME
FROM EMP A
         JOIN EMP B
              ON A.MGR = B.ENO;
--
-- 3. OUTER JOIN
-- 사원의 사수의 이름 조회 사수의 정보가 존재하지 않는 사원들도 모두 조회
-- 1. ANSI
SELECT A.ENO, A.ENAME, A.MGR, B.ENO, B.ENAME
FROM EMP A
         LEFT OUTER JOIN EMP B
                         on A.MGR = B.ENO;
-- 2. ORACLE
SELECT A.ENO, A.ENAME, A.MGR, B.ENO, B.ENAME
FROM EMP A
   , EMP B
WHERE A.MGR = B.ENO(+);

-- 과목들의 정보를 조회, 교수의 이름과 같이 조회, 담당교수가 배정되지 않은 과목도 함께 조회
select st.*, pf.PNAME
from COURSE st
         LEFT OUTER JOIN PROFESSOR pf
                         on st.PNO = pf.PNO;

select st.*, pf.PNAME
from COURSE st,
     PROFESSOR pf
WHERE st.PNO = pf.PNO(+);

-- 4. 다중 조인
-- 사원의 모든 정보 조회, 급여 등급, 부서명이 같이 조회되도록

SELECT e.eno,
       e.ename,
       e.MGR,
       m.ename,
       e.SAL,
       s.GRADE,
       e.DNO,
       d.dname
from EMP e
         JOIN SALGRADE s
              on e.SAL between s.LOSAL and s.HISAL
         JOIN DEPT d
              on e.DNO = d.DNO
         join EMP m
              on e.MGR = m.ENO;
-- 기말고사의 성적을 조회할 건데 과목이름, 담당교수 이름 함께 조회 과목번호 순서로 정렬 학생이름, 그레이드 조인해서

select c.CNAME, p.PNAME, s.RESULT, sc.GRADE, st.sname
from C##MG.SCORE s
         join COURSE c
              on s.CNO = c.CNO
         join PROFESSOR P
              on c.PNO = p.PNO
         join SCGRADE sc
              on RESULT between sc.LOSCORE and sc.HISCORE and GRADE = 'F'
         join STUDENT st
              on st.SNO = s.SNO
order by sc.GRADE;









