--<단일 행 함수를 사용하세요>
--1) 이름이 두 글자인 학생의 이름을 검색하세요
select SNAME
from STUDENT
where length(SNAME) = 3

--2) '공'씨 성을 가진 학생의 이름을 검색하세요
select SNAME
from STUDENT
where instr(SNAME, '공') = '1';

--3) 교수의 지위를 한글자로 검색하세요(ex. 조교수 -> 조)
select substr(ORDERS, 1, 1)
from PROFESSOR

--4) 일반 과목을 기초 과목으로 변경해서 모든 과목을 검색하세요
--  (ex. 일반화학 -> 기초화학)
select translate(CNAME, '일반', '기초')
from COURSE

--5) 만일 입력 실수로 student테이블의 sname컬럼에 데이터가 입력될 때
--   문자열 마지막에 공백이 추가되었다면 검색할 때 이를 제외하고
--   검색하는 SELECT 문을 작성하세요


--2번
--<단일 행 함수를 이용하세요>
--1) 교수들이 부임한 달에 근무한 일수는 몇 일인지 검색하세요
select last_day(to_date(HIREDATE)) - to_date(HIREDATE)
from PROFESSOR;

--2) 교수들의 오늘까 지 근무한 주가 몇 주인지 검색하세요
select p.pname, trunc((sysdate - p.HIREDATE) / 7, 0) as 주
from PROFESSOR p;


--3) 1991년에서 1995년 사이에 부임한 교수를 검색하세요
select pname
from PROFESSOR
where HIREDATE between '1991-01-01' and '1995-12-31';

--4) 학생들의 4.5 환산 평점을 검색하세요(단 소수 이하 둘째자리까지)


--5) 사원들의 오늘까지 근무 기간이 몇 년 몇 개월 며칠인지 검색하세요
select mod(trunc(sysdate-EMP.HDATE,0),)
from EMP;

-- 3번
--1) 학생의 평균 평점을 다음 형식에 따라 소수점 이하 2자리까지 검색하세요
--'OOO 학생의 평균 평점은 O.OO입니다.'


--2) 교수의 부임일을 다음 형식으로 표현하세요
--'OOO 교수의 부임일은 YYYY년 MM월 DD일입니다.'

--3) 교수중에 3월에 부임한 교수의 명단을 검색하세요
