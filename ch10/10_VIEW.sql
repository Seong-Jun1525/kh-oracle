/*
	VIEW
	- SELECT 문을 통해 얻어진 결과물을 저장해둘 수 있는 객체
		☞ 자주 사용되는 쿼리문을 저장해두면 매번 다시 해당 쿼리문을 기술할 필요가 없음
	- 임시테이블과 같은 존재 (실제 데이터를 저장하는게 아니라, 논리적으로만 저장되어 있음)
*/

-- 한국에서 근무하는 사원 정보 사번, 이름, 부서명, 급여, 근무국가명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

-- 러시아에서 근무하는 사원 정보 사번, 이름, 부서명, 급여, 근무국가명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

-- 일본에서 근무하는 사원 정보 사번, 이름, 부서명, 급여, 근무국가명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';

/*
	VIEW 생성
	CREATE VIEW 뷰명 AS (서브쿼리);
*/

CREATE VIEW VW_EMPLOYEE AS (
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
		JOIN NATIONAL USING (NATIONAL_CODE)
);

-- 뷰를 생성할 수 있는 권한을 부여
GRANT CREATE VIEW TO C##KH;

SELECT * FROM VW_EMPLOYEE;

-- 뷰를 사용하여 '한국'에서 근무중인 사원정보 조회
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

-- 뷰를 사용하여 '러시아'에서 근무중인 사원정보 조회
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

-- 뷰를 사용하여 '일본'에서 근무중인 사원정보 조회
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '일본';

SELECT * FROM USER_VIEWS;
-- TEXT 컬럼에 저장된 서브쿼리 정보가 있음

------------------------------------------------------------------------------------------------------
-- 사번, 사원명, 직급명, 성별(남/여), 근무년수
SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') AS "성별",EXTRACT(YEAR FROM  SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
FROM EMPLOYEE
	JOIN JOB USING(JOB_CODE);
	
-- 쿼리문 VW_EMP_JOB 뷰에 저장
DROP VIEW VW_EMP_JOB;
CREATE VIEW VW_EMP_JOB (사번, 이름, 직급명, 성별, 근무년수)
AS (
	SELECT
		EMP_ID, 
		EMP_NAME, 
		JOB_NAME, 
		DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여'),
		EXTRACT(YEAR FROM  SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
	FROM EMPLOYEE
		JOIN JOB USING(JOB_CODE)
);

SELECT * FROM VW_EMP_JOB;

-- 여자 사원 조회
SELECT * FROM VW_EMP_JOB
WHERE 성별 = '여';

-- 20년 이상 근무한 사원 조회
SELECT * FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

------------------------------------------------------------------------------------------------------
/*
	생성된 뷰를 통해서 DML 사용
	
	뷰를 통해서 DML을 작성하게 되면, 실제 데이터가 저장되어 있는 테이블에 반영
*/
-- JOB 테이블을 뷰로 생성
CREATE VIEW VW_JOB AS (
	SELECT * FROM JOB
);
SELECT * FROM VW_JOB; -- 논리적인 테이블

INSERT INTO VW_JOB VALUES ('J8', '인턴');

UPDATE VW_JOB
	SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';	

DELETE FROM VW_JOB WHERE JOB_CODE = 'J8';

SELECT * FROM JOB;
------------------------------------------------------------------------------------------------------
/*
	DML 명령어로 조작이 불가능한 경우가 많다!
	
	1) 뷰에 정의되지 않은 컬럼을 조작하려는 경우
	2) 뷰에 정의되어 있지 않고 테이블에 NOT NULL 제약조건이 설정되어 있는 경우
		☞ 추가 수정할 때 문제가 발생할 수 있다!
	3) 산술연산식 또는 함수식으로 정의되어 있는 경우
	4) DISTINCT 구문이 포함되어 있는 경우
	5) JOIN을 이용하여 여러 테이블을 연결한 경우
	
	☞ 뷰는 대부분 조회의 용도로 사용한다. 따라서 되도록이면 DML을 사용하지 말자!
*/
------------------------------------------------------------------------------------------------------
/*
	VIEW 생성 옵션
	
	CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰명
	AS (서브쿼리)
	[WITH CHECK OPTION]
	[WITH READ ONLY]
	
	- OR REPLACE : 기존에 동일한 이름의 뷰가 있을 경우 갱신하고, 없을 경우 새로 생성함
	- FORCE | NOFORCE
		☞ FORCE : 서브쿼리에 작성한 테이블이 존재하지 않아도 뷰를 생성
		☞ NOFORCE : 서브쿼리에 작성한 테이블이 존재하는 경우에만 뷰를 생성(기본값)
		
	- WITH CHECK OPTION : DML 사용 시 서브쿼리에 작성한 조건에 맞는 값으로만 실행되도록 하는 옵션
	- WITH READ ONLY : 뷰를 조회만 가능하도록 하는 옵션 (추가해주는 것이 안전하다)
*/

-- FORCE | NOFORCE
--DROP VIEW VW_TEMP;
CREATE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT FROM TT;
/*
ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
00942. 00000 -  "table or view does not exist"
*/
CREATE FORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT FROM TT;
SELECT * FROM VW_TEMP; -- Can also be a table which has references to non-existent or inaccessible types. 뷰를 생성했지만 테이블이 존재하지 않는다는 오류 발생!
CREATE TABLE TT (
	TCODE NUMBER,
	TNAME VARCHAR2(20),
	TCONTENT VARCHAR2(200)
);
-- 되도록 테이블 생성 후 뷰를 만들자!!

DROP VIEW VW_EMP;
-- WITH CHECK OPTION
-- 옵션없이 급여가 300만원 이상인 사원 정보로 뷰 생성
CREATE VIEW VW_EMP AS (
	SELECT * FROM EMPLOYEE
	WHERE SALARY >= 3000000
);

SELECT * FROM VW_EMP;

-- 204번 사원의 급여를 200만원으로변경
UPDATE VW_EMP
	SET SALARY = 2000000
WHERE EMP_ID = 204;
ROLLBACK;

-- 옵션 포함해서 다시 생성
CREATE OR REPLACE VIEW VW_EMP AS (
	SELECT * FROM EMPLOYEE
	WHERE SALARY >= 3000000
)
WITH CHECK OPTION;


UPDATE VW_EMP
	SET SALARY = 2000000
WHERE EMP_ID = 204;
ROLLBACK;
/*
SQL 오류: ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
01402. 00000 -  "view WITH CHECK OPTION where-clause violation"
*/
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_EMP AS (
	SELECT * FROM EMPLOYEE
	WHERE SALARY >= 3000000
)
WITH READ ONLY;

DELETE FROM VW_EMP WHERE EMP_ID = 200;
/*
SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
42399.0000 - "cannot perform a DML operation on a read-only view"
*/




