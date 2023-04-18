--1) 각 학과별 학년별 학생 수를 ROLLUP함수로 검색하세요
SELECT MAJOR, SYEAR, COUNT(*)
FROM STUDENT
GROUP BY ROLLUP ( MAJOR, SYEAR)
ORDER BY SYEAR

--2) 화학과와 생물학과 학생 4.5 환산 평점의 평균을 각각 검색하는 데
-- 화학과 생물이 열로 만들어지도록 하세요.(PIVOT 사용)

SELECT *
FROM (SELECT MAJOR, ROUND(AVR * 1.125) AS AV
      FROM STUDENT)
    PIVOT (AVG(AV)
    FOR MAJOR IN (
        '화학' AS 화학
        , '생물' AS 생물)
    )

--3) 학과별 학생이름을 ,로 구분하여 성적순으로(내림차순) 조회하세요.(LISTAGG 사용)
SELECT MAJOR, LISTAGG(SNAME, ', ') WITHIN GROUP ( ORDER BY AVR )
FROM STUDENT
group by MAJOR

--4) 부서별 업무별 연봉의 평균을 검색하세요(부서와 업무 컬럼의 그룹화 여부도 같이 검색, GROUPING 사용)
SELECT DNAME, E.JOB, ROUND(AVG(SAL)), GROUPING(DNAME), GROUPING(JOB)
FROM DEPT
         JOIN EMP E on DEPT.DNO = E.DNO
group by GROUPING SETS (E.JOB, DNAME)

-- 2

--1) 각 과목의 과목번호, 과목명, 담당 교수의 교수번호, 교수명을 검색하라(NATURAL JOIN 사용)
SELECT CNO, CNAME, PNO, PNAME
FROM COURSE
         NATURAL JOIN PROFESSOR

--2) 화학과 학생의 기말고사 성적을 모두 검색하라(JOIN USING 사용)
SELECT SNO, SNAME, MAJOR, RESULT
FROM STUDENT
         JOIN SCORE S2 USING (SNO)
WHERE MAJOR = '화학'

--3) 화학 관련 과목을 강의하는 교수의 명단을 검색한다(NATURAL JOIN 사용)
SELECT PNO, PNAME, CNAME
FROM PROFESSOR
         NATURAL JOIN COURSE
WHERE CNAME LIKE '%화학%'

--4) 화학과 1학년 학생의 기말고사 성적을 검색한다(NATURAL JOIN 사용)
SELECT SNO, SNAME, MAJOR, SYEAR, RESULT
FROM STUDENT
         NATURAL JOIN C##MG.SCORE
WHERE SYEAR = 1
  AND MAJOR = '화학'

--5) 일반화학 과목의 기말고사 점수를 검색한다(JOIN USING 사용)

SELECT CNO, CNAME, RESULT
FROM COURSE
         JOIN SCORE S2 USING (CNO)
WHERE CNAME = '일반화학'


--6) 화학과 1학년 학생이 수강하는 과목을 검색한다(NATURAL JOIN 사용)

SELECT SNO, SNAME, SYEAR, MAJOR, CNAME
FROM STUDENT
         NATURAL JOIN SCORE
         NATURAL JOIN COURSE
WHERE MAJOR = '화학'
  AND SYEAR = 1


--1) 다중 컬럼 IN절을 이용해서 기말고사 성적이 80점 이상인 과목번호, 학생번호, 기말고사 성적을 모두 조회하세요.
SELECT *
FROM C##MG.SCORE
WHERE (SNO, CNO) IN (SELECT SNO, CNO
                     FROM C##MG.SCORE
                     WHERE RESULT >= 80)


--2) 다중 컬럼 IN절을 이용해서 화학과나 물리학과면서 학년이 1, 2, 3학년인 학생의 정보를 모두 조회하세요.
SELECT *
FROM STUDENT
WHERE (MAJOR, SYEAR) IN (SELECT MAJOR, SYEAR
                         FROM STUDENT
                         WHERE MAJOR IN ('물리', '화학')
                           AND SYEAR IN ('1', '2', '3'))

--3) 다중 컬럼 IN절을 사용해서 부서가 10, 20, 30이면서
-- 보너스가 1000이상인 사원의 사원번호, 사원이름, 부서번호, 부서이름, 업무, 급여, 보너스를
--   조회하세요.(서브쿼리 사용)
SELECT ENO, ENAME, DNO, DNAME, JOB, SAL, COMM
FROM DEPT
         NATURAL JOIN EMP
WHERE (DNO, COMM) IN (SELECT DNO, COMM
                      FROM DEPT
                      WHERE DNO IN (10, 20, 30)
                        AND COMM >= 1000)


--4) 다중 컬럼 IN절을 사용하여 기말고사 성적의 최고점이 100점인
-- 과목의 과목번호, 과목이름, 학생번호, 학생이름, 기말고사 성적을 조회하세요.(서브쿼리 사용)
SELECT CNO, CNAME, SNO, SNAME, RESULT
FROM C##MG.SCORE
         NATURAL JOIN COURSE
         NATURAL JOIN STUDENT
WHERE RESULT IN (SELECT RESULT
                 FROM C##MG.SCORE
                 WHERE RESULT = 100)

-- 3번
--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는
-- 가상테이블 하나를 생성하여
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)

WITH PRO AS (SELECT * FROM PROFESSOR WHERE ORDERS = '정교수'),
     COUR AS (SELECT * FROM COURSE WHERE CNAME LIKE '%일반%')
SELECT COUR.CNO, COUR.CNAME, PRO.PNO, PRO.PNAME
FROM COUR,PRO
WHERE COUR.PNO = PRO.PNO

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와
-- 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.

WITH MONEY AS (SELECT * FROM EMP WHERE SAL >= 3000),
     BONUS AS (SELECT * FROM EMP WHERE COMM >= 500)
SELECT *
FROM MONEY
NATURAL JOIN BONUS



--3) WITH 절을 이용하여
-- 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와
-- 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
WITH SAM AS (SELECT * FROM STUDENT WHERE AVR >= 3.3),
     AV AS (SELECT SNO, ROUND(AVG(RESULT),2) AS QQ FROM C##MG.SCORE group by SNO)
SELECT SAM.SNO, SAM.SNAME, AVR, AV.QQ
FROM SAM,
     AV
WHERE SAM.SNO = AV.SNO


--4) WITH 절을 이용하여
-- 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와
-- 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을 갖는 가상테이블 하나를 생성하여
-- 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.

WITH PROF AS (SELECT * FROM PROFESSOR where months_between(sysdate, HIREDATE) / 12 >= 25 ORDER BY HIREDATE),
     STU AS (SELECT C2.CNO, C2.CNAME, ST.SNO, ST.SNAME, P.PNO, S2.RESULT
             FROM STUDENT ST
                      JOIN SCORE S2 on ST.SNO = S2.SNO
                      JOIN COURSE C2 on S2.CNO = C2.CNO
                      JOIN PROFESSOR P on C2.PNO = P.PNO
             WHERE S2.RESULT >= 90)
SELECT STU.CNO,
       STU.CNAME,
       STU.SNO,
       STU.SNAME,
       PROF.PNO,
       PROF.PNAME,
       STU.RESULT,
       PROF.HIREDATE
FROM PROF,
     STU
WHERE PROF.PNO = STU.PNO
ORDER BY HIREDATE DESC



V