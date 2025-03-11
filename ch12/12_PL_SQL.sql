/*
	PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL
	
	오라클 자체에 내장되어 있는 절차적 언어
	SQL 문장 내에서 변수 정의, 조건문, 반복문 등을 지원 ☞ SQL 단점 보완
	
	다수의 SQL문을 한번에 실행 가능
	
	* 구조 *
	[선언부]		: DECLARE로 시작. 변수나 상수를 초기화하는 부분
	실행부		: BEGIN으로 시작. SQL문 또는 제어문(조건문, 반복문) 로직을 작성하는 부분
	[예외처리부]	: EXCEPTION으로 시작. 예외 발생 시 해결하기 위한 부분
*/

-- * 화면에 표시하기 위한 설정
SET SERVEROUTPUT ON;

-- "HELLO ORACLE" 출력

BEGIN
	DBMS_OUTPUT.PUT_LINE('HELLO ORACLE'); -- "" X
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	선언부(DECLARE)
	- 변수 또는 상수를 선언 및 초기화 하는 부분
	
	데이터타입 선언 종류
	- 일반타입
	- 래퍼런스 타입
	- ROW 타입
*/
/*
	일반 타입 변수
	
	변수명 [CONSTANT] 자료형 [:= 값]
	
	-- 상수 선언 시 CONSTANT를 추가
	-- 초기화 시 := 기호를 사용
*/

-- EID 라는 이름의 NUMBER 타입 변수
-- ENAME 라는 이름의 VARCHAR2(20) 타입 변수
-- PI 라는 이름의 NUBMER 타입 상수 선언 및 3.14 라는 값으로 초기화
DECLARE
	EID NUMBER;
	ENAME VARCHAR2(20);
	PI CONSTANT NUMBER := 3.14;

BEGIN
	-- 변수에 값을 대입
	EID := 100;
	ENAME := '임성준';
	
	-- || : 연결 연산자
	DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
-- 값을 입력 받아 변수에 대입
DECLARE
	EID NUMBER;
	ENAME VARCHAR2(20);
	PI CONSTANT NUMBER := 3.14;

BEGIN	
	ENAME := '임성준';
	EID := &사원번호; -- 사용자로부터 입력받기 ☞ &대체변수명
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
/*
	래퍼런스 타입 변수
	- 어떤 테이블의 어떤 컬럼의 데이터타입을 참조하여 해당 타입으로 변수를 선언
	
	[표현법]
	변수명 테이블명.컬럼명%TYPE
*/

-- EID 라는 변수는 EMPLOYEE 테이블의 EMP_ID 컬럼의 타입을 참조
-- ENAME 라는 변수는 EMPLOYEE 테이블의 EMP_NAME 컬럼의 타입을 참조
-- SAL 라는 변수는 EMPLOYEE 테이블의 SALARY 컬럼의 타입을 참조
DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	SAL EMPLOYEE.SALARY%TYPE;
BEGIN
	-- EMPLOYEE 테이블에서 입력받은 사번에 대한 서원 정보를 조회
	
	SELECT EMP_ID, EMP_NAME, SALARY
	INTO EID, ENAME, SAL -- 각 컬럼에 대한 값을 변수에 대입
	FROM EMPLOYEE
	WHERE EMP_ID = &사원번호;
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	래퍼런스 타입 변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고

	각 자료형을 EMPLOYEE 테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼과
	DEPARTMENT 테이블의 DEPT_TITLE 컬럼을 참조하도록 한 뒤
	사용자가 입력한 사번의 사원 정보를 조회하여 변수에 담아 출력
	
	출력 형식
	사번, 이름, 직급코드, 급여, 부서명
*/

-- SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
-- FROM EMPLOYEE
--	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	SAL EMPLOYEE.SALARY%TYPE;
	JCODE EMPLOYEE.JOB_CODE%TYPE;
	DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
	INTO EID, ENAME, JCODE, SAL, DTITLE
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	WHERE EMP_ID = &사원번호;	
	
	DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	ROW 타입 변수
		- 테이블의 한 행에 대한 모든 컬럼 값을 한번에 담을 수 있는 변수
		
	[표현법]
		변수명 테이블명%ROWTYPE;
*/
-- E 라는 변수에 EMPLOYEE 테이블의 ROW 타입 변수 선언
DECLARE
	E EMPLOYEE%ROWTYPE;
BEGIN
	SELECT * 
	INTO E
	FROM EMPLOYEE
	WHERE EMP_ID = &사번;
	DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
	DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
--	DBMS_OUTPUT.PUT_LINE('보너스 : ' || NVL(E.BONUS, '보너스 없음')); -- ORA-06502: PL/SQL: 수치 또는 값 오류: 문자를 숫자로 변환하는데 오류입니다
	DBMS_OUTPUT.PUT_LINE('보너스 : ' || TO_CHAR(NVL(E.BONUS, 0), '0.0'));
	DBMS_OUTPUT.PUT_LINE('보너스 : ' || '없음');
	
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	실행부(BEGIN)
	
	조건문
		- 단일 IF문		 : IF 조건식 THEN 실행내용 END IF;
		- IF/ELSE문		 : IF 조건식 THEN 실행내용 
							ELSE 실행내용;
							END IF;
							
		- IF/ELSIF/ELSE문  :IF 조건식 THEN 실행내용
							ELSIF 조건식 THEN 실행내용
							ELSE 실행내용;
							END IF; 
							
		- CASE / WHEN / THEN
			CASE 비교대상 
				WHEN 비교값1 THEN 결과값1
				WHEN 비교값2 THEN 결과값2
				...
				ELSE 결과값N
			END;	
			
*/
/*
	사용자에게 사번을 입력받아 해당 사원의 사번, 이름, 급여, 보너스 정보를 조회하여 출력
	각 데이터에 대한 변수 : 사번(EID), 이름(ENAME), 급여(SAL), 보너스(BONUS)
	단, 보너스 값이 0(NULL)인 사원의 경우 "보너스를 받지 않는 사원입니다." 출력
*/
DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	SAL EMPLOYEE.SALARY%TYPE;
	BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
	INTO EID, ENAME, SAL, BONUS
	FROM EMPLOYEE
	WHERE EMP_ID = &사원번호;
	
	IF BONUS = 0 THEN DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사원입니다.');
	ELSE DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
	END IF;
END;
/

/*
	사용자로부터 사번을 입력받아 사원 정보를 조회하여 화면에 표시 (사번, 이름, 부서명, 국가명)
	국가정보 : 'KO'인 경우 '국내팀' 표시, 그렇지 않은 경우는 '해외팀'
*/

--SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
--	FROM EMPLOYEE
--		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
--		JOIN NATIONAL USING (NATIONAL_CODE);

DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
	NCODE LOCATION.NATIONAL_CODE%TYPE;
	
	TEAM VARCHAR2(10);
BEGIN
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
	INTO EID, ENAME, DTITLE, NCODE
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	WHERE EMP_ID = '&사원번호';
	
	IF NCODE = 'KO' 
		THEN TEAM := '국내팀';
	ELSE TEAM := '해외팀';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
	DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('부서 : ' || DTITLE);
	DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/






