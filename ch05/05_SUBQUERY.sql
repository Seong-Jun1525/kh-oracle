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
	- 다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행 여러 열일 때 (N행 N열)
	
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
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
	SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE
);

-- 전지연 사원과 같은 부서의 사원들의 사번, 사원명, 연락처, 입사일, 부서명을 조회
-- 단, 전지연 사원은 제외하고 조회
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE,  DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND EMP_NAME != '전지연' AND DEPT_CODE = (
	SELECT DEPT_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME = '전지연'
);

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME != '전지연' AND DEPT_CODE = (
	SELECT DEPT_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME = '전지연'
);
-- =============================================================================
/*
	다중행 서브쿼리 : 서브쿼리 결과가 여러 행인 경우 (N행 1열)
	IN (서브쿼리) : 여러 개의 결과값 중에 하나라도 일치하는 값이 있을 경우 조회
	
	☞ > ANY (서브쿼리) : 여러 개의 결과값 중에서 하나라도 큰 경우가 있다면 조회
	☞ < ANY (서브쿼리) : 여러 개의 결과값 중에서 하나라도 작은 경우가 있다면 조회
	
	☞ > ALL (서브쿼리) : 여러 개의 모든 결과값보다 큰 경우가 있다면 조회
	☞ < ALL (서브쿼리) : 여러 개의 모든 결과값보다 작은 경우가 있다면 조회
*/
-- 유재식 사원 또는 윤은해 사원과 같은 직급인 사원들의 정보 조회 (사번, 사원명, 직급코드, 급여)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (
	SELECT JOB_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME IN ('유재식', '윤은해')
);

-- 대리직급인 사원들 중 과장 직급의 급여보다 많이 받는 사원 정보조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
	JOIN JOB USING(JOB_CODE) 
WHERE JOB_NAME = '대리' AND SALARY > ANY (
	SELECT SALARY
	FROM EMPLOYEE
		JOIN JOB USING (JOB_CODE)
	WHERE JOB_NAME = '과장'
);
-- =============================================================================
/*
	다중열 서브쿼리 : 서브쿼리 결과가 1개 행이고, 여러 개의 열인 경우
*/
-- 하이유 사원과 같은 부서, 같은 직급인 사원 정보를 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- 단일행 서브쿼리를 사용한다면
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (
	SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유'
) AND JOB_CODE = (
	SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유'
);

-- 다중열 서브쿼리를 사용한다면?
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
	SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유'
);

-- 박나라 사원과 직급이 같고, 사수가 동일한 사원의 사원명, 직급코드, 사수번호를 조회
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME <>  '박나라' AND (JOB_CODE, MANAGER_ID) = (
	SELECT JOB_CODE, MANAGER_ID
	FROM EMPLOYEE
	WHERE EMP_NAME = '박나라'
);

-- =============================================================================
/*
	다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행, 여러 열인 경우
*/
-- 각 직급별로 최소급여를 받는 사원 정보를 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
	SELECT JOB_CODE, MIN(SALARY)
	FROM EMPLOYEE
	GROUP BY JOB_CODE
)
ORDER BY JOB_CODE;

-- =============================================================================
/*
	인라인 뷰 : 서브쿼리를 FROM 절에 사용하는 것
		☞ 서브쿼리의 결과를 마치 테이블처럼 사용하는 것
*/
-- 사번, 이름, 보너스 포함 연봉, 부서코드를 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", (SALARY + (NVL(BONUS, 0) * SALARY)) * 12 AS "보너스 포함 연봉", DEPT_CODE AS "부서코드"
FROM EMPLOYEE
WHERE ((SALARY + (NVL(BONUS, 0) * SALARY)) * 12) >= 30000000;

-- TOP-N 분석
-- ☞ ROWNUM 조회된 행에 대하여 순서대로 1부터 순번을 부여해주는 가상컬럼
SELECT ROWNUM, "사번", "사원명", "보너스 포함 연봉", "부서코드" -- 별칭을 사용했으면 별칭으로 작성해줘야한다
FROM (
	SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", (SALARY + (NVL(BONUS, 0) * SALARY)) * 12 AS "보너스 포함 연봉", DEPT_CODE AS "부서코드"
	FROM EMPLOYEE
	WHERE ((SALARY + (NVL(BONUS, 0) * SALARY)) * 12) >= 30000000
	ORDER BY 3 DESC
)
WHERE ROWNUM <= 5;

-- 가장 최근에 입사한 사원 5명 조회
SELECT ROWNUM, EMP_ID, EMP_NAME, HIRE_DATE
FROM (
	SELECT EMP_ID, EMP_NAME, HIRE_DATE
	FROM EMPLOYEE
	ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;
-- ROWNUM에 대한 조건을 중간 위치로 하고자 할 경우 인라인 뷰에 컬럼과 같이 작성 후 사용해야 함
-- =============================================================================
/*
	* 순서를 매기는 함수(WINDOW FUNCTION)
	- RANK() OVER (정렬 기준)			: 동일한 순위 이후의 등수를 동일한 수 만큼 건너뛰고 순위 계산
	- DENSE_RANK() OVER (정렬 기준) 		: 동일한 순위가 있더라도 그 다음 등수를 +1해서 순위 계산
	
	☞ SELECT 절에서만 사용 가능하다!
*/
-- 급여가 높은 순서대로 순위를 매겨서 조회
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999'), RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
-- 공동 19위인 2명이 있고, 그 뒤의 순위는 21위로 표시됨

SELECT EMP_NAME AS "사원명", TO_CHAR(SALARY, 'L999,999,999') AS "급여", DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
-- 공동 19위인 2명이 있고, 그 뒤의 순위는 20위로 표시됨

-- 상위 5명만 조회
SELECT 사원명, 급여, 순위
FROM (
	SELECT EMP_NAME AS "사원명", TO_CHAR(SALARY, 'L999,999,999') AS "급여", DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
	FROM EMPLOYEE
)
WHERE ROWNUM <= 5;

-- 상위 3등 ~ 5등
SELECT *
FROM (
	SELECT EMP_NAME AS "사원명", TO_CHAR(SALARY, 'L999,999,999') AS "급여", RANK() OVER(ORDER BY SALARY DESC) AS "순위"
	FROM EMPLOYEE
)
WHERE 순위 BETWEEN 3 AND 5;

-- =============================================================================
-- [1] ROWNUM을 활용하여 급여가 가장 높은 5명 조회하려 했으나 제대로 조회되지 않았다.
/*
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

위의 SELECT문의 문제점과 해결방안을 작성하여라
☞ 문제점 : ROWNUM은 행의 번호를 매겨주는 것이다.
		이것을 그냥 컬럼명으로 작성하게되면 기본적으로 저장되어 있는 컬럼의 순번으로 적용되고
		그 후 SALARY를 기준으로 내림차순 정렬했으므로 제대로 동작되지 않는다.
		
☞ 해결방안 
SELECT ROWNUM, EMP_NAME, SALARY
FROM (
	SELECT EMP_NAME, SALARY
	FROM EMPLOYEE
	ORDER BY SALARY DESC
)
WHERE ROWNUM <= 5;
서브쿼리 중 인라인 뷰를 활용하여 SALARY를 기준으로 내림차순 정렬된 데이터를 테이블로 활용하고 그것을 기반으로 ROWNUM 조건을 주면 해결된다.

*/
SELECT ROWNUM, EMP_NAME, SALARY
FROM (
	SELECT EMP_NAME, SALARY
	FROM EMPLOYEE
	ORDER BY SALARY DESC
)
WHERE ROWNUM <= 5;

-- [2] 부서별로 평균급여가 270만원을 초과하는 부서에 해당하는 부서코드, 부서별 총 급여합, 부서별 평균급여, 부서별 사원 수를 조회하려 했으나 제대로 조회가 되지 않았다.
/*
SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균, COUNT(*) 사원수
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

위의 SELECT문의 문제점과 해결방안을 작성하여라
☞ 문제점 : WHERE 절은 그룹화 하기 이전의 데이터 상태에서 조건을 판별하는건데 평균 급여가 270만을 초과하는 것을 찾으려면 그룹화한 후에 조건을 줘야한다
☞ 해결방안 : WHERE절이 아닌 HAVING 절을 사용해야한다

SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균, COUNT(*) 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;
*/
SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균, COUNT(*) 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

-- 또는
SELECT *
FROM (
	SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균, COUNT(*) 사원수
	FROM EMPLOYEE
	GROUP BY DEPT_CODE
)
WHERE 평균 > 2700000;