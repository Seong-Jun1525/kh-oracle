/*
	함수(FUNCTION)
	- 전달된 컬럼 값을 읽어서 함수를 실행한 결과를 반환
	
	- 단일행 함수
		☞ 여러 개의 값을 읽어서 여러 개의 결과 값을 리턴 (행 마다 함수를 실행한 결과를 반환)
	- 그룹함수
		☞ 여러 개의 값을 읽어서 1개의 결과 값을 리턴(그룹을 지어 그룹 별로 함수를 실행한 결과를 반환)
		
	SELECT 절에 단일행 함수와 그룹함수는 결과 행의 갯수가 달라서 동시에 사용할 수 없다.
	
	함수식을 사용하는 위치 : FROM 절을 제외한 모든 절에서 사용 가능
*/

-- ==============================================================
/* 단일행 함수

	문자 타입의 데이터 처리 함수
	VARCHAR2(n), CHAR(n)
	
	LENGTH(컬럼명 또는 '문자열') : 해당 문자열의 글자 수를 반환
	LENGTHB(컬럼명 또는 '문자열') : 해당 문자열의 바이트 수 반환
	
	☞ 영문자, 숫자, 특수문자 : 글자당 1byte
		한글 : 글자당 3byte
*/

-- '오라클' 단어의 글자수와 바이트수를 확인
SELECT LENGTH('오라클') AS "글자수", LENGTHB('오라클') AS "바이트수"
FROM DUAL;

-- 'ORACLE' 단어의 글자수와 바이트수를 확인
SELECT LENGTH('ORACLE') AS "글자수", LENGTHB('ORACLE') AS "바이트수"
FROM DUAL;

-- 사원정보에서 사원명, 사원명의 글자수, 사원명의 바이트수, 이메일, 이메일의 글자수, 이메일의 바이트수 확인
SELECT EMP_NAME AS "사원명", LENGTH(EMP_NAME) AS "사원명의 글자수", LENGTHB(EMP_NAME) AS "사원명의 바이트 수",
			EMAIL AS "이메일", LENGTH(EMAIL) AS "이메일의 글자수", LENGTHB(EMAIL) AS "이메일의 바이트수"
FROM EMPLOYEE;

-- ==============================================================
/*
	INSTR
	- 문자열로부터 특정 문자의 시작위치를 반환
	
	[표현식]
		INSTR(컬럼 또는 '문자열', '찾고자하는 문자'[, 찾을 위치의 시작값, 순번])
		☞ 함수 실행 결과값은 NUMBER 타입
		
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 음수 값을 주면 뒤에서부터 찾고 결과값은 앞에서부터 순번으로 반환
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;

-- 사원 정보 중 이메일, 이메일의 '_'의 첫 번째 위치, 이메일의 '@'의 첫 번째 위치 조회
SELECT EMAIL, INSTR(EMAIL, '_') AS " '_'의 첫 번째 위치", INSTR(EMAIL, '@') AS " '@'의 첫 번째 위치"
FROM EMPLOYEE;

-- ==============================================================
/*
	SUBSTR : 문자열에서 특정 문자열을 추출해서 반환
	
	[표현법]
		SUBSTR('문자열' 또는 컬럼, 시작위치[, 길이(개수)])
		☞ 길이를 생략하면 시작위치부터 끝까지 추출!
	
*/

SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER', 12) FROM DUAL;

-- SQL만 추출
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL;

SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL; -- 뒤에서부터 3번째

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL;

-- 사원들 중 여사원들의 이름, 주민번호 조회
SELECT EMP_NAME AS "사원명", EMP_NO AS "주민번호"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4'); -- 숫자로 하면 문자로 자동으로 바꿔줌. 하지만 정확하게 하기위해서 문자타입으로 해주는것이 좋다

SELECT EMP_NAME AS "사원명", EMP_NO AS "주민번호"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('1', '3')
ORDER BY 사원명 ASC;

-- 함수는 중첩 사용 가능!!
-- 사원 정보 중 사원명, 이메일, 아이디 조회 (여기서 아이디는 이메일의 '@' 앞에까지)
SELECT EMP_NAME AS "사원명", EMAIL AS "이메일", SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS "아이디"
FROM EMPLOYEE;