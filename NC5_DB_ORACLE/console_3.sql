-- 1번

--1) 평점이 3.0에서 4.0사이의 학생을 검색하라(between and)
select *
from STUDENT
where AVR between 3.0 and 4.0
order by AVR;

--2) 1994년에서 1995년까지 부임한 교수의 명단을 검색하라(between and)
select *
from PROFESSOR
where HIREDATE between '1994-01-01' and '1995-12-31'
order by HIREDATE;

--3) 화학과와 물리학과, 생물학과 학생을 검색하라(in)
select *
from STUDENT
where MAJOR in ('화학', '물리', '생물')
order by SYEAR;

--4) 정교수와 조교수를 검색하라(in)
select *
from PROFESSOR
where ORDERS in ('정교수', '조교수')
order by ORDERS;

--5) 학점수가 1학점, 2학점인 과목을 검색하라(in)
select *
from COURSE
where ST_NUM in ('1', '2')

--6) 1, 2학년 학생 중에 평점이 2.0에서 3.0사이인 학생을 검색하라(between and)
select *
from STUDENT
where SYEAR between '1' and '2'
  and AVR between 2.0 and 3.0
order by SYEAR;

--7) 화학, 물리학과 학생 중 1, 2 학년 학생을 성적순으로 검색하라(in)
select *
from STUDENT
where MAJOR in ('화학', '물리')
  and SYEAR in ('1', '2')
order by SYEAR;

--8) 부임일이 1995년 이전인 정교수를 검색하라(to_date)
select *
from PROFESSOR
where HIREDATE < to_date('19950101', 'YYYY-MM-DD');
-- 2번
--1) 송강 교수가 강의하는 과목을 검색한다
select C.CNAME, p.PNAME
from COURSE C
         JOIN PROFESSOR P
              on c.PNO = p.PNO
                  AND P.PNAME = '송강';


--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
select C.CNAME, p.PNAME
from COURSE C
         join PROFESSOR P on C.PNO = P.PNO
    AND c.CNAME LIKE '%화학%';

--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
select C.CNAME, c.ST_NUM, p.PNAME
from COURSE C
         join PROFESSOR P on C.PNO = P.PNO AND c.ST_NUM = '2';

--4) 화학과 교수가 강의하는 과목을 검색한다
select P.*
from PROFESSOR P
         join COURSE C2 on P.PNO = C2.PNO;

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
select p.SECTION, s.SNAME, s.AVR
from PROFESSOR P
         join STUDENT s on p.SECTION = s.MAJOR and s.SYEAR = '1';

--6) 일반화학 과목의 기말고사 점수를 검색한다
select s.*
from C##MG.SCORE s
         join COURSE c on c.CNO = s.CNO and c.CNAME = '일반화학';

--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다

select s.SNAME, s.MAJOR, s2.RESULT, c2.CNAME
from STUDENT s
         join SCORE S2
              on s.SNO = S2.SNO and s.SYEAR = '1' and s.MAJOR = '화학'
         join COURSE C2
              on S2.CNO = C2.CNO and c2.CNAME = '일반화학';
--8) 화학과 1학년 학생이 수강하는 과목을 검색한다
select DISTINCT c2.CNO, c2.CNAME, s.SYEAR, c2.CNAME
from STUDENT s
         join SCORE S2 on s.SNO = S2.SNO and SYEAR = '1' and s.MAJOR = '화학'
         join COURSE C2 on S2.CNO = C2.CNO;

--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다
select s2.RESULT, s.SNAME, sc.GRADE, c2.CNAME
from STUDENT s
         join SCORE S2 on s.SNO = S2.SNO
         join SCGRADE sc on s2.RESULT between sc.LOSCORE and sc.HISCORE and sc.GRADE = 'F'
         join COURSE C2 on S2.CNO = C2.CNO and c2.CNAME = '유기화학';
-- 3번
--1) 학생중에 동명이인을 검색한다
select distinct *
from;

--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다
select p.*
from PROFESSOR P
         join COURSE C2 on P.PNO = C2.PNO
order by p.SECTION;

--3) 이번 학기 등록된 // 모든 과목과 담당 교수의 학점 순으로 검색한다
select c2.CNAME, p.PNAME, c2.ST_NUM
from PROFESSOR P
         join COURSE C2 on P.PNO = C2.PNO
order by ST_NUM;

-- 4번
--1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
select p.PNAME,c2.CNAME
from PROFESSOR p
join COURSE C2 on p.PNO = C2.PNO;

--2) 화학과 학생의 기말고사 성적을 모두 검색하라
select S.*,s2.RESULT
from STUDENT S
join SCORE S2 on S.SNO = S2.SNO and s.MAJOR = '화학';

--3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
select c2.CNAME, s2.RESULT
from STUDENT S
join SCORE S2 on S.SNO = S2.SNO
join COURSE C2 on S2.CNO = C2.CNO and c2.CNAME = '유기화학';

--4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라
select s3.* , P.PNAME
from PROFESSOR P
join COURSE C2 on P.PNO = C2.PNO
join SCORE S2 on C2.CNO = S2.CNO
join STUDENT S3 on S2.SNO = S3.SNO and s3.MAJOR = '화학'
;
