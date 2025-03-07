/*
	DQL (DATA QUERY LANGUAGE) 				: SELECT
	DML (DATA MANIPULATION LANGUAGE) 		: INSERT, UPDATE, DELETE
	DDL (DATA DEFINITION LANGUAGE)			: CREATE, ALTER, DROP
	DCL (DATA CONTROL LANGUAGE)				: GRANT, REVOKE
	TCL (TRANSACTION CONTROL LANGUAGE)	: COMMIT, ROLLBACK
*/
--==========================================================================================================
/*
	DML 데이터 조작 언어
	- 테이블에 데이터를 추가하거나 (INSERT),
		수정하거나(UPDATE),
		삭제(DELETE)하기 위해 사용하는 언어
*/
-- INSERT : 테이블에 새로운 행을 추가하는 구문
/*
	[표현법]
		(1) INSERT INTO 테이블명 VALUES(값1, 값2, ...);
			☞ 테이블에 모든 컬럼에 대한 값을 직접 제시하여 한 행을 추가하고자 할 때 사용
			☞ 컬럼 순서에 맞게 VALUES에 값을 나열해야함(해당 컬럼에 맞는 데이터타입으로 제시해야함)
			* 값을 부족하게 제시했을 경우 ☞ NOT ENOUGH VALUE 오류 발생
			* 값을 더 많이 제시했을 경우 ☞ TOO MANY VALUES 오류 발생
*/
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE VALUES (900, '마이유', '990307-2000000', 'my_u220@kh.or.kr', '01012344567', 'D4', 'J4', 3000000, 0.3,  NULL, SYSDATE, NULL, 'N');
/*
	(2) INSERT INTO 테이블명 (컬럼명1, 컬럼명2, 컬럼명3) VALUES (값1, 값2, 값3);
	
	제시되지 않은 컬럼에 대한 값은 기본적으로 NULL값이 저장되고 NULL값이 아닌 다른 값으로 저장하고자 할 때는 기본값 옵션을 설정하면 된다.
	
	제시되지 않은 컬럼에 NOT NULL 제약조건이 있다면, 반드시 값을 직접 제시하애야 함 또는 기본값 옵션을 추가해야함
*/
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
					VALUES (901, '오라클', '880707-1000000', 'oracle00@or.kr', 'J7');
SELECT * FROM EMPLOYEE;

/*
	(3) INSERT INTO 테이블명 (서브쿼리);
	☞ VALUES 값을 직접 명시하는데신
		서브쿼리로 조화된 결과값을 통채로 INSERT 하는 방법( 여러 행 추가하는 방식	
*/
CREATE TABLE EMP01 (
	EMP_ID NUMBER,
	EMP_NAME VARCHAR2(20),
	DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP01;

-- 전체 사원의 사번, 사원명, 부서명 조회
-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
	
-- ORACLE	
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

INSERT INTO EMP01 (
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE
	FROM EMPLOYEE, DEPARTMENT
	WHERE DEPT_CODE = DEPT_ID(+)
);

/*
	(4) INSERT ALL
	- 두 개 이상의 테이블에 각각 데이터를 추가할 때 사용되는 서브쿼리가 동일한 경우 사용하는 방법
	
	INSERT ALL 
		INTO 테이블명1 VALUES (컬럼명, 컬럼명, ...)
		INTO 테이블명2 VALUES (컬럼명, 컬럼명, ...)
		서브쿼리;
*/
-- EMP_DEPT 테이블 : 사번, 사원명, 부서코드 입사일
CREATE TABLE EMP_DEPT AS (
	SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
	FROM EMPLOYEE
	WHERE 1 = 0  -- 아무의미없는 조건을 줘서 FALSE가 나오도록 함 ☞ 데이터 없이 컬럼정보만 복제하기 위해 사용!!!
);

SELECT * FROM EMP_DEPT;

CREATE TABLE EMP_MANAGE AS (
	SELECT EMP_ID, EMP_NAME, MANAGER_ID
	FROM EMPLOYEE
	WHERE 1 = 0
);

SELECT * FROM EMP_MANAGE;

-- 부서코드가 'D1'인 사원의 사번, 사원명, 부서코드, 사수사번, 입사일 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

INSERT ALL
	INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
	INTO EMP_MANAGE VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
(
	SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
	FROM EMPLOYEE
	WHERE DEPT_CODE = 'D1'
);
--==========================================================================================================
/*
	UPDATE : 테이블에 저장되어 있는 기존의 데이터 값을 변경하는 구문
	
	☞ UPDATE 혹은 DELETE를 하기 전에는 항상 SELECT로 데이터를 확인하자!!
	
	[표현법]
		UPDATE 테이블명 
			SET 컬럼명 = 변경할 값,
				컬럼명 = 변경할 값,
				...
		[WHERE 조건식];
		
		☞ SET 절에는 여러 개의 컬럼 값을 동시에 변경할 수 있고 콤마로 구분하여 나열한다
		☞ WHERE 절을 생략했을 경우 테이블의 해당 컬럼의 모든 데이터가 변경된다 !!!
	
	데이터를 수정할 때 제약조건을 잘 확인해야 함!!!	
		
*/
-- DEPT_TABLE이라는 테이블에 DEPARTMENT 테이블을 복제(데이터포함)
CREATE TABLE DEPT_TABLE AS (
	SELECT * FROM DEPARTMENT
);
SELECT * FROM DEPT_TABLE;

-- 부서코드가 'D1'인 부서의 부서명을 '인사팀'으로 변경
UPDATE DEPT_TABLE
	SET DEPT_TITLE = '인사팀'
WHERE DEPT_ID = 'D1';

SELECT * FROM DEPT_TABLE;

-- 부서코드가 'D9'인 부서의 부서명을 '전략기획팀'으로 변경
UPDATE DEPT_TABLE
	SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_TABLE;

-- 사원테이블을 EMP_TABLE로 사번, 이름, 부서코드, 급여, 보너스 정보만 복제 데이터 포함!!
CREATE TABLE EMP_TABLE AS (
	SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
	FROM EMPLOYEE
);

SELECT * FROM EMP_TABLE;

-- 사번이 900인 사원의 급여를 400만원으로 인상(변경)
UPDATE EMP_TABLE
	SET SALARY = 4000000
WHERE EMP_ID = 900;

SELECT * FROM EMP_TABLE WHERE EMP_ID = 900;

-- 대북혼 사원의 급여를 500만원, 보너스를 0.2로 변경
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '대북혼';

UPDATE EMP_TABLE
	SET SALARY = 5000000,
		BONUS = 0.2
WHERE EMP_NAME = '대북혼';	
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '대북혼';

-- 전체 사원의 급여를 기존 급여에 10% 인상
UPDATE EMP_TABLE
	SET SALARY = SALARY * 1.1;
	
SELECT * FROM EMP_TABLE;
--==========================================================================================================
/*
	UPDATE문에 서브쿼리 적용
	
	[표현법]
		UPDATE 테이블명
			SET 컬럼명 = (서브쿼리)
		[WHERE 조건식];	
*/
-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스 값과 동일하게 변경
SELECT * FROM EMP_TABLE WHERE EMP_NAME IN ('방명수', '유재식');

UPDATE EMP_TABLE
	SET (SALARY, BONUS) = (
		SELECT SALARY, BONUS
		FROM EMP_TABLE
		WHERE EMP_NAME = '유재식'
	)
WHERE EMP_NAME = '윤은해';

SELECT * FROM EMP_TABLE WHERE EMP_NAME IN ('방명수', '윤은해', '유재식');

-- ASIA 지역에서 근무 중인 사원들의 보너스를 0.3으로 변경

-- [1] ASIA 지역의 지역 정보
SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE 'ASIA%';

-- [2] ASIA 지역의 부서 정보
SELECT *
FROM DEPARTMENT
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

-- [3] ASIA 지역의 부서에 속한 사원 정보 조회 (사번)
SELECT EMP_ID
FROM EMP_TABLE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';

-- 다중행 서브쿼리

UPDATE EMP_TABLE
	SET BONUS = 0.3
WHERE EMP_ID IN (
	SELECT EMP_ID
	FROM EMP_TABLE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	WHERE LOCAL_NAME LIKE 'ASIA%'
);

SELECT * FROM EMP_TABLE;

COMMIT;
--==========================================================================================================
/*
	DELETE : 테이블에 저장되어 있는 데이터를 삭제할 때 사용하는 구문
	
	[표현법]
		DELETE FROM 테이블명
		[WHERE 조건식];	
*/

DELETE FROM EMPLOYEE; -- 실제 DB에 반영되는 것은 아님 즉 ROLLBACK을 하여 되돌릴 수 있음 하지만 다른 작업을 하고 커밋을 하면 마지막 커밋 시점으로 돌아감..
ROLLBACK;

DELETE FROM EMPLOYEE WHERE EMP_ID = 901;
DELETE FROM EMPLOYEE WHERE EMP_NAME = '마이유';

SELECT * FROM EMPLOYEE;
COMMIT;

-- 외래키가 설정되어 있는 경우 사용중인 데이터가 있을 때 삭제 불가!

/*
	TRUNCATE :
	- 테이블의 전체 데이터를 삭제할 때 사용되는 구문
	- DELETE보다 수행속도가 빠르다
	- 별도의 조건을 제시할 수 없고 ROLLBACK이 불가하다 (되돌릴 수 없음)
	
	TRUNCATE TABLE 테이블명
*/