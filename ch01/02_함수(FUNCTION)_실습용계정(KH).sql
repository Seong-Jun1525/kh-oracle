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
-- ==============================================================
/*
	LPAD / RPAD : 문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
		
	[표현법]
		LPAD(문자열 또는 컬럼, 총 길이[, '덧붙일문자']) ☞ 왼쪽에 덧붙일 문자를 사용하여 채움
		RPAD(문자열 또는 컬럼, 총 길이[, '덧붙일문자']) ☞ 오른쪽에 덧붙일 문자를 사용하여 채움
		☞ 덧붙일 문자를 생략할 경우 공백으로 채워짐
*/

-- 사원 정보 중 사원명을 왼쪽에 공백을 채워서 20길이로 조회
SELECT EMP_NAME AS "사원명", LPAD(EMP_NAME, 20)
FROM EMPLOYEE;

-- 사원 정보 중 사원명을 오른쪽에 공백을 채워서 20길이로 조회
SELECT EMP_NAME AS "사원명", RPAD(EMP_NAME, 20)  AS "사원명"
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 이메일 조회(이메일 오른쪽 정렬, 총길이 20)
SELECT EMP_NAME AS "사원명", LPAD(EMAIL, 20) AS "EMAIL"
FROM EMPLOYEE;

-- 왼쪽정렬 '#'
SELECT EMP_NAME, LPAD(EMAIL, 20, '#')  AS "EMAIL"
FROM EMPLOYEE;

SELECT '000201-1', RPAD('000201-1', 14, '*') FROM DUAL;

-- 사원 정보 중 사원명, 주민번호 조회
-- 단, 주민번호는 'XXXXXX-X******'
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

-- ==============================================================
/*
	LTRIM / RTRIM : 문자열에서 특정 문자를 제거한 후 나머지를 반환
	
	[표현법]
		LTRIM(문자열 또는 컬럼[, '제거할문자들'])
		RTRIM(문자열 또는 컬럼[, '제거할문자들'])
		☞ 제거할 문자를 제시하지 않을 경우 공백을 제거해줌
*/

SELECT LTRIM('     H I') FROM DUAL; -- 왼쪽부터 다른문자가 나올때까지 공백 제거
SELECT RTRIM('H     I	  ') FROM DUAL; --  오른쪽부터 다른 문자가 나올때까지 공백 제거

SELECT LTRIM('123123H123', '123') FROM DUAL; -- '123'이라고 해서 꼭 123이 지워지는게 아니라 '1', '2', '3' 이렇게 각각을 비교 후 제거함
SELECT RTRIM('123123H123', '123') FROM DUAL;

SELECT LTRIM('KKHHII', '123') FROM DUAL
/*
	TRIM : 문자열 앞 / 뒤 / 양쪽에 있는 지정한 문자들을 제거한 후 나머지 값을 반환
	
	[표현법]
		TRIM([LEADING | TRAILING | BOTH] [제거할문자 FROM] 문자열 또는 컬럼)
		첫 번째 옵션 생략 시 기본값은 BOTH
		제거할 문자 생략 시 공백을 제거
*/;

SELECT TRIM('    H     I       ') FROM DUAL; -- TAB은 공백으로 인식되지 않음!

-- 'LLLLLHLLLLL'
SELECT TRIM('L' FROM 'LLLLLHLLLLL') FROM DUAL;
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLLLLL') FROM DUAL;
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLLLLL') FROM DUAL;

-- ==============================================================
/*
	LOWER / UPPER / INITCAP
	
	LOWER : 문자열을 모두 소문자로 변경하여 결과 반환
	UPPER : 문자열을 모두 대문자로 변경하여 결과 반환
	INITCAP : 띄어쓰기를 기준으로 첫 글자마다 대문자로 변경하여 결과반환
*/
-- 'Oh My God'
SELECT LOWER('Oh My God') FROM DUAL;
SELECT UPPER('Oh My God') FROM DUAL;
SELECT INITCAP('Oh My God') FROM DUAL;

/*
	CONCAT : 문자열 두 개를 하나의 문자열로 합친 후 반환
	
	[표현식]
		CONCAT(문자열1, 문자열2)
*/
SELECT 'KH' || ' A강의장' FROM DUAL;
SELECT CONCAT('KH', ' A강의장') FROM DUAL;

SELECT CONCAT(EMP_NAME, '님') AS "사원명" FROM EMPLOYEE;

SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '님')) AS "사원명" FROM EMPLOYEE;

/*
	REPLACE : 문자열에서 특정 부분을 제시한 문자열로 대체하여 반환
	
	[표현법]
		REPLACE(문자열, 찾을문자열, 변경할문자열)
*/

SELECT REPLACE('서울시 강남구', '강남', '종로') AS "지역" FROM DUAL;

-- 사원 정보 중 이메일 데이터의 '@kh.or.kr' 부분을 '@gmail.com'으로 변경하여 조회
SELECT EMAIL, REPLACE(EMAIL,  '@kh.or.kr',  '@gmail.com') AS "이메일" FROM EMPLOYEE;
-- ==============================================================
/*
	NUMBER 타입
	ABS : 숫자의 절대값을 구해주는 함수
*/
SELECT ABS(-100) FROM DUAL;
SELECT ABS(-12.34) FROM DUAL;
-- ==============================================================
/*
	MOD: 두 수의 나머지 값을 구해주는 함수
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
-- ==============================================================
/*
	ROUND : 반올림한 값을 구해주는 함수
	
	[표현식]
	ROUND(숫자[, 소숫점 위치]) : 소숫점 위치까지 반올림한 값을 구해줌. 생략 시 첫번째 위치에서 반올림
	
	☞ 소숫점의 위치가 양수일 경우 소숫점 뒤로 한 칸 씩 이동
	☞ 소숫점의 위치가 음수일 경우 소숫점 앞으로 한 칸 씩 이동
*/

SELECT ROUND(3.141592, 3) FROM DUAL;
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
-- ==============================================================
/*
	CEIL : 올림처리
	FLOOR : 버림처리
*/

SELECT CEIL(123.456) FROM DUAL;
SELECT FLOOR(123.456) FROM DUAL;

/*
	TRUNC : 버림처리 한 결과를 반환해주는 함수. (위치 지정 가능)
	
	☞ 위치값이 양수일 경우 소숫점 뒷쪽에서 버림
	☞ 위치값이 음수일 경우 소숫점 앞쪽에서 버림
*/
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -2) FROM DUAL;
-- ==============================================================
/*
	[날짜 타입 관련 함수]
	SYSDATE : 시스템의 현재 날짜 및 시간을 반환
	
	MONTHS BETWEEN : 두 날짜 사이의 개월수
	
	[표현법]
		MONTHS_BETWEEN(날짜A, 날짜B) : 날짜A - 날짜B
*/
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/31') || '개월차' FROM DUAL; -- 보통은 소숫점으로 출력되므로 올림처리 해줘야한다
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/12/31')) FROM DUAL;

SELECT FLOOR(MONTHS_BETWEEN('25/6/18', SYSDATE)) FROM DUAL;

-- 사원 정보 중 사원명, 입사일, 근속개월수 조회
SELECT EMP_NAME AS "사원명", HIRE_DATE AS "입사일", CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "근속개월수"
FROM EMPLOYEE
--WHERE ENT_DATE IS NULL;
WHERE ENT_YN = 'N'
ORDER BY 근속개월수 DESC;

/*
	ADD_MONTHS : 특정 날짜에 N개월 수를 더해서 반환
	[표현법]
		ADD_MONTHS(날짜, 더할개월수)
*/
SELECT SYSDATE AS "현재날짜", ADD_MONTHS(SYSDATE, 3) AS "3개월 후" FROM DUAL;

-- 사원 정보 중 사원명, 입사일, 수습종료일 조회
-- 수습기간 : 입사일 + 3
SELECT EMP_NAME AS "사원명", HIRE_DATE AS "입사일", ADD_MONTHS(HIRE_DATE, 3) AS "수습종료일"
FROM EMPLOYEE;

/*
	NEXT_DAY :  특정 날짜 이후 지정한 요일의 가장 가까운 날짜를 반환
	
	[표현법]
		NEXT_DAT(날짜, 요일)
		- 요일 ☞ 숫자 또는 문자
		1: 일, 2: 월, ... 7: 토

*/

SELECT NEXT_DAY(SYSDATE, 1) AS "현재날짜와 가장 가까운 일요일" FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일') AS "현재날짜와 가장 가까운 일요일" FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일요일') AS "현재날짜와 가장 가까운 일요일" FROM DUAL;
--SELECT NEXT_DAT(SYSDATE, 'SUNDAY') AS "현재날짜와 가장 가까운 일요일" FROM DUAL; 
-- 문자 타입을 전달 시 언어 설정에 따라 사용할 수 있음
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUN') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

/*
	LAST_DAY : 해당 월의 마지막 날짜를 반환해주는 함수
*/

SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT 
EMP_NAME AS "사원명", 
HIRE_DATE AS "입사일", 
LAST_DAY(HIRE_DATE) AS "입사한 달의 마지막 날짜", 
LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 AS "입사한 달의 근무일 수 조회"
FROM EMPLOYEE;

/*
	EXTRACT : 특정 날짜로부터 연도/월/일 값을 추출하여 반환해주는 함수

	[표현법]
	EXTRACT((YEAR | MONTH | DAY) FROM 날짜) : 해당 날짜의 연도만 추출
*/

-- 현재날짜의 연도/월/일을 각각 추출하여 조회
SELECT SYSDATE,
		EXTRACT(YEAR FROM SYSDATE) AS "연도", 
		EXTRACT(MONTH FROM SYSDATE) AS "월",
		EXTRACT(DAY FROM SYSDATE) AS "일"
FROM DUAL;

-- 사원정보 중 사원명, 입사년도, 입사월, 입사일 조회
SELECT 
	EMP_NAME AS "사원명", 
	EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도", 
	EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",  
	EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
ORDER BY 입사년도 ASC, 입사월 ASC, 입사일 ASC;
-- ==============================================================
/*
	형변환 함수 : 데이터 타입을 변경해주는 함수
*/

/*
	TO_CHAR : 숫자 또는 날짜 타입의 값을 문자타입으로 변경해주는 함수
	
	[표현법]
	TO_CHAR(숫자 또는 날짜[, 포맷])
*/

-- 숫자타입을 문자타입으로 변경
SELECT 1234 AS "숫자타입의 데이터", TO_CHAR(1234) AS "문자타입으로 형변환" FROM DUAL;

SELECT TO_CHAR(1234) AS "타입 변경만 한 데이터", TO_CHAR(1234, '999999') AS "포맷지정데이터" FROM DUAL;
-- ☞ 9 : 개수만큼 자리수를 확보해서 빈자리를 공백으로 채운다. 오른쪽 정렬된것 처럼 보이게 함

SELECT TO_CHAR(1234) AS "타입 변경만 한 데이터", TO_CHAR(1234, '000000') AS "포맷지정데이터" FROM DUAL;
-- ☞ 0 : 개수만큼 자리수를 확보해서 빈자리를 0으로 채운다. 오른쪽 정렬된것 처럼 보이게 함

SELECT TO_CHAR(1234, 'L999999')  AS "포맷데이터" FROM DUAL;
-- ☞ L : 현재 설정된 나라의 로컬 화폐단위를 표시.

SELECT TO_CHAR(1234, '$999999') AS "포맷데이터" FROM DUAL;

SELECT 1000000, TO_CHAR(1000000, 'L9,999,999') AS "포맷데이터" FROM DUAL;

-- 사원들의 사원명, 월급, 연봉을 조회(월급과 연봉은 화폐단위를 표시해주고 3자리씩 구분지어 표시하기)
SELECT EMP_NAME AS "사원명", TO_CHAR(SALARY, 'L999,999,999') AS "월급", TO_CHAR(SALARY * 12, 'L999,999,999') AS "연봉"
FROM EMPLOYEE;
-- ==============================================================