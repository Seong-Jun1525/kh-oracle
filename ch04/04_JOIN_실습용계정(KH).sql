/*
	★★★ JOIN
	☞ 두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문
		조회 결과는 하나의 결과물(Result Set)로 나옴
	☞ 관계형 데이터베이스에서는 최소한의 데이터를 각각의 테이블에 저장
		☞ 중복 저장을 최소화하기 위해 최대한 쪼개서 관리함
	☞ 관계형 데이터베이스에서 쿼리문을 사용하여 테이블 간의 "관계"를 맺는 방법
			(각 테이블 간의 연결고리(외래키)를 통해서 데이터를 매칭시켜 조회함)
	
	☞ JOIN은 크게 "오라클 전용 구문"과 ANSI 구문(표준)"
			오라클 전용 구문			|				ANSI 구문
		=====================================================
				등가 조인			|				내부 조인
			   (EQUAL JOIN)			|			(INNER JOIN) ☞ JOIN ON / USING
	----------------------------------------------------------------------------------------------------
				포괄 조인			|			  왼쪽 외부 조인(LEFT OUTER JOIN)
			 (LEFT JOIN)				| 			오른쪽 외부 조인(RIGHT OUTER JOIN)
			 (RIGHT JOIN)			|			전체 외부 조인(FULL OUTER JOIN)
	----------------------------------------------------------------------------------------------------
			자체 조인(SELF JOIN)		|				JOIN ON
	비등가 조인(NON EQUAL JOIN)	|
	========================================================================
	
*/
-- 전체 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- 부서 정보에서 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급 코드 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

-- 직급 정보에서 직급 코드, 직급명 조회
SELECT JOB_CODE, JOB_NAME
FROM JOB;
-- ==============================================================
/*
	* 등가 조인(EQUAL JOIN) / 내부 조인(INNER JOIN)
	- 연결시키는 컬럼의 값이 일치하는 행들만 조회 (☞ 일치하지 않는 값은 결과에서 제외)
*/
-- ORACLE 전용 구문
/*
	- FROM 절에 조회하고자 하는 테이블을 나열(콤마(,)로 구분)
	- WHERE 절에 매칭시킬 컬럼에 대한 조건을 작성
*/
-- 사원의 사번, 이름, 부서명을 조회
-- ☞ 부서코드 컬럼으로 연결!
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", DEPT_TITLE AS "부서명"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- ☞ 일치하지 않는 값들은 결과에서 제외됨
	-- EMPLOYEE 테이블에서는 DEPT_CODE 값이 NULL인 경우
	-- DEPARTMENT 테이블에서는 EMPLOYEE 테이블에 존재하지 않는 데이터
	-- ☞ 각 테이블에서만 존재하는 데이터들은 제외됨

-- 사원의 사번, 사원명, 직급명을 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", JOB_NAME AS "직급명", J.JOB_CODE AS "직급코드"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE
-- ==============================================================
-- * ANSI 구문 *
/*
	- FROM 절에 기준이 되는 테이블 하나 작성
	- JOIN 절에 조인하고자 하는 테이블을 기술 + 매칭시키고자 하는 조건 작성
		* JOIN ON : 컬럴명이 같거나 다른경우 둘다 사용 가능
			FROM 테이블1
				JOIN 테이블2 ON (조건식)
		* JOIN USING : 컬럼명이 같은 경우만 사용 가능
			FROM 테이블1
				JOIN 테이블2 USING (컬럴명)
*/
-- 사번, 사원명, 부서명 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", D.DEPT_TITLE AS "부서명"
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

-- 사번 사원명, 직급명 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", J.JOB_NAME AS "부서명"
FROM EMPLOYEE E JOIN JOB J USING (JOB_CODE);

SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", J.JOB_NAME AS "부서명"
FROM EMPLOYEE E JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- 대리 직급인 사원의 사번, 사원명, 직급명, 급여
-- ORACLE 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE AND JOB.JOB_NAME = '대리';

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '대리';

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '대리');
-- ==============================================================
-- [1] 부서가 인사관리부인 사원들의 사번, 사원명, 보너스 조회
-- ORACLE 구문
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", NVL(BONUS, 0) AS "보너스"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE = '인사관리부';

-- ANSI 구문
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", NVL(BONUS, 0) AS "보너스"
FROM EMPLOYEE E JOIN  DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

-- [2] 부서와 지역정보를 참고하여, 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
		-- 지역 : LOCATION 테이블 참고
-- ORACLE 구문 
SELECT D.DEPT_ID, D.DEPT_TITLE, L.LOCAL_CODE, L.LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

-- ANSI 구문
SELECT D.DEPT_ID, D.DEPT_TITLE, L.LOCAL_CODE, L.LOCAL_NAME
FROM DEPARTMENT D JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- [3] 보너스를 받는 사원의 사번, 사원명, 보너스, 부서명 조회
-- ORACLE 구문 
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", BONUS AS "보너스", D.DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND BONUS IS NOT NULL;

-- ANSI 구문
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", BONUS AS "보너스", D.DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE BONUS IS NOT NULL;

-- [4] 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
-- ORACLE 구문 
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND D.DEPT_TITLE != '총무부';

-- ANSI 구문
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE != '총무부';

-- ==============================================================
/*
	포괄 조인 / 외부 조인 (OUTER JOIN)
	- 두 테이블 간의 JOIN 시 일치하지 않는 행도 포함하여 조회하는 구문
		단, ORACLE에서는 반드시 LEFT / RIGHT 지정해야함(기준이 되는 테이블)
	
	- LEFT JOIN : 두 테이블 중 왼쪽에 작성된 테이블을 기준으로 조인
	- RIGHT JOIN : 두 테이블 중 오른쪽에 작성된 테이블을 기준으로 조인
	
	- FULL JOIN : 두 테이블이 가진 모든 행을 조회하는 조인(ORACLE 구문에는 없다)
*/
-- 모든 사원의 사원명, 부서명, 급여, 연봉 조회
-- LEFT JOIN
-- ORACLE
SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", SALARY AS "급여", SALARY * 12 AS "연봉"
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID(+);

-- ANSI
SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", SALARY AS "급여", SALARY * 12 AS "연봉"
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- RIGHT JOIN
SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", SALARY AS "급여", SALARY * 12 AS "연봉"
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE(+) = DEPT_ID;

SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", SALARY AS "급여", SALARY * 12 AS "연봉"
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- FULL JOIN
SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", SALARY AS "급여", SALARY * 12 AS "연봉"
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ==============================================================
/*
	비등가 조인(NON EQUAL JOIN)
	- 범위를 조건으로 줄 때
	- 매칭 시킬 컬럼에 대한 조건 작성 시 '='를 사용하지 않는 조인. 범위에 대한 조건
	
	ANSI 구문에서는 JOIN ON만 사용 가능
*/
-- 사원에 대한 사원명, 급여, 급여등급 조회
-- ORACLE 구문
SELECT EMP_NAME AS "사원명", SALARY AS "급여", SAL_LEVEL AS "급여등급"
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI
SELECT EMP_NAME AS "사원명", SALARY AS "급여", SAL_LEVEL AS "급여등급"
FROM EMPLOYEE JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;
-- ==============================================================
/*
	SELF JOIN
	- 서로 다른 테이블이 아닌 같은 테이블을 조인하는 구문
*/
-- 전체 사원의 사번, 사원명, 부서코드, 사수의 사번, 사수의 사원명, 사수의 부서코드 조회
SELECT E.EMP_ID AS "사번", E.EMP_NAME AS "사원명", E.DEPT_CODE AS "부서코드",
			M.EMP_ID AS "사수의 사번", M.EMP_NAME AS "사수의 사원명", M.DEPT_CODE AS "사수의 부서코드"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID; -- 어떤 사원의 사수사번과 사수의 사번을 조건으로 제시!

SELECT E.EMP_ID AS "사번", E.EMP_NAME AS "사원명", E.DEPT_CODE AS "부서코드",
			M.EMP_ID AS "사수의 사번", M.EMP_NAME AS "사수의 사원명", M.DEPT_CODE AS "사수의 부서코드"
FROM EMPLOYEE E JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- 사수가 없는 사원의 정보도 출력 할 경우 : LEFT JOIN
SELECT E.EMP_ID AS "사번", E.EMP_NAME AS "사원명", E.DEPT_CODE AS "부서코드",
			M.EMP_ID AS "사수의 사번", M.EMP_NAME AS "사수의 사원명", M.DEPT_CODE AS "사수의 부서코드"
FROM EMPLOYEE E LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
-- ==============================================================
/*
	다중조인
	- 2개 이상의 테이블을 조인하는 것
*/
-- 사번, 사원명, 부서명, 직급명 조회
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
	JOIN JOB J USING(JOB_CODE);
	
-- 사원의 사번, 사원명, 부서명, 지역명 조회
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
	JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- ==============================================================
-- [1] 사번, 사원명, 부서명, 지역명, 국가명 조회
-- ORACLE
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", LOCAL_NAME AS "지역명", NATIONAL_NAME AS "국가명"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- ANSI
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", LOCAL_NAME AS "지역명", NATIONAL_NAME AS "국가명"
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
	JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
	JOIN NATIONAL N USING (NATIONAL_CODE);

-- [2] 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
-- ORACLE
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", JOB_NAME AS "직급명", LOCAL_NAME AS "지역명", NATIONAL_NAME AS "국가명", SAL_LEVEL AS "급여등급"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID 
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID = L.LOCAL_CODE 
AND L.NATIONAL_CODE = N.NATIONAL_CODE 
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;

-- ANSI
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", JOB_NAME AS "직급명", LOCAL_NAME AS "지역명", NATIONAL_NAME AS "국가명", SAL_LEVEL AS "급여등급"
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
	JOIN JOB J USING (JOB_CODE)
	JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
	JOIN NATIONAL N USING (NATIONAL_CODE)
	JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);








