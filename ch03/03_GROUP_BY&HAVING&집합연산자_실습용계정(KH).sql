/*
	GROUP BY 절
	☞ 그룹 기준을 제시할 수 있는 구문
	☞ 여러 개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/

-- 전체 사원의 총 급여 조회
SELECT SUM(SALARY) FROM EMPLOYEE;

-- 부서별 총 급여 조회
SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999') AS "급여 총 합"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 부서별 사원 수 조회
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 부서코드가 'D1', 'D6', 'D9'인 각 부서별 급여 총합, 사원 수 조회
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "급여 총 합", COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1', 'D6', 'D9')
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 각 직급 별 총 사원수, 보너스를 받는 사원 수, 급여 합, 평균 급여, 최저 급여, 최고 급여
-- 직급 코드 오름 차순 정렬
SELECT JOB_CODE, COUNT(*) AS "총 사원수",
	COUNT(BONUS) AS "보너스를 받는 사원 수",
	TO_CHAR(SUM(SALARY), 'L999,999,999') AS "급여 합", 
	TO_CHAR(ROUND(AVG(SALARY)), 'L999,999,999') AS "평균급여",
	TO_CHAR(MIN(SALARY), 'L999,999,999') AS "최저 급여",
	TO_CHAR(MAX(SALARY), 'L999,999,999') AS "최고 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 남자 사원수, 여자 사원 수 조회
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') AS "성별", COUNT(*) AS "사원수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- 부서 내의 직급별 사원수, 급여 총합
SELECT DEPT_CODE, JOB_CODE, COUNT(*) AS "사원수", TO_CHAR(SUM(SALARY), 'L999,999,999') AS "급여 총합"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- 부서코드 기준으로 그룹화하고, 그룹 내에서 직급코드 기준으로 세부그룹화를 함
ORDER BY DEPT_CODE;

-- ==============================================================
/*
	WHERE 절은 그룹화 하기 전의 조건식 비교

	HAVING 절
	☞ 그룹에 대한 조건을 제시할 때 사용하는 구문(보통, 그룹함수식을 사용하여 조건을 작성함)

*/
-- 부서별 평균 급여 조회
SELECT DEPT_CODE, TO_CHAR(ROUND(AVG(SALARY))) AS "평균 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 평균 급여가 300만원 이상인 부서만 조회
SELECT DEPT_CODE, TO_CHAR(ROUND(AVG(SALARY))) AS "평균 급여"
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, TO_CHAR(ROUND(AVG(SALARY))) AS "평균 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) >= 3000000;

-- 부서별로 보너스를 받는 사원이 없는 부서의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

SELECT BONUS FROM EMPLOYEE WHERE DEPT_CODE = 'D2';