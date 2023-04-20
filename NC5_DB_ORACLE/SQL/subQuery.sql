-- 1. 서브쿼리
-- 단일 행 쿼리

select *
from PROFESSOR
where PNAME = '송강';

-- 단일 행 서브쿼리
-- 송강보다 부임일시가 빠른 교수들의 목록 조회
select p.*
from PROFESSOR P
where p.HIREDATE < (select HIREDATE
                    from PROFESSOR
                    where PNAME = '송강');

-- 손하늘 사원보다 급여가 높은 사원 목록 조회
select e.*
from EMP E
         join (select SAL
               from EMP
               where ENAME = '손하늘') B
              on e.SAL > B.SAL;
-- 노육학생의 정보

select s.*
from STUDENT S
where SNAME = '노육';

-- 노육이라는 학생들과 학점이 같은 학생 목록 조회
select *
from STUDENT ST
         Join(select AVR from STUDENT where STUDENT.SNAME = '노육') b
             on st.avr = b.AVR;
-- 기말고사 성적이 95점 이상인 학번,과목번호 과목명, 성적 => 서브쿼리
-- 학생테이블이랑 조인해서 학번, 이름, 번호, 과목명, 성적, 전공

SELECT B.*, ST.MAJOR
FROM STUDENT ST
         JOIN (SELECT SC.SNO, SC.CNO, C.CNAME, SC.RESULT
               FROM SCORE SC
                        JOIN COURSE C
                             ON C.CNO = SC.CNO AND SC.RESULT >= 95) B
              ON B.SNO = ST.SNO;


-- score,scgrade,student => 하나의 서브쿼리
select sc.sno, st.sname, sc.cno, sc.RESULT, sg.grade
from C##MG.SCORE SC
         join STUDENT st on SC.SNO = st.SNO
         join SCGRADE sg
              on sc.RESULT between sg.LOSCORE and sg.HISCORE;
-- course, professor, -> 하나의 서브쿼리로(담당교수가 없는 과목도 조회)
select c.cno, c.CNAME, c.PNO, p.pname
from COURSE c
         left join PROFESSOR P on c.PNO = P.PNO;
-- 위 서브쿼리 테이블 2개를 다시 조인해서 결과
-- 기말고사의 성적을 조회할 건데 담당교수가 없는 과목도 나올 수 있또록
-- 과목이름, 담당교수 이름, 학생이름, 점수등급 함께 조회 과목번호 순서로 정렬

SELECT A.sno
     , a.SNAME
     , b.CNO
     , b.CNAME
     , b.PNO
     , a.RESULT
     , a.GRADE
from (select sc.sno, st.sname, sc.cno, sc.RESULT, sg.grade
      from C##MG.SCORE SC
               join STUDENT st on SC.SNO = st.SNO
               join SCGRADE sg
                    on sc.RESULT between sg.LOSCORE and sg.HISCORE) A
         Right join (select c.cno, c.CNAME, c.PNO, p.pname
                     from COURSE c
                              left join PROFESSOR P on c.PNO = P.PNO) B
                    on a.CNO = b.CNO
order by b.CNO;

-- 2. 집합연산자
-- 2-1 합집합 연산자
-- 2000년 이후에 임용된 교수와 2000년 이후에 입사한 직원의 목록 조회
SELECT PNO      AS 직원번호
     , PNAME    AS 직원이름
     , HIREDATE AS 입사일시
FROM PROFESSOR
WHERE HIREDATE > TO_DATE('19991231 23:59:59', 'YYYYMMDD HH24:MI:SS')
UNION
SELECT ENO
     , ENAME
     , HDATE
FROM EMP
WHERE HDATE > TO_DATE('19991231 23:59:59', 'YYYYMMDD HH24:MI:SS')

-- 2-2 차집합 연산자
-- 성이 제갈이면서 지원업무를 하지 않는 사원의 사원번호, 사원이름,업무
SELECT ENO
     , ENAME
     , JOB
FROM EMP
WHERE ENAME LIKE '제갈%'
MINUS
SELECT ENO, ENAME, JOB
FROM EMP
WHERE JOB = '지원';

-- 과목중에서 담당교수가 배정이 안되었거나 담당교수의 정보가 존재하지 않는 과목번호,과목명
SELECT CNO, CNAME
FROM COURSE
MINUS
SELECT C.CNO, C.CNAME
FROM COURSE C
         JOIN PROFESSOR P on C.PNO = P.PNO

-- 화학과 교수중에 일반화학 수업을 하지 않는 교수들만 조회
SELECT PNO, PNAME
FROM PROFESSOR
WHERE SECTION = '화학'
MINUS
SELECT P.PNO, P.PNAME
FROM PROFESSOR P
         JOIN COURSE C2 on P.PNO = C2.PNO
-- WHERE C2.CNAME = '일반화학'
    AND C2.CNAME = '일반화학'

-- 2-3 교집합 연산자
-- 물리, 화학과 학생중 학점이 3.0 이상인 학생의 학번, 학생이름, 학과, 평점 조회
SELECT SNO, SNAME, MAJOR, AVR
FROM STUDENT
WHERE MAJOR IN ('물리', '화학')
INTERSECT
SELECT SNO, SNAME, MAJOR, AVR
FROM STUDENT
WHERE AVR>=3.0

select sysdate
from dual