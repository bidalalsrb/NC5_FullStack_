-- 0411 HOMEWORK
--1)student 테이블 구조를 검색해라
--2)course 테이블 구조를 검색해라
select *
from COURSE;
--3)professor 테이블 구조를 검색해라
select *
from PROFESSOR;
--4)score 테이블 구조를 검색해라
select *
from C##MG.SCORE;
--5) 모든 학생의 정보를 검색해라
select *
from STUDENT;
--7) 모든 과목의 정보를 검색해라
select *
from COURSE;
--8) 기말고사 시험점수를 검색해라
select RESULT
from C##MG.SCORE;
--9) 학생들의 학과와 학년을 검색해라
select MAJOR, SYEAR
from STUDENT;
--10) 각 과목의 이름과 학점을 검색해라
select CNAME, ST_NUM
from COURSE;
--11) 모든 교수의 직위를 검색해라 ;
select ORDERS
from PROFESSOR;

--1) 각 학생의 평점을 검색하라(별칭을 사용)
select SNAME, AVR as 평점
from STUDENT;
--2) 각 과목의 학점수를 검색하라(별칭을 사용)
select CNAME, ST_NUM AS 학점수
from COURSE;
--3) 각 교수의 지위를 검색하라(별칭을 사용)
select PNAME, ORDERS as 지위
from PROFESSOR;
--4) 급여를 10%인상했을 때 연간 지급되는 급여를 검색하라(별칭을 사용)
select ENAME, SAL * 1.1 as 연간급여
from EMP;
--5) 현재 학생의 평균 평점은 4.0만점이다. 이를 4.5만점으로 환산해서 검색하라(별칭을 사용)
select sname, to_char(AVR * 1.125, 'FM990.00') as 만점
from STUDENT;

--1) '__학과인 __학생의 현재 평점은 __입니다' 형태로 학생의 정보를 출력하라
select MAJOR || '학과인 ' || STUDENT.SNAME || ' 학생의 현재 평점은 ' || to_char(AVR, 'FM990.99') || '입니다'
FROM STUDENT;

--2) '__과목은 __학점 과목입니다.' 형태로 과목의 정보를 출력하라
select CNAME || ' 과목은 ' || ST_NUM || ' 학점 과목입니다'
from COURSE;

--3) '__교수는 __학과 소속입니다.' 형태로 교수의 정보를 출력하라
select PNAME || ' 교수는 ' || SECTION || ' 학과 소속입니다'
from PROFESSOR;

--4) 학교에는 어떤 학과가 있는지 검색한다(학생 테이블 기반으로 검색한다)
select Distinct MAJOR
from STUDENT;

--5) 학교에는 어떤 학과가 있는지 검색한다(교수 테이블 기반으로 검색한다)
select distinct SECTION
from PROFESSOR;

--6) 교수의 지위는 어떤 것들이 있는지 검색한다
select distinct ORDERS
from PROFESSOR;
--1) 성적순으로 학생의 이름을 검색하라
select *
from STUDENT
order by AVR DESC;

--2) 학과별 성적순으로 학생의 정보를 검색하라
select *
from STUDENT
order by MAJOR, AVR DESC;

--3) 학년별 성적순으로 학생의 정보를 검색하라
select *
from STUDENT
order by SYEAR, AVR desc;

--4) 학과별 학년별로 학생의 정보를 성적순으로 검색하라
select *
from STUDENT
order by MAJOR, SYEAR, AVR DESC;

--5) 학점순으로 과목 이름을 검색하라
select MAJOR, AVR
from STUDENT
order by AVR DESC;

--6) 각 학과별로 교수의 정보를 검색하라
select *
from PROFESSOR
order by SECTION;

--7) 지위별로 교수의 정보를 검색하라
select *
from PROFESSOR
order by ORDERS desc;

--8) 각 학과별로 교수의 정보를 부임일자 순으로 검색하라
select *
from PROFESSOR
order by SECTION, HIREDATE;

--1) 화학과 학생을 검색하라
select *
from STUDENT
where MAJOR = '화학';

--2) 평점이 2.0 미만인 학생을 검색하라
select *
from STUDENT
where AVR < 2.0;

--3) 관우 학생의 평점을 검색하라
select SNAME, AVR
from STUDENT
where SNAME = '관우';

--4) 정교수 명단을 검색하라
select *
from PROFESSOR
where ORDERS = '정교수';

--5) 화학과 소속 교수의 명단을 검색하라
select *
from PROFESSOR
where SECTION = '화학';

--6) 송강 교수의 정보를 검색하라
select *
from PROFESSOR
where PNAME = '송강';

--7) 학년별로 화학과 학생의 성적을 검색하라
select SYEAR, SNAME, MAJOR, AVR
from STUDENT
where MAJOR = '화학'
order by SYEAR;

--8) 2000년 이전에 부임한 교수의 정보를 부임일순으로 검색하라
-- select *
-- from PROFESSOR
-- where HIREDATE < 2000 - 01 - 01;

--9) 담당 교수가 없는 과목의 정보를 검색하라
select *
from COURSE
where PNO is NOT NULL;

--1) 유공과와 생물과, 식영과 학생을 검색하라
select *
from STUDENT
where MAJOR = '유공'
   OR MAJOR = '생물'
   OR MAJOR = '식영';
--2) 화학과가 아닌 학생중에 1학년 학생을 검색하라
select *
from STUDENT
WHERE MAJOR != '화학'
  and SYEAR = 1;

--3) 물리학과 3학년 학생을 검색하라
select *
from STUDENT
where MAJOR = '물리'
  and SYEAR > 3;

--4) 평점이 2.0에서 3.0사이인 학생을 검색하라
select *
from STUDENT
where AVR > '2.0'
  and AVR < '3.0';
--5) 교수가 지정되지 않은 과목중에 학점이 3학점인 과목을 검색하라
select *
from COURSE
where PNO is NULL
  and ST_NUM = '3';

--6) 화학과 관련된 과목중 평점이 2학점 이하인 과목을 검색하라
select *
from COURSE
where CNAME LIKE '%화학%'
  and ST_NUM <= 2;

--7) 화학과 정교수를 검색하라
select *
from PROFESSOR
where ORDERS = '정교수'
  and SECTION LIKE '%화학%';

--8) 물리학과 학생중에 성이 사마씨인 학생을 검색하라
select *
from STUDENT
where MAJOR = '물리'
  and SNAME LIKE '사마%';

--9) 성과 이름이 각각 1글자인 교수를 검색하라
select *
from PROFESSOR
where PNAME LIKE '__';
