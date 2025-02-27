/*
	SELECT : 데이터 조회
	
	[표현식]
	SELECT 조회하고자 하는 정보 FROM 테이블명;

	RESULT SET : 데이터를 조회한 결과
*/

-- 모든 사원의 데이터 조회
SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름, 주민번호, 핸드폰 데이터 조회
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;
-- => EMPLOYEE 테이블 조회 -> EMP_NAME, EMP_NO, PHONE 컬럼에 대한 데이터만 추출

-- 제일 먼저 FROM절을 확인하고 이후 컬럼들을 조회한다.

-- 모든 직급에 대한 정보
SELECT * FROM JOB;

-- 직급명만 조회
SELECT JOB_NAME FROM JOB; 

-- 사원테이블에서 모든 사원의 이름, 이메일, 연락처, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE,  SALARY
FROM EMPLOYEE;

/*
	컬럼명에 산술 연산 추가하기
	=> SELECT 절에 컬럼명 작성부분에 산술 연산을 할 수 있음
*/

-- 사원명, 연봉 정보 조회
SELECT EMP_NAME AS 사원명, (SALARY * 12) AS 연봉
FROM EMPLOYEE;

-- 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉을 조회
SELECT EMP_NAME AS 사원명, SALARY AS 급여, (SALARY * 12) AS 연봉, BONUS AS 보너스, ((SALARY + (SALARY * BONUS)) * 12) AS "보너스 포함 연봉"
FROM EMPLOYEE;

/*
	컬럼에 별칭 부여하기
	- 연산식을 사용한 경우 의미를 파악하기 어렵기 때문에 별칭을 부여하여 명확하고 깔끔하게 조회할 수 있다.
	
	[표현식]
		(1) 컬럼명 별칭
		(2) 컬럼명 AS 별칭
		(3) 컬럼명 "별칭"
		(4) 컬럼명 AS "별칭"
*/
SELECT EMP_NAME AS 사원명, SALARY AS 급여, BONUS AS 보너스, (SALARY * 12) AS 연봉, ((SALARY + (SALARY * BONUS)) * 12) AS "보너스 포함 연봉"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

/*
	- 현재 날짜 시간 정보 : SYSDATE
	- 가상테이블(임시테이블) : DUAL
*/

SELECT SYSDATE FROM DUAL; -- YY/MM/DD 형식으로 조회됨

-- 모든 사원의 사원명, 입사일, 근무일수 조회
-- 근무일수 = 현재날짜 - 입사일 + 1
SELECT EMP_NAME AS "사원명", HIRE_DATE AS "입사일", (SYSDATE - HIRE_DATE + 1) AS "근무일수"
FROM EMPLOYEE;
-- DATE타입 - DATE타입 => 일 단위로 표시됨

/*
	리터럴 (값 자체) : 임의로 지정한 값을 문자열('' <- 문자나 날짜를 표현할 때 사용)로 표현 또는 숫자로 표현
	=> SELECT 절에 사용하는 경우 조회된 결과(RESULT SET)에 반복적으로 표시됨
*/
-- 사원명, 급여, '원' 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", '원' AS "원"
FROM EMPLOYEE;

/*
	연결 연산자 : ||
	두 개의 컬럼 또는 값과 컬럼을 연결해주는 연산자
*/
-- XXX원 형식으로 급여 정보를 조회
SELECT SALARY || '원' AS "급여"
FROM EMPLOYEE;

-- 사번, 이름, 급여를 한 번에 조회
SELECT (EMP_ID || '  ' || EMP_NAME || '  ' || SALARY) AS "사원 정보"
FROM EMPLOYEE;

-- "XXX의 급여는 XXXX원 입니다." 형식으로 조회
SELECT (EMP_NAME || '의 급여는 ' || SALARY || '원 입니다.') AS "급여정보"
FROM EMPLOYEE;

/*
	중복 제거 : DISTINCT
	중복된 결과값이 있을 경우 조회 결과를 하나로 표시해줌
	
	SELECT 절에서 DISTINCT는 한번만 가능하다
*/
-- 사원테이블에서 중복없이 직책코드 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- 사원테이블에서 부서코드 중복없이 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT DISTINCT JOB_CODE, DEPT_CODE -- JOB_CODE, DEPT_CODE를 한 쌍으로 묶어서 중복 제거 => 같은 직급에 같은 직책일 경우에 해당
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

-- ==============================================================
/*
	WHERE 절
	- 조회하고자 하는 데이터를 특정 조건에 따라 추출하고자 할 때 사용
	
	[표현식]
		SELECT 컬럼명, 컬럼 또는 데이터 기준 연산식
		FROM 테이블 명
		[WHERE 조건]
		
	- 비교연산자
		대소비교 : > < >= <=
		동등비교
			- 같은 지 비교 : =
			- 다른 지 비교 : != <> ^=
*/
-- 사원테이블에서 부서코드가 'D9'인 사원들의 정보를 조회
SELECT * 							-- (3)
FROM EMPLOYEE					-- (1)
WHERE DEPT_CODE = 'D9';			-- (2)

-- 사원 정보 중 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드를 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", DEPT_CODE AS "부서코드"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 사원 정보 중 부서코드가 'D1'이 아닌 사원들의 사원명, 급여, 부서코드를 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", DEPT_CODE AS "부서코드"
FROM EMPLOYEE
WHERE DEPT_CODE<> 'D1';
-- WHERE DEPT_CODE ^= 'D1';
-- WHERE DEPT_CODE != 'D1';

-- 급여가 4000000 이상인 사원들의 사원명, 부서코드, 급여정보를 조회
SELECT EMP_NAME AS "사원명", DEPT_CODE AS "부서코드", SALARY AS "급여정보"
FROM EMPLOYEE
WHERE SALARY >= 4000000;


-- 급여가 4000000 미만인 사원들의 사원명, 부서코드, 급여정보를 조회
SELECT EMP_NAME AS "사원명", DEPT_CODE AS "부서코드", SALARY AS "급여정보"
FROM EMPLOYEE
WHERE SALARY < 4000000 AND DEPT_CODE IS NOT NULL;

-- ==============================================================
-- 연봉 계산 시 보너스 제외
-- 모두 별칭 적용

-- [1] 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", HIRE_DATE AS "입사일", (SALARY * 12) AS "연봉"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- [2] 연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", (SALARY * 12) AS "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY * 12) >= 50000000;

-- [3] 직급코드가 'J5'가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID AS "사원번호", EMP_NAME AS "사원명", JOB_CODE AS "직급코드", ENT_YN AS "퇴사여부"
FROM EMPLOYEE
WHERE JOB_CODE <> 'J5';

-- [4] 급여가 350만원 이상 600만원 이하인 모든 사원의 사원명, 사번, 급여 조회
--	논리 연산자 : AND, OR로 조건 연결할 수 있음
SELECT EMP_NAME AS "사원명", EMP_ID AS "사원번호", SALARY AS "급여"
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000;

/*
	[표현식]
		BETWEEN A AND B
		- 컬럼명 : 비교 대상 컬럼
		- A : 최솟값
		- B : 최댓값
		==> 해당 컬럼의 값이 최솟값 이상이고 최댓값 이하인 경우
*/

SELECT EMP_NAME AS "사원명", EMP_ID AS "사원번호", SALARY AS "급여"
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

-- NOT 연산자
SELECT EMP_NAME AS "사원명", EMP_ID AS "사원번호", SALARY AS "급여"
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

/*
	IN : 비교 대상 컬럼의 값이 제시한 값들 중에 일치하는 값이 있는 경우를 조회하는 구문
	
	[표현식]
		컬럼명 IN (값1, 값2, ...)
		아래와 동일함
		컬럼명 = 값1 OR 컬럼명 = 값2 OR ...
*/

-- 부서코드가 'D6'이거나 'D8'이거나 'D5'인 사원들의 사원명, 부서코드, 급여를 조회
SELECT EMP_NAME AS "사원명", DEPT_CODE AS "부서코드", SALARY AS "급여"
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN('D6',  'D8', 'D5');


/*
SELECT DISTINCT 
	JOB_CODE
FROM EMPLOYEE;

-- WHERE절. 동등비교 연산자는 = 이다.
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 여러 개의 조건 작성 시 AND / OR 사용
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 200000;
*/