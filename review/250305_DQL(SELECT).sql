--====== 250305_DQL(SELECT)_복습용계정(TEST250305).sql 실행 후 아래 조회 ======--
-- 사용자 계정을 접속해주세요. (사용자명: C##TEST250305 / 비밀번호: test0305)

-- 관리자 계정으로 실행해야함
-- 사용자 생성
-- CREATE USER C##TEST250305 IDENTIFIED BY test0305;

-- 권한 부여
-- GRANT RESOURCE, CONNECT TO C##TEST250305;

-- 테이블 스페이스 관련 설정
-- ALTER USER C##TEST250305 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- 모든 사람의 정보 조회
SELECT * FROM CUSTOMER;

-- 이름, 생년월일, 나이 정보 조회
SELECT NAME AS "이름", BIRTHDATE AS "생년월일", EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 AS "나이"
FROM CUSTOMER;

-- 나이가 40대인 사람들의 정보 조회
SELECT * FROM CUSTOMER
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 BETWEEN 40 AND 49;

-- 광역시에 거주 중인 사람들의 정보 조회
SELECT * FROM CUSTOMER
WHERE ADDRESS LIKE '%광역시%';

-- 이름이 2자인 사람들의 정보 조회
SELECT * FROM CUSTOMER
WHERE LENGTH(NAME) = 2;
--WHERE NAME LIKE '__';
-- LENGTHB(NAME) = 6 -- 한글은 한 글자당 3바이트씩!

--===========================================================================
-- '250305' 문자타입 데이터를 '2025년 03월 05일'로 표현
SELECT TO_CHAR(TO_DATE('250305'), 'YYYY"년" MM"월" DD"일"') FROM DUAL;

-- 본인이 태어난지 며칠 째인지 확인
SELECT CEIL(SYSDATE - TO_DATE('000429')) || '일 째' FROM DUAL;

--===========================================================================
-- 사용자 계정을 접속해주세요. (사용자명: C##KH / 비밀번호: KH)
--  해당 계정이 없을 경우 추가 후 kh.sql 스크립트 실행하여 아래 내용을 수행해주세요.

-- 퇴사하지 않은 사원의 급여 합 조회
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "급여 합"
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 입사월별 사원 수 조회 (* 입사월 오름차순 정렬)
SELECT EXTRACT(MONTH FROM HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY EXTRACT(MONTH FROM HIRE_DATE)
ORDER BY EXTRACT(MONTH FROM HIRE_DATE);