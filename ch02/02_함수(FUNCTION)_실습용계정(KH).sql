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

-- 사원 정보 중 이메일, 이메일의 '_'의 첫 번째 위치, 이메일의 '@'의 첫 번째 위치, '_' 까지의 바이트 크기 조회
SELECT EMAIL, INSTR(EMAIL, '_') AS " '_'의 첫 번째 위치", INSTR(EMAIL, '@') AS " '@'의 첫 번째 위치", INSTRB(EMAIL, '_') AS " '_' 까지의 바이트 크기"
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
-- 날짜 타입 ☞ 문자타입
SELECT SYSDATE, TO_CHAR(SYSDATE) AS "문자로 변환" FROM DUAL;
/*
	시간 관련 패턴
	
	- HH : 시 정보(HOUR) ☞ 12시간제
	- HH24 ☞ 24시간제
	
	- MI : 분 정보(MINUTE)
	- SS : 초 정보(SECOND)
*/
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; -- 12시간제
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 12시간제

SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
-- ☞ AM / PM 은 오전 오후를 표시

/*
	요일 관련 패턴
	
	- DAY : X요일 ☞ 월요일, 화요일, ...
	
	- DY : 월, 화, 수, ...
	
	- D : 요일에 대해서 숫자타입으로 표시(1 : 일요일, 2: 월요일, ...7: 토요일)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY D') FROM DUAL;

/*
	월 관련 패턴
	- MON, MONTH: X월 ☞ 1월, 2월, 3월, ...
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH') FROM DUAL;

/*
	일 관련 패턴
	
	- DD : 일 정보를 2자리로 표현
	- DDD : 해당 날짜의 해당년도 기준 몇 번째 일수
*/
SELECT TO_CHAR(SYSDATE, 'DD') AS "2자리 표현", TO_CHAR(SYSDATE, 'DDD') AS "몇 번째 일"
FROM DUAL;

/*
	년도 관련 패턴
	- YYYY : 년도를 4자리로 표현
	- YY: 년도를 2자리로 표현
	
	- RRRR: 년도를 4자리로 표현
	- RR: 년도를 2자리로 표현
	☞ 입력된 연도가 00 ~ 49일 때
			☞ 현재 연도의 끝 두자리가 00 ~ 49
				☞ 변환된 연도의 앞 두리가 현재 연도와 동일
			☞ 현재 연도의 끝 두자리가 50 ~ 99
				☞ 변환된 연도의 앞 두자리는 현재 연도의 앞 두자리의 + 1
				
	☞ 입력된 연도가 50 ~ 99일 때
			☞ 현재연도의 끝 두자리가 00 ~ 49
				☞ 변환된 연도의 앞 두자리에 현재 연도의 앞 두 자리 - 1
			☞ 현재 연도의 끝 두자리가 50 ~ 99
				☞ 변환된 연도의 앞 두자리가 현재 연도와 동일	
*/
SELECT TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY') AS "RR 사용(50미만)",
			TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY') AS "RR 사용(50이상)",
			TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY') AS "YY 사용(50이상)",
			TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY') AS "YY 사용(50이상)"
FROM DUAL;
-- EX) 회원정보 중 1900 년대 생인 경우 위의 처럼 데이터를 불러오면 85년생이 2085으로 불러와지므로 이럴 경우에는 RR을 사용해야함

-- 사원 정보 중 사원명, 입사날짜 조회
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS "입사날짜"
FROM EMPLOYEE;
-- 표시할 문자(글자) 부분은 큰 따옴표("")로 묶어서 패턴에 반영해야 함

/*
	TO_DATE : 숫자타입 또는 문자타입을 날짜타입으로 변경해주는 함수
	
	[표현법]
		TO_DATE(숫자 또는 문자[, 패턴])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL; -- ☞ 50년 미만은 자동으로 20XX으로 변경됨
SELECT TO_DATE(550304) FROM DUAL; -- ☞ 50년 이상은 자동으로 19XX으로 변경됨

SELECT TO_DATE(020222) FROM DUAL; -- ☞ 숫자는 0으로 시작하면 안됨. 이럴 경우는 문자타입으로 전달해야함
SELECT TO_DATE('020222') FROM DUAL;

SELECT TO_DATE('20250304 104230') FROM DUAL; -- ☞ 시간을 포함하는 경우에는 패턴을 지정해야함
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS') FROM DUAL;

-- ==============================================================
/*
	TO_NUMBER : 문자타입의 데이터를 숫자타입으로 변경
	
	[표현법]
		TO_NUMBER(문자[, 패턴])
		☞ 기호나 화폐단위를 포함하는 경우 패턴을 지정
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;
SELECT '10000' + '500' FROM DUAL; -- ORACLE은 문자 ☞ 숫자 변환되어 산술연산이 수행됨
SELECT '10,000' + '500' FROM DUAL; -- 에러발생

SELECT TO_NUMBER('10,000', '999,999') + TO_NUMBER('500', '999,999') FROM DUAL;
-- ==============================================================
/*
	NULL 처리 함수
*/
/*
	NVL : 해당 컬럼의 값이 NULL일 경우 다른 값으로 사용할 수 있도록 변경해주는 함수
	
	[표현법]
		NVL(컬럼명, 해당컬럼의 값이 NULL인 경우 사용할 값)
*/

-- 사원 정보 중 사원명, 보너스 정보를 조회
-- (단, 보너스 값이 NULL인 경우 0으로 표시)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 보너스, 연봉, 보너스 포함 연봉을 조회
SELECT EMP_NAME, NVL(BONUS, 0), SALARY * 12 AS "연봉", (SALARY + (SALARY * NVL(BONUS, 0))) * 12 AS "보너스 포함 연봉"
FROM EMPLOYEE;

/*
	NVL2 : 해당 컬럼의 값이 NULL인 경우 표시할 값을 지정하고, NULL이 아닌 경우 표시할 값도 지정할 수 있는 함수

	[표현법]
		NVL2(컬럼명, 데이터가 존재하는 경우 사용할 값, NULL인 경우 사용할 값)
*/
-- 사원 정보 중 사원명, 보너스 유무 조회(보너스가 있을 경우 'O' 없을 경우 'X' 표시)
SELECT EMP_NAME AS "사원명", NVL2(BONUS, 'O', 'X') AS "보너스 유무"
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 부서코드, 부서배치여부 조회 (배치가 된 경우 '배정완료', 배치되지 않은 경우 '미배정' 표시)
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '배정완료', '미배정') AS "부서배치여부"
FROM EMPLOYEE;

/*
	NULLIF : 두 값이 일치하면 NULL, 일치하지 않는 다면 비교대상1 반환

	[표현법]
		NULLIF(비교대상1, 비교대상2)
*/
SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '555') FROM DUAL;

-- ==============================================================
/*
	선택함수
		DECODE(비교대상, 비교값1, 결과값1, 비교값2, 결과값2, ...)
		
	☞ switch문과 유사함
*/
-- ==============================================================
-- 사원정보 중 사번, 사원명, 주민번호, 성별 조회
-- 단, 성별은 1인 경우 남, 2인 경우 여, 그외 알수없음
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여', '알수없음') AS "성별"
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 기존급여, 인상된 급여 조회
/*
	직급 = 'J7'인 경우 10% 인상
	직급 = 'J6'인 경우 15% 인상
	직급 = 'J5'인 경우 20% 인상
	그외 5%인상
*/
SELECT EMP_NAME, SALARY AS "기존 급여", DECODE(JOB_CODE, 'J7', SALARY * 1.1, 'J6', SALARY * 1.15, 'J5', SALARY * 1.2, SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE;

/*
	CASE WHEN THEN : 조건식에 따라 결과값을 반환해주는 함수
	
	[표현법]
		CASE 
			WHEN 조건식1 THEN 결과값1
			WHEN 조건식2 THEN 결과값2
			...
			ELSE 결과값
		END
	☞ if-else문과 유사
*/
-- 사원정보 중 사원명, 급여, 급여에 따른 등급 조회
/*
	500만원 이상인 경우 '고급'
	350만원 이상인 경우 '중급'
	그외 초급
*/
SELECT EMP_NAME, SALARY, 
		CASE
			WHEN SALARY >= 5000000 THEN '고급'
			WHEN SALARY BETWEEN 3500000 AND 4999999 THEN '중급'
			ELSE '초급'
		END AS "급여 등급"
FROM EMPLOYEE;		

-- ==============================================================
/* 그룹함수
	SUM : 해당 컬럼의 총 합을 반환해주는 함수
	
	[표현법]
		SUM(숫자타입컬럼)
*/
-- 전체 사원들의 총 급여 조회
SELECT SUM(SALARY) AS "총 급여"
FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "총 급여" -- 나열해서 같이 사용할 수는 없지만 이런식으로 사용 가능
FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "남자 사원의 총 급여"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- 부서코드가 'D5'인 사원들의 총 연봉
SELECT TO_CHAR(SUM(SALARY * 12), 'L999,999,999') AS "D5 총 연봉"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
-- ==============================================================
/*
	AVG : 해당 컬럼의 평균을 반환해주는 함수
	
	[표현법]
	AVG(숫자타입컬럼)
*/
-- 전체사원들의 평균 급여 조회( 반올림 적용)
SELECT TO_CHAR(ROUND(AVG(SALARY)), 'L999,999,999') AS "평균급여"
FROM EMPLOYEE;
-- ==============================================================
/*
	MIN : 해당 컬럼의 값들 중 가장 작은 값을 반환
	MAX : 해당 컬럼의 값들 중 가장 큰 값을 반환
	
	[표현법]
	MIN(모든타입컬럼)
	MAX(모든타입컬럼)
*/
SELECT MIN(EMP_NAME) AS "문자타입의 최솟값", MIN(SALARY) AS "숫자타입의 최솟값", MIN(HIRE_DATE) AS "날짜타입의 최솟값"
FROM EMPLOYEE;

SELECT MAX(EMP_NAME) AS "문자타입의 최솟값", MAX(SALARY) AS "숫자타입의 최솟값", MAX(HIRE_DATE) AS "날짜타입의 최솟값"
FROM EMPLOYEE;

-- ==============================================================
/*
	COUNT(*) : 조회된 결과에 모든 행의 갯수를 반환
	COUNT(컬럼) : 해당컬럼의 값이 NULL이 아닌 것만 행의 갯수로 세어 반환
	COUNT(DISTINCT 컬럼) : 해당 컬럼의 값에서 중복 제거 후 갯수를 세어 반환
		☞ 중복 제거시 NULL은 포함하지 않고 갯수가 세어짐
*/
SELECT COUNT(*) AS "전체 사원 수"
FROM EMPLOYEE;

SELECT COUNT(*) AS "전체 사원 수"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

SELECT COUNT(*) AS "전체 사원 수"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- 보너스를 받는 사원 수
SELECT COUNT(*) AS "보너스를 받는 사원 수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS) AS "보너스를 받는 사원 수"
FROM EMPLOYEE;

SELECT COUNT(DEPT_CODE) AS "부서배치를 받은 사원 수"
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) AS "소속사원이 있는 부서 수"
FROM EMPLOYEE;