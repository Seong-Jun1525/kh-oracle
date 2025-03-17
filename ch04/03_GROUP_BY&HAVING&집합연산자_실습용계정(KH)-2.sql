/*
	ROLLUP, CUBE : 그룹 별 산출 결과 값의 집계 계산 함수
	
	☞ ROLLUP : 전달받은 그룹 중 가장 먼저 지정한 그룹 별로 추가적 집계 결과반환
	☞ CUBE : 전달받은 그룹들로 가능한 모든 조합 별 집계 결과 반환
*/
-- 각 부서별 부서내 직급별 급여합, 부서 별 급여합, 전체 직원 급여 총합 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;
-- ==============================================================
/*
	실행 순서
	SELECT 조회하고자 하는 컬럼 AS "별칭" 또는 * 또는 함수식 또는 연산식						5
	FROM 조회하고자 하는 테이블 명 또는 DUAL												1
	WHERE 조건식 (연산자들을 활용하여 작성)												2
	GROUP BY 그룹화 기준이 되는 컬럼 또는 함수식 또는 연산식								3
	HAVING 조건식(그룹함수를 활용하여 작성)												4
	ORDER BY 컬럼명 혹은 컬럼 순번 혹은 별칭 [ ASC | DESC] [NULLS LAST | NULLS FIRST]		6
	
	오라클에서는 순서 1부터 시작!!
*/
-- ==============================================================
/*
	집합 연산자 : 여러 개의 명령문(SQL문 / 쿼리문)을 하나의 명령문으로 만들어주는 연산자
	
	- UNION : 합집합 (두 명령문을 수행한 결과 셋을 더해줌) ☞  OR 연산자와 유사
	- INTERSECT : 교집합 (두 명령문을 수행한 결과 셋의 중복된 부분을 추출해줌) ☞ AND 연산자와 유사
	- UNION ALL : 합집합 + 교집합 (중복되는 부분이 두번 조회될 수 있음)
	- MINUS : 차집합 (선행 결과에서 후행 결과를 뺀 나머지)
*/
-- ** UNION **
-- 부서 코드가 'D5'인 사원 또는 급여가 300만원을 초과하는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 OR DEPT_CODE = 'D5';


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** INTERSECT **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 AND DEPT_CODE = 'D5';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** UNION ALL **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** MINUS **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

/*
	집합 연산자 사용 시 주의사항 ★★★
	1) 명령문들의 컬럼 갯수가 동일해야 함
	2) 컬럼 자리마다 동일한 데이터타입으로 작성해야함
	3) 정렬을 하고자 할 경우 ORDER BY 절의 위치는 가장 마지막에 작성해야함
	
	☞ RESULT SET을 통해 작업하기 때문!!
*/