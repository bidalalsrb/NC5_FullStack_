-- 1.DML
-- 1-1 INSERT INO
-- 일부 컬럼만 데이터를 저장
INSERT INTO EMP(ENO, ENAME, JOB, HDATE, SAL)
VALUES (3006, '홍길동', '개발', SYSDATE, 3000)

-- 모든 컬럼의 데이터를 저장
INSERT INTO EMP
VALUES (3007, '임꺽정', '설계', 2008, SYSDATE, 3000, 200, 30)

-- COMMIT, ROLLBACK
-- COMMIT은 작업의 완료
-- ROLLBACK은 작업의 취소, COMMIT되기 전의 변경사항을 모두 최소.
INSERT INTO EMP
VALUES (3008, '장길산', '분석', 2008, SYSDATE, 3000, 100, 20);
INSERT INTO EMP
VALUES (3008, '장길산1', '분석', 2008, SYSDATE, 3000, 100, 20);
INSERT INTO EMP
VALUES (3008, '장길산3', '분석', 2008, SYSDATE, 3000, 100, 20);

ROLLBACK;

select *
from EMP;

-- 1-2 INSERT INTO 다량의 데이터를 한 번에 저장
CREATE TABLE EMP_COPY
(
    ENO   VARCHAR2(4),
    ENAME VARCHAR2(20),
    JOB   VARCHAR2(10),
    MGR   VARCHAR2(4),
    HDATE DATE,
    SAL   NUMBER(5),
    COMM  NUMBER(5),
    DNO   VARCHAR2(2)
)

-- EMP 테이블에서 DNO이 30인 데이터들만 가져와서 저장
INSERT INTO EMP_COPY
SELECT *
FROM EMP
WHERE DNO = '30'

-- COURSE_PRFESS 테이블 생성
CREATE TABLE COURSE_PREFESS
(
    CNO    VARCHAR2(8),
    CNAME  VARCHAR2(20),
    ST_NUM NUMBER(1, 0),
    PNO    VARCHAR2(8),
    PNAME  VARCHAR2(20)
);

-- COURSE_PREFESS 테이블에 COURSE,PORFESSOR 조인해서 PNAME까지 저장
INSERT INTO COURSE_PREFESS
SELECT C.CNO, C.CNAME, C.ST_NUM, P.PNO, P.PNAME
FROM COURSE C
         LEFT JOIN PROFESSOR P on C.PNO = P.PNO

select *
from COURSE_PREFESS;

-- 데이터를 삭제하는 DELETE FROM
DELETE
FROM COURSE_PREFESS;

-- 1-3 UPDATE SET
-- 전체 데이터 수정
UPDATE EMP_COPY
SET MGR = 0001

-- 사원번호 3005번 보너스 *3으로 수정
UPDATE EMP_COPY
SET COMM=1800
WHERE ENO = 3005;

-- 사원번호 3005번 보너스 *3으로 수정 (연산사용)
UPDATE EMP_COPY
SET COMM = COMM * 3
WHERE ENO = 3005;

-- PROFESSOR 테이블의 HIREDATE를 + 20년 해서 업데이트
UPDATE PROFESSOR
SET HIREDATE = ADD_MONTHS(HIREDATE, 240);

-- EMP_COPY의 데이터 삭제
DELETE EMP_COPY

-- EMP의 전체 데이터를 EMP_COPY에 저장
INSERT INTO EMP_COPY
SELECT *
FROM EMP

-- 20,30번 부서 사원들 60부서로 통합 보너스가 현재 보너스의 *1.5
UPDATE EMP_COPY
SET DNO  = '60',
    COMM = COMM * 1.5
WHERE DNO IN (20, 30)

-- DEPT_COPY 테이블 생성
CREATE TABLE DEPT_COPY AS
SELECT *
FROM DEPT

SELECT *
FROM DEPT_COPY

-- 서브쿼리를 이용한 데이터 수정
UPDATE DEPT_COPY
SET (DNO, DNAME) =(SELECT DNO, DNAME
                   FROM DEPT
                   WHERE DNO = '50')
WHERE DNO IN (20, 30)

-- 40번 부서의 DIRECTOR를 EMP테이블의 급여가 제일 높은 사원으로 업데이트
UPDATE DEPT_COPY
SET DIRECTOR = (SELECT ENO
                FROM EMP
                WHERE SAL = (SELECT MAX(SAL)
                             FROM EMP))
WHERE DNO = 40

-- 1-4 DELETE FROM
-- 전체 데이터 삭제 => 조건절 생략
DELETE
FROM EMP_COPY

-- 일부 데이터 삭제 => WHERE절로 조건 추가
DELETE
FROM EMP_COPY
WHERE JOB = '지원'

-- WHERE 절에 서브쿼리를 사용하여 특정 데이터 삭제
-- EMP_COPY 급여가 4000 이상되는 사원 정보 삭제
DELETE
FROM EMP_COPY
WHERE ENO IN (SELECT ENO
              FROM EMP_COPY
              WHERE SAL > 4000)

-- STUDENT 테이블 참조하여 ST_COPY생성
CREATE TABLE ST_COPY AS
SELECT *
FROM STUDENT

-- SCORE 학생별 기말고사 성적 평균이 60점 이상 학생정보 ST_COPY에서 삭제
DELETE
FROM ST_COPY
WHERE SNO IN (SELECT SNO
              FROM C##MG.SCORE
              GROUP BY SNO
              HAVING AVG(RESULT) >= 60)


SELECT *
FROM ST_COPY;

-- 1-5 LOCK

UPDATE EMP_COPY
SET ENAME = 'RRR'
WHERE DNO = '60'

SELECT *
FROM EMP_COPY;

-- SELECT DEADLOCK 구문(데이터가 많을 경우)
SELECT A.*
     , B.*
     , C.*
FROM STUDENT A,
     COURSE B,
     PROFESSOR C







