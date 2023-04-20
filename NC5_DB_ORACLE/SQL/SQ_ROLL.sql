-- 1. 그룹화 관련 함수
-- 1.1 ROLLUP
-- ROLLUP 사용 X
-- GROUP BY 컬럼의 개수로 다 그룹화된 결과
SELECT DNO, JOB, MAX(SAL), SUM(SAL), AVG(SAL), COUNT(*)
FROM EMP
group by DNO, JOB

-- ROLLUP
-- 처음에는 그룹화 컬럼 모두에 대한 그룹화 진행
-- 다음부터는 그룹화 컬럼에서 마지막에 있는 컬럼을 하나씩 제거하고 그룹화 진행
-- 마지막에는 모든 그룹화 컬럼에 대한 그룹화가 진행되지 않은 전체 데이터에 대한 결과
SELECT DNO, JOB, MAX(SAL), SUM(SAL), AVG(SAL), COUNT(*)
FROM EMP
group by ROLLUP (DNO, JOB)
ORDER BY DNO, JOB

-- 1-2 CUBE 함수
-- CUBE 는 ROLLUP과 지정방식이 동일하지만 동작방식이 다르다.
-- 그룹화되는 컬럼들의 모든 조합의 그룹화를 진행하여 결과를 출력
SELECT DNO, JOB, MAX(SAL), SUM(SAL), AVG(SAL), COUNT(*)
FROM EMP
group by CUBE (DNO, JOB)
ORDER BY DNO, JOB

-- 1-3 GROUPING SETS
-- 그룹화로 지정된 컬럼들의 각각의 그룹화를 진행한 결과
SELECT DNO, JOB, MAX(SAL), SUM(SAL), AVG(SAL), COUNT(*)
FROM EMP
group by GROUPING SETS (DNO, JOB)
ORDER BY DNO, JOB

-- 1-4 그룹화 함수
-- GROUPING
-- 그룹화 여부 확인
SELECT DNO,
       JOB,
       MAX(SAL),
       SUM(SAL),
       ROUND(AVG(SAL), 1),
       COUNT(*),
       GROUPING(DNO),
       GROUPING(JOB)
FROM EMP
group by ROLLUP (DNO, JOB)
ORDER BY DNO, JOB

-- GROUPING_ID
-- GROUPING의 결과를 이진수로 인식하여 십진수로 변환한 값을 표시
SELECT DNO
     , JOB
     , MAX(SAL)
     , SUM(SAL)
     , ROUND(AVG(SAL), 1)
     , COUNT(*)
     , GROUPING(DNO)
     , GROUPING(JOB)
     , GROUPING_ID(DNO, JOB)
FROM EMP
group by ROLLUP (DNO, JOB)
ORDER BY DNO, JOB


-- LISTAGG
-- LISTAGG 사용 x
SELECT DNO, ENAME
FROM EMP
GROUP BY DNO, ENAME

-- LISTAGG 사용
-- 그룹화된 컬럼에 속한 데이터 확인
SELECT DNO, LISTAGG(ENAME, ', ') WITHIN GROUP ( ORDER BY SAL DESC )
FROM EMP
group by DNO

-- 1-6. PIVOT
-- PIVOT 사용 X
SELECT JOB, MAX(SAL)
FROM EMP
group by JOB

-- 조회되는 행의 데이터를 컬럼으로 사용할 수 있는 PIVOT
SELECT *
FROM (SELECT JOB, SAL
      FROM EMP) A
    PIVOT (MAX(SAL)
    FOR JOB IN ( '경영' AS OPER,
        '지원' AS HELP,
        '개발' AS DEV,
        '회계' AS ACCOUNT,
        '분석' AS ANALYS)
    )

--
SELECT *
FROM (SELECT JOB, DNO, SAL
      FROM EMP) A
    PIVOT (MAX(SAL)
    FOR JOB IN ( '경영' AS OPER,
        '지원' AS HELP,
        '개발' AS DEV,
        '회계' AS ACCOUNT,
        '분석' AS ANALYS)
    )
ORDER BY DNO

-- 1-7 UNPIVOT
-- UNPIVOT 사용 X
SELECT *
FROM (SELECT DNO,
             MAX(DECODE(JOB, '경영', SAL)) AS "경영",
             MAX(DECODE(JOB, '지원', SAL)) AS "지원",
             MAX(DECODE(JOB, '회계', SAL)) AS "회계",
             MAX(DECODE(JOB, '개발', SAL)) AS "개발",
             MAX(DECODE(JOB, '분석', SAL)) AS "분석"
      FROM EMP
      group by DNO)

-- UNPIVOT 사용
SELECT *
FROM (SELECT DNO,
             MAX(DECODE(JOB, '경영', SAL)) AS "경영",
             MAX(DECODE(JOB, '지원', SAL)) AS "지원",
             MAX(DECODE(JOB, '회계', SAL)) AS "회계",
             MAX(DECODE(JOB, '개발', SAL)) AS "개발",
             MAX(DECODE(JOB, '분석', SAL)) AS "분석"
      FROM EMP
      group by DNO)
UNPIVOT (
    SAL FOR JOB IN("경영","지원","회계","개발","분석")
        );