--1) 각 학과별 학생 수를 검색하세요
SELECT MAJOR, COUNT(*)
FROM STUDENT
group by MAJOR

--2) 화학과와 생물학과 학생 4.5 환산 평점의 평균을 각각 검색하세요
SELECT MAJOR, AVG(AVR * 1.125)
FROM STUDENT
group by MAJOR
HAVING MAJOR IN ('화학', '생물')

--3) 부임일이 10년 이상 된 직급별(정교수, 조교수, 부교수) 교수의 수를 검색하세요
SELECT ORDERS, COUNT(*)
FROM PROFESSOR
where months_between(sysdate, HIREDATE) / 12 >= 25
group by ORDERS

--4) 과목명에 화학이 포함된 과목의 학점수 총합을 검색하세요
SELECT SUM(ST_NUM)
FROM COURSE
WHERE CNAME LIKE '%화학%'
-- group by ST_NUM

--6) 학과별 기말고사 평균을 성적순(성적 내림차순)으로 검색하세요
SELECT st.MAJOR, AVG(s2.RESULT)
FROM STUDENT st
         join SCORE S2 on st.SNO = S2.SNO
group by st.MAJOR
order by AVG(s2.RESULT)

--7) 30번 부서의 업무별 연봉의 평균을 검색하세요(소수점 두자리까지 표시)
SELECT dno, E.JOB, ROUND(AVG(E.SAL), 2)
FROM EMP E
group by JOB, dno
having DNO = 30

--8) 물리학과 학생 중에 학년별로 성적이 가장 우수한 학생의 평점을 검색하세요
SELECT major, SYEAR, MAX(AVR)
FROM STUDENT
-- JOIN SCORE S2 on STUDENT.SNO = S2.SNO AND MAJOR = '물리'
WHERE MAJOR = '물리'
group by SYEAR, major

-- 2번
--1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하세요
SELECT MAJOR, AVG(AVR)
FROM STUDENT
group by MAJOR
HAVING MAJOR != '화학'

--2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 이상인 정보를 검색하세요
SELECT MAJOR, AVG(AVR)
FROM STUDENT
group by MAJOR
HAVING MAJOR != '화학'
   AND AVG(AVR) >= 2.0

--3) 기말고사 평균이 60점 이상인 학생의 정보를 검색하세요
SELECT S2.SNO, AVG(RESULT)
FROM STUDENT
         JOIN SCORE S2 on STUDENT.SNO = S2.SNO
group by S2.SNO
HAVING AVG(RESULT) >= 60

--4) 강의 학점이 3학점 이상인 교수의 정보를 검색하세요
SELECT PNAME, SECTION, ST_NUM
FROM PROFESSOR
         JOIN COURSE C2 on PROFESSOR.PNO = C2.PNO AND ST_NUM >= 3

--5) 기말고사 평균 성적이 //  핵 화학과목보다 우수한 과목의 과목명과 // 담당 교수명을 검색하세요
SELECT AVGRESULT.CNO, AVGRESULT.CNAME, AVGRESULT.PNO, P.PNAME, AVGRESULT.RESULT
FROM (SELECT SC.CNO, C.CNAME, C.PNO, ROUND(AVG(SC.RESULT), 2) AS RESULT
      FROM C##MG.SCORE SC
               JOIN COURSE C on SC.CNO = C.CNO
      GROUP BY SC.CNO, C.CNAME, C.PNO) AVGRESULT
         JOIN PROFESSOR P ON AVGRESULT.PNO = P.PNO
WHERE AVGRESULT.RESULT > (SELECT ROUND(AVG(RESULT), 2)
                          FROM C##MG.SCORE SCO
                                   JOIN COURSE CO on SCO.CNO = CO.CNO
                              AND CO.CNAME = '핵화학'
                          GROUP BY SCO.CNO)

--6) 근무 중인 직원이 4명 이상인 부서를 검색하세요
SELECT DNAME, COUNT(*)
FROM EMP
         JOIN DEPT D
              on EMP.DNO = D.DNO
group by DNAME
HAVING COUNT(*) >= 4

--7) 업무별 평균 연봉이 3000 이상인 업무를 검색하세요
SELECT JOB, ROUND(AVG(SAL))
FROM EMP
group by JOB
HAVING AVG(SAL) >= 3000

--8) 각 학과의 학년별 인원중 인원이 5명 이상인 학년을 검색하세요
SELECT MAJOR, SYEAR, COUNT(*)
FROM STUDENT
group by MAJOR, SYEAR
HAVING COUNT(*) >= 5
