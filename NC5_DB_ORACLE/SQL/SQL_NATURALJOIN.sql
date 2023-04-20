-- 1. 추가적인 조인 방식
-- 1-1. NATURAL JOIN
-- NATURAL JOIN에서는 JOIN되는 컬럼에 테이블의 별칭을 달아서 사용할 수 없다.
-- 테이블에 별칭을 달 수 없다.
SELECT SNO, SNAME, AVG(RESULT)
FROM C##MG.SCORE SC
         NATURAL JOIN STUDENT ST
group by SNO, SNAME

-- 학과별 학년별 평점의 최대값 => 학과가 컬럼으로 변경되는 쿼리
-- PIVOT의 메인 FROM절은 사용할 컬럼만 가져올 수 있도록 서브쿼리로
-- 테이블을 재구성하던가 사용할 컬럼만 가지고 있는 테이블을 CREATE TABLE로 새로 만들어서 사용한다.
SELECT *
FROM (SELECT MAJOR, SYEAR, AVR
      FROM STUDENT)
    -- 통계함수를 사용했는데 GROUP BY가 없는 이유는
-- 데이터들이 컬럼이 되면서 컬럼은 중복으로 존재할 수 없기 때문에
-- 자동으로 그룹화된다.
    PIVOT (MAX(AVR)
    FOR MAJOR IN (
        '화학' AS 화학,
        '물리' AS 물리,
        '생물' AS 생물
        )
    )

-- UNPIVOT
-- PIVOT된 테이블 구조를 만들어 준다.
SELECT *
FROM (SELECT SYEAR,
             MAX(DECODE(MAJOR, '물리', AVR)) AS 물리,
             MAX(DECODE(MAJOR, '생물', AVR)) AS 생물,
             MAX(DECODE(MAJOR, '화학', AVR)) AS 화학
      FROM STUDENT
      group by SYEAR)
    UNPIVOT (
    AVR FOR MAJOR
    IN (물리,생물,화학)
    )
ORDER BY MAJOR, SYEAR

-- PIVOT으로 과목명을 열로 만들고 과목명에 해당하는 기말고사 성적의 평균값
SELECT *
FROM (SELECT CNAME, S2.RESULT
      FROM COURSE
               JOIN SCORE S2 on COURSE.CNO = S2.CNO)
    PIVOT
    (AVG(RESULT)
    FOR CNAME IN (
        '생화학',
        '화학사' AS 화학사,
        '일반물리' AS 일반물리,
        '역학' AS 역학,
        '양자역학' AS 양자역학
        )
    )

-- 학생별 기말고사 성적의 평균이 55점 이상인 학생번호, 학생이름, 기말고사 평균 출력 natural join

SELECT SNO, SNAME, ROUND(AVG(RESULT))
FROM STUDENT
         NATURAL JOIN C##MG.SCORE
group by SNO, SNAME
HAVING AVG(RESULT) >= 55

-- 최대 급여가 4천만원 이상되는 부서의 번호, 부서 이름, 급여조회

SELECT DNO, DNAME, MAX(SAL)
FROM EMP
         NATURAL JOIN DEPT
group by DNAME, DNO
HAVING MAX(SAL) >= 4000


-- 1-2 JOIN~USING
-- JOIN ON
SELECT SC.CNO, C.CNAME, AVG(SC.RESULT)
FROM C##MG.SCORE SC
         JOIN COURSE C on SC.CNO = C.CNO
group by SC.CNO, C.CNAME
HAVING AVG(SC.RESULT) >= 53

-- JOIN~USING
SELECT CNO, C.CNAME, AVG(SC.RESULT)
FROM C##MG.SCORE SC
         JOIN COURSE C USING (CNO)
group by C.CNAME, CNO
HAVING AVG(SC.RESULT) >= 53

-- 학점이 3점인 과목의 교수번호,교수이름,과목번호,과목이름,학점
SELECT PNO, P.PNAME, C.CNO, C.CNAME, C.ST_NUM
FROM PROFESSOR P
         JOIN COURSE C USING (PNO)
WHERE ST_NUM = 3

-- 2. 다중 컬럼 IN절
--  DNO = 01이면서 JOB이 경영인 사원이나 DNO이 30이면서 JOB이 회계인 사원 조회
SELECT DNO, ENO, ENAME, JOB
FROM EMP
WHERE (DNO, JOB) IN (('01', '경영'), ('30', '회계'))

SELECT DNO, ENO, ENAME, JOB
FROM EMP
WHERE (DNO = '10' AND (JOB = '분석' OR JOB = '개발'))
   OR (DNO = '20' AND (JOB = '분석' OR JOB = '개발'))

-- 다중컬럼 IN절을(CNO, PNO) 이용해서
-- 기말고사 성적의 평균이 48점 이상인
-- 과목번호 과목명 교수번호 교수이름 기말고사 성적 평균 조회

SELECT CNO, C.CNAME, PNO, P.PNAME, AVG(SC.RESULT)
FROM C##MG.SCORE SC
         NATURAL JOIN COURSE C
         NATURAL JOIN PROFESSOR P
WHERE (CNO, PNO) IN (SELECT CNO, PNO
                     FROM C##MG.SCORE SCC
                              NATURAL JOIN COURSE CC
                              NATURAL JOIN PROFESSOR PP
                     GROUP BY CNO, PNO
                     HAVING AVG(SCC.RESULT) >= 48)
GROUP BY CNO, C.CNAME, PNO, P.PNAME

-- 사수의 정보를 다중 컬럼 IN을 이용해서 조회
-- DNO, MGR 부서번호는 01,02 사수번호 0001인 사원번호,사원이름, 사수번호, 부서번호 조회

SELECT ENO, ENAME, MGR, DNO
FROM EMP
WHERE (DNO, MGR) IN
      (SELECT DNO, MGR
       FROM EMP
       WHERE DNO IN ('01', '02')
         AND MGR = '0001');

-- 3. WITH
-- 가상테이블 생성
WITH DNO10 AS (SELECT * FROM DEPT),
     JOBDEV AS (SELECT * FROM EMP WHERE JOB = '개발')
SELECT JOBDEV.ENO, JOBDEV.ENAME, JOBDEV.DNO, DNO10.DNAME, JOBDEV.JOB
FROM JOBDEV,
     DNO10
WHERE JOBDEV.DNO = DNO10.DNO;

-- 화학과 학생명단(스튜던트 전체),
-- 기말고사 성적중 과목명에 화학이 포함되는 테이블 성적 정보를 가상 테이블로 생성 ( SCORE의 CNO,SNO,RESULT
-- COURCE의 NAME

-- 학생별 화학이 포함된 과목이 기말고사 성적의 평균// 학생번호 학생이름 평균성적
WITH ST AS (SELECT * FROM STUDENT WHERE MAJOR = '화학'),
     SCO AS (SELECT SC.CNO, SC.SNO, RESULT
             FROM C##MG.SCORE SC
                      JOIN COURSE C2 on SC.CNO = C2.CNO AND C2.CNAME LIKE '%화학%'
             GROUP BY SC.CNO, SC.SNO, RESULT)
SELECT ST.SNO, ST.SNAME, round(avg(RESULT))
FROM ST,
     SCO
WHERE ST.SNO = SCO.SNO
group by ST.SNO, ST.SNAME
order by SNO

