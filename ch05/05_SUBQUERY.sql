/*
	* 서브쿼리 (SUBQUERY)
	- 하나의 쿼리문 내에 포함된 또 다른 쿼리문
	- 메인 역할을 하는 쿼리문을 위해 보조 역할을 하는 쿼리문
*/
-- "노옹철" 사원과 같은 부서에 속한 사원 정보를 조회
-- 1) 노옹철 사원의 부서코드를 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서코드가 D9인 사원 정보
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (
	SELECT DEPT_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME = '노옹철'
);
	
-- 전체 사원의 평균 급여보다 더 많은 급여를 받는 사원의 정보를 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY > (
	SELECT ROUND(AVG(SALARY))
	FROM EMPLOYEE
);
-- =============================================================================
/*
	* 서브쿼리의 종류
	- 서브쿼리를 수행한 결과값이 몇 행 몇 열로 나오냐에 따라 분류
	
	- 단일행 서브쿼리 : 서브쿼리의 결과가 오로지 1개일 때 (1행 1열)
	- 다중행 서브쿼리 : 서브쿼리의 결과가 여러 행일 때 (N행 1열)
	- 다중열 서브쿼리 : 서브쿼리의 결과가 한 행이고 여러 열일 때 (1행 N열)
	-- 다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행 여러 열일 때 (N행 N열)
	
	☞ 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐
*/
-- 단일행 서브쿼리
-- ☞ 일반적인 비교연산자 사용 가능

-- 전 사원의 평균 급여보다 더 적게 급여를 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME AS "사원명", JOB_CODE AS "직급코드", TO_CHAR(SALARY, 'L999,999,999') AS "급여"
FROM EMPLOYEE
WHERE SALARY < (
	SELECT ROUND(AVG(SALARY))
	FROM EMPLOYEE
);

-- 급여가 가장 적은 사원의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME AS "사원명", JOB_CODE AS "직급코드", TO_CHAR(SALARY, 'L999,999,999') AS "급여"
FROM EMPLOYEE
WHERE SALARY = (
	SELECT MIN(SALARY)
	FROM EMPLOYEE
);
--WHERE SALARY = MIN(SALARY) -- 이런식으로 조건을 줄 수 없다
/*
	ORA-00934: 그룹 함수는 허가되지 않습니다
	00934. 00000 -  "group function is not allowed here"
*/

-- 노옹철 사원의 급여보다 많이 받는 사원의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME AS "사원명", DEPT_CODE AS "부서코드", TO_CHAR(SALARY, 'L999,999,999') AS "급여"
FROM EMPLOYEE
WHERE SALARY > (
	SELECT SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '노옹철'
);

-- 부서코드를 부서명으로 조회하고자 한다면?
-- 오라클 구문
SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서코드", TO_CHAR(SALARY, 'L999,999,999') AS "급여"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND SALARY > (
	SELECT SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '노옹철'
);

-- ANSI 구문
SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서코드", TO_CHAR(SALARY, 'L999,999,999') AS "급여"
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (
	SELECT SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '노옹철'
);

-- 부서별 급여합이 가장 큰 부서의 부서코드, 급여합 조회
SELECT DEPT_CODE, SUM(SALARY) AS "급여합"
FROM EMPLOYEE
GROUP BY DEPT_CODE;