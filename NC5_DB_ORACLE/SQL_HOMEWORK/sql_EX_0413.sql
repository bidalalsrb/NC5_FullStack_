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
select substr(SNAME, 1, length(SNAME) - 1)
from STUDENT

select trim(SNAME)
from STUDENT;

--2번
--<단일 행 함수를 이용하세요>
--1) 교수들이 부임한 달에 근무한 일수는 몇 일인지 검색하세요
select pno, last_day(to_date(HIREDATE)) - to_date(HIREDATE)
from PROFESSOR;

--2) 교수들의 오늘까 지 근무한 주가 몇 주인지 검색하세요
select pno, p.pname, trunc((sysdate - p.HIREDATE) / 7, 0) as 주
from PROFESSOR p;


--3) 1991년에서 1995년 사이에 부임한 교수를 검색하세요
select pno, pname, HIREDATE
from PROFESSOR
where trunc(HIREDATE, 'yyyy') between to_date('1991', 'yyyy') and to_date('1995', 'yyyy');

--4) 학생들의 4.5 환산 평점을 검색하세요(단 소수 이하 둘째자리까지)
select sno, SNAME, round(AVR * 4.5 / 4.0, 2)
from STUDENT

--5) 사원들의 오늘까지 근무 기간이 몇 년 몇 개월 며칠인지 검색하세요
select eno,
       ENAME,
       trunc(months_between(sysdate, HDATE) / 12) || '년' ||
       mod(trunc(months_between(sysdate, HDATE)), 12) || '개월'
           || trunc(SYSDATE - add_months(HDATE, months_between(sysdate, HDATE))) || '일'
from EMP;

-- 3번
--1) 학생의 평균 평점을 다음 형식에 따라 소수점 이하 2자리까지 검색하세요
--'OOO 학생의 평균 평점은 O.OO입니다.'
select SNAME || ' 학생의 평균 평점은 ' || round(avr, 2) || '입니다'
from STUDENT

--2) 교수의 부임일을 다음 형식으로 표현하세요
--'OOO 교수의 부임일은 YYYY년 MM월 DD일입니다.'

SELECT PNAME || ' 교수의 부임일은' || TO_CHAR(HIREDATE, 'YYYY') || '년 ' || TO_CHAR(HIREDATE, 'MM') || '월' ||
       TO_CHAR(HIREDATE, 'DD') || '일'
FROM PROFESSOR

SELECT PNAME || TO_CHAR(HIREDATE, '"교수의 부임일은 "YYYY"년 "MM"월 "DD"입니다"')
FROM PROFESSOR

--3) 교수중에 3월에 부임한 교수의 명단을 검색하세요
SELECT PNO, PNAME, HIREDATE
FROM PROFESSOR
WHERE TO_CHAR(HIREDATE, 'MM') = '03'

UPDATE STUDENT
SET SNAME = REPLACE(SNAME, ' ', '')

COMMIT;

-- 1-6. 변환 함수
-- 숫자를 문자로 변환 TO_CHAR
SELECT TO_CHAR(100000000, '999,999,999') -- 9자리까지 숫자를 표기하되 3자리마다 ,를 표출
FROM DUAL

SELECT TO_CHAR(10000000, '099,999,999') -- 9자리까지 숫자를 표기하되 3자리마다 ,를 표출하고 옆자리에 0을 붙여서 출력
FROM DUAL

SELECT TO_CHAR(1000000, '999,999,999,999,999') --
FROM DUAL

-- 문자를 숫자로 변환 TO_NUMBER
-- 형식지정자의 자리수만 잘 지정해서 사용하거나 형식지정자를 지정하지 않고 사용한다.
SELECT TO_NUMBER('-123.456', '999.999') --문자열 길이보다 형식지정자는 자리수를 같거나 더 많게 지정해준다
FROM DUAL

select to_number('1233', '9999.99')
from DUAL;

select TO_NUMBER('1234')
from DUAL;

-- 날짜를 문자로 변환하는 TO_CHAR
-- TO_CHAR의 날짜 형식 지정
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD')
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS')
     , TO_CHAR(SYSDATE, 'YYYYMMDD DAY')
     , TO_CHAR(SYSDATE, '"오늘은 "YYYY"년 "MM"월 "DD"일 " DAY"입니다."')
-- 형식지정자 안에서 문자열을 추가할 때 ""사용
     , TO_CHAR(SYSDATE, 'YYYY"년  "MONTH DD"일"')
FROM DUAL;

-- 문자를 날짜로 변환하는 TO_DATE
-- 날짜 출력 형식인 NLS_DATE_FORMAT 기준으로 정렬
SELECT TO_DATE('20211201135123', 'YYYY/MM/DD HH24:MI:SS')
     , TO_DATE('202304141059', 'YYYYMMDD HH24-MI')
     , TO_DATE('20230411', 'YYYY-MM-DD')
FROM DUAL

-- TO_DATE 함수로 입사일이 19920201보다 빠른 사원목록 조회
SELECT *
FROM EMP
WHERE EMP.HDATE < TO_DATE('19920201', 'YYYY-MM-DD')

-- 송강교수이 임용일자를 XXXX년 XX월 XX일 XX요일입니다. 조회 TO_CHAR
SELECT PNAME, TO_CHAR(HIREDATE, '""YYYY"년 "MM"월 "DD"입니다"')
FROM PROFESSOR
WHERE PNAME = '송강'

-- 1-7 NULL값 처리를 해주는 NVL
SELECT ENO, ENAME, NVL(COMM, 0) AS COMM
FROM EMP

SELECT C.CNO, C.CNAME, NVL(C.PNO, '안돼'), NVL(P.PNAME, '돌아가')
FROM COURSE C
         LEFT JOIN PROFESSOR P on C.PNO = P.PNO

-- 1-8 조건 처리해주는 DECODE
SELECT ENO,
       ENAME,
       JOB,
       SAL,
       DECODE(JOB,
              '개발', SAL * 1.5,
              '경영', SAL * 1.3,
              '지원', SAL * 1.1,
              '분석', SAL,
              SAL * 0.95) AS CHANGE_SAL
FROM EMP

-- 1-9. 조건 처리해주는 DECODE
SELECT ENO,
       ENAME,
       JOB,
       SAL,
       case JOB
           when '개발' then SAL * 1.5
           when '경영' then SAL * 1.3
           when '지원' then SAL * 1.1
           when '분석' then SAL
           else SAL * 0.95
           end AS CHANGE_SAL
FROM EMP

-- 사원테이블에서 comm이 null인 사람은 해당 사항 없음, 0인 사람은 보너스 없음, 나머지사람들은 보너스: comm
-- 별칭은 comm_txt

select eno,
       ENAME,
       nvl(COMM,-1) as comm,
       case
           when comm > 0 then '보너스 ' || COMM
           when comm < 0 then '보너스 없음'
           else '해당 사항 없음'
           end as comm_txt
from EMP
