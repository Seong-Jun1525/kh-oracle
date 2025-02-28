/*
	SELECT : 데이터 조회
	☞ DQL로 분류된다. DML과 함께 묶는 경우가 많지만 정확한 분류는 DQL로 분류해야한다.
	
	[표현식]
	SELECT 조회하고자 하는 정보 FROM 테이블명;
	
	☞ 제일 먼저 FROM절을 확인하고 이후 컬럼들을 조회한다.

	RESULT SET : 데이터를 조회한 결과
*/

-- 모든 사원의 데이터 조회
SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름, 주민번호, 핸드폰 데이터 조회
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;
-- ☞ EMPLOYEE 테이블 조회 → EMP_NAME, EMP_NO, PHONE 컬럼에 대한 데이터만 추출

-- 모든 직급에 대한 정보
SELECT * FROM JOB;

-- 직급명만 조회
SELECT JOB_NAME FROM JOB; 

-- 사원테이블에서 모든 사원의 이름, 이메일, 연락처, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE,  SALARY
FROM EMPLOYEE;

/*
	컬럼명에 산술 연산 추가하기
	☞ SELECT 절에 컬럼명 작성부분에 산술 연산을 할 수 있음
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
-- DATE타입 - DATE타입 ☞ 일 단위로 표시됨

/*
	리터럴 (값 자체) : 임의로 지정한 값을 문자열('' <- 문자나 날짜를 표현할 때 사용)로 표현 또는 숫자로 표현
	☞ SELECT 절에 사용하는 경우 조회된 결과(RESULT SET)에 반복적으로 표시됨
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

SELECT DISTINCT JOB_CODE, DEPT_CODE -- JOB_CODE, DEPT_CODE를 한 쌍으로 묶어서 중복 제거 ☞ 같은 직급에 같은 직책일 경우에 해당
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
		☞ 해당 컬럼의 값이 최솟값 이상이고 최댓값 이하인 경우
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

-- ==============================================================

/*
	LIKE : 비교하고자 하는 컬럼의 값이 제시한 특징 패턴에 만족할 경우 조회
	
	☞ 특정 패턴 : '%', '_'를 와일드카드로 사용
		[표현식] 비교대상컬럼 LIKE '패턴'
		☞ % : 0글자 이상
			EX) 비교대상컬럼 LIKE '문자%' → 비교대상컬럼의 값이 문자로 "시작"되는 것을 조회
			EX) 비교대상컬럼 LIKE '%문자' → 비교대상컬럼의 값이 문자로 "끝"나는 것을 조회
			EX) 비교대상컬럼 LIKE '%문자%' → 비교대상컬럼의 값에 문자가 "포함"되는 것을 조회 → 키워드 검색!
			
		☞ _ : 1글자
			EX) 비교대상컬럼 LIKE '_문자' → 비교대상컬럼의 값에서 문자 앞에 무조건 한 글자가 오는 경우를 조회 
			EX) 비교대상컬럼 LIKE '__문자' → 비교대상컬럼의 값에서 문자 앞에 무조건 두 글자가 오는 경우를 조회
			EX) 비교대상컬럼 LIKE '_문자_' → 비교대상컬럼의 값에서 문자 앞, 뒤로 무조건 한 글자씩 오는 경우를 조회
		
*/

-- 사원들 중에 "전"씨 성을 가진 사원의 사원명, 급여, 입사일 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 사원명에 "하"가 포함된 사원의 사원명, 주민번호, 연락처 조회
SELECT EMP_NAME AS "사원명", EMP_NO AS "주민번호", PHONE AS "연락처"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 사원명에서 가운데 글자가 "하"인 사원의 사원명, 연락처 조회( 사원명이 3글자인 사원들 중 조회)
SELECT EMP_NAME AS "사원명", PHONE AS "연락처"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 사원들 중 연락처의 3번째 자리가 1인 사원의 사번, 사원명, 연락처, 이메일 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", PHONE AS "연락처", EMAIL AS "이메일"
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- 사원들 중 이메일에 4번째 자리가 _인 사원의 사번, 이름, 이메일 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "이름", EMAIL AS "이메일"
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- ☞ 와일드 카드로 사용되는 문자와 컬럼에 담긴 문자가 동일하기 때문에 모두 와일드카드로 인식됨
-- ☞ 나만의 와일드 카드를 사용해야함 ESCAPE 옵션 추가!

SELECT EMP_ID AS "사번", EMP_NAME AS "이름", EMAIL AS "이메일"
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
-- ☞ 나만의 와일드 카드는 기존 와일드카드를 문자로 인식되게 하는 것 임

-- ==============================================================
/*
	IS NULL / IS NOT NULL
	- 컬럼 값에 NULL이 있는 경우 NULL값을 비교할 때 사용되는 연산자
	
	- IS NULL : 컬럼값이 NULL 인지
	- IS NOT NULL : 컬럼값이 NULL이 아닌지
	
*/

-- 보너스를 받지 않는 사원들의 사번, 사원명, 급여, 보너스 조회 → 보너스를 받지 않는 사원을 찾는 것!
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", SALARY AS "급여", BONUS AS "보너스"
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 보너스를 받는 사원들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", SALARY AS "급여", BONUS AS "보너스"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; -- 이렇게도 가능하다

-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME AS "사원명", MANAGER_ID AS "사수사번", DEPT_CODE AS "부서코드"
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서 배치를 받지 않았지만, 보너스를 받고 있는 사원의 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME AS "사원명", BONUS AS "보너스", DEPT_CODE AS "부서코드"
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
-- ==============================================================
-- 직급 코드가 'J7' 이거나 'J2'인 사원들 중 급여가 200만원 이상인 사원의 모든 정보를 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN('J7', 'J2') AND SALARY >= 2000000;

/*
	연산자 우선순위
		(0) () 소괄호
		(1) 산술연산자 : * / + -
		(2) 연결연산자 : ||
		(3) 비교연산자 : > < <= >= = != <> ^=
		(4) IS NULL / LIKE '패턴' / IN
		(5) BETWEEN - AND -
		(5) NOT
		(6) AND
		(7) OR
*/
-- ==============================================================
/*
	정렬 : ORDER BY
	☞ SELECT 문에서 가장 마지막 줄에 작성
	☞ 실행 순서 또한 가장 마지막에 실행
	
	[표현식]
	SELECT 조회할 컬럼, ...
	FROM 테이블명
	WHERE 조건
	ORDER BY 정렬기준이되는컬럼 | 별칭 | 컬럼순번 [ASC | DESC] [NULLS FIRST | NULLS LAST]
	(☞ 가장 마지막에 실행되기 때문에 별칭을 사용할 수 있고 컬럼순번도 사용할 수 있다)
	
	ASC : 오름차순 - 기본값
	DESC : 내림차순
	
	NULLS FIRST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 맨 앞에 배치 (DESC인 경우에 기본값)
	NULLS LAST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 맨 뒤에 배치(ASC인 경우에 기본값)
	
*/

-- 모든 사원의 사원명, 연봉 조회 (연봉별 내림차순 정렬)
SELECT EMP_NAME AS "사원명", (SALARY * 12) AS "연봉"
FROM EMPLOYEE
-- ORDER BY SALARY * 12 DESC;
ORDER BY 연봉 DESC;
-- ORDER BY 2 DESC;

-- ORACLE은 순서가 1부터 시작!

-- 보너스 기준으로 정렬
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS; -- 기본값 ASC ☞ ASC일 경우 NULLS LAST가 기본값
ORDER BY BONUS DESC, SALARY; -- ☞ BONUS로 먼저 정렬하는데 같은 값일 경우 SALARY 기준으로 오름차순 정렬한다


















