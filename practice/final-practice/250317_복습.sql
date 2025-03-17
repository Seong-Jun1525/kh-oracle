-- * 아래 계정을 생성하여 접속한 후 아래 쿼리문을 실행해주세요.
--   USERNAME / PWD : C##TEST250317 / TEST0317
SELECT * FROM DBA_USERS WHERE USERNAME LIKE 'C##%';

DROP USER C##TEST250317;
CREATE USER C##TEST250317 IDENTIFIED BY TEST250317;								-- IDENTIFIED BY 비밀번호를 하지 않아도 계정은 생성된다
GRANT CONNECT, RESOURCE TO C##TEST250317;										-- CONNECT : 접속, RESOURCE : 자원

--ALTER USER C##TEST250317 QUOTA UNLIMITED ON USERS;							-- 최소한의 테이블스페이스를 설정				
ALTER USER C##TEST250317 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;		-- 최소한의 테이블스페이스를 설정

DROP USER C##TEST250317;

--------------------------------------------------------------------------------------------------------
DROP TABLE DEPARTMENTS;
DROP TABLE EMPLOYEES;

-- DEPARTMENTS 테이블 생성
CREATE TABLE DEPARTMENTS (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50) NOT NULL
);

-- EMPLOYEES 테이블 생성
CREATE TABLE EMPLOYEES (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    SALARY NUMBER,
    HIRE_DATE DATE,
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID)
);

-- DEPARTMENTS 데이터 삽입
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (1, '인사부');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (2, '재무부');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (3, 'IT부서');

-- EMPLOYEES 데이터 삽입
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (101, '홍길동', 3500000, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (102, '김철수', 3200000, TO_DATE('2019-03-22', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (103, '이영희', 3800000, TO_DATE('2021-07-10', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (104, '박지수', 4500000, TO_DATE('2018-11-05', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (105, '최민호', 4700000, TO_DATE('2022-02-18', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (106, '신기술', 2900000, TO_DATE('2024-05-13', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (107, '오라클', 3300000, TO_DATE('2024-07-23', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (108, '배자바', 3900000, TO_DATE('2025-01-06', 'YYYY-MM-DD'), 3);
--------------------------------------------------------------------------------------------------------

-- 모든 직원의 이름과 급여를 조회
-- 인출된 모든 행 : 8
SELECT EMP_NAME, SALARY FROM EMPLOYEES;

-- '재무부'에 속한 직원들의 이름과 부서명을 조회 (오라클 전용 구문 사용)
/*
    EMP_NAME    | DEPT_NAME
    -----------------------
    김철수       | 재무부
    박지수       | 재무부
*/
-- 오라클 전용
SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPT_ID = D.DEPT_ID AND D.DEPT_NAME = '재무부';

-- ANSI
SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEES
	JOIN DEPARTMENTS USING (DEPT_ID)
WHERE DEPT_NAME	= '재무부';


-- 평균 급여를 계산 (소숫점 2자리까지 표시)
/*
    평균 급여
    ----------
    3766666.67
*/
SELECT TO_CHAR(AVG(SALARY), '9999999990.99') AS "평균 급여"
FROM EMPLOYEES;

-- 부서별 직원 수를 계산하고, 직원 수가 3명 이상인 부서만 조회 
/*
    부서명     | 직원 수
    -----------------------
    IT부서     | 4
*/
SELECT DEPT_NAME AS "부서명", COUNT(*) AS "직원 수"
FROM EMPLOYEES
	JOIN DEPARTMENTS USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING COUNT(*) >= 3;

-- 급여가 가장 높은 직원의 이름과 급여를 조회
/*
    직원 이름      | 급여
    --------------------------
    최민호	      | 4700000
*/
SELECT EMP_NAME AS "직원 이름", SALARY AS "급여"
FROM EMPLOYEES
WHERE SALARY = (
	SELECT MAX(SALARY)
	-- EMP_NAME, MAX(SALARY)  그룹함수는 단일행 함수와 같이사용 할 수 없음.
	--	EMP_NAME의 결과는 여러 개인데 MAX(SALARY)의 결과는 하나임 그래서 같이 사용할 수 없음
	FROM EMPLOYEES	
);

-- 새로운 테이블 PROJECTS를 생성 
--  ( 저장 정보: 프로젝트번호 (PROJECT_ID:NUMBER (PK), 프로젝트명 (PROJECT_NAME:VARCHAR2(100) NULL 허용X)))
DROP TABLE PROJECTS;
CREATE TABLE PROJECTS (
	PROJECT_ID NUMBER CONSTRAINT PRJ_PK PRIMARY KEY,
	PROJECT_NAME VARCHAR2(100) NOT NULL -- VARCHAR2와 CHAR의 차이와 한글은 3BYTE이고 나머지는 1BYTE라는 것 중요
);

COMMENT ON COLUMN PROJECTS.PROJECT_ID IS '프로젝트번호';
COMMENT ON COLUMN PROJECTS.PROJECT_NAME IS '프로젝트명';

-- 새로운 직원 '김민지'를 EMPLOYEES 테이블에 삽입 ( 직원 정보: 급여 3500000, IT부서, 오늘 입사)
-- * 직원 번호의 경우, 시퀀스를 생성하여 활용해보자. 
DROP SEQUENCE SEQ_EMPID;
CREATE SEQUENCE SEQ_EMPID
	START WITH 109
	NOCYCLE
	NOCACHE;
INSERT INTO EMPLOYEES VALUES(SEQ_EMPID.NEXTVAL, '김민지', 3500000, SYSDATE, 3);
SELECT * FROM EMPLOYEES;
COMMIT;

-- EMPLOYEES 테이블에서 '홍길동'의 급여를 3800000으로 수정
UPDATE EMPLOYEES
	SET SALARY = 3800000
WHERE EMP_NAME = '홍길동';	
SELECT * FROM EMPLOYEES;
COMMIT;

-- EMPLOYEES 테이블에서 급여가 3000000 이하인 직원들을 삭제 -- 1개 행 삭제
DELETE FROM EMPLOYEES WHERE SALARY <= 3000000;
SELECT * FROM EMPLOYEES;
COMMIT;

-- EMPLOYEES 테이블에 새로운 컬럼 EMAIL을 추가 (VARCHAR2(100), 기본값 'temp@kh.or.kr')
ALTER TABLE EMPLOYEES ADD EMAIL  VARCHAR2(100)  DEFAULT 'temp@kh.or.kr';

-- 모든 직원의 이름과 급여를 포함하는 뷰 VW_EMP를 생성
-- * VIEW 생성 권한 부여 (관리자 계정)
GRANT CREATE VIEW TO C##TEST250317;
CREATE VIEW VW_EMP -- OR REPLACE 같은 이름의 뷰가 있을 경우 덮어쓰기!
AS (
	SELECT EMP_NAME AS "이름", SALARY AS "급여"
	FROM EMPLOYEES
);

-- 생성한 VIEW를 기준으로 이름에 '민'이 포함된 직원 조회
/*
    이름   | 급여
    최민호	4700000
    김민지	3500000
*/
SELECT 이름, 급여
FROM VW_EMP
WHERE 이름 LIKE '%민%';

-- 뷰 VW_EMP를 삭제
DROP VIEW VW_EMP;

-- EMPLOYEES 테이블을 삭제
DROP TABLE EMPLOYEES;

----------------------------------------------------------------
-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; 실행
	User C##TEST이(가) 생성되었습니다.
	계정 생성만 하고 접속 시 에러 (user C##TEST lacks CREATE SESSION privillege; logon denied 에러)
*/

-- 원인 ? 생성된 C##TEST 계정에 데이터베이스 접속 권한을 부여하지 않았으므로 에러가 발생한다 => 계정 생성 후 권한을 부여하지 않았다
-- 해결방안 ? GRANT CREATE SESSION TO C##TEST 명령어를 통해 권한을 부여해야 한다

-- 테이블 생성 시 권한 오류 발생 : GRANT RESOURCE TO 계정명; 또는 GRANT CREATE TABLE TO 계정명;

-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
	JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	위의 두 테이블을 조인하여 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회하고자 한다.
	이때 실행한 SQL문이 아래와 같다고 했을 때,
*/
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB USING(JOBNO);
-- 다음과 같은 오류가 발생했다.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- 원인 ? JOBNO라는 컬럼이 TB_JOB 테이블에 존재하지 않아서 발생되는 에러다. => 연결되어야 하는 컬럼명이 다르므로 USING 구분은 사용할 수 없음
-- 해결방안 ? 
--테이블을 JOIN할 때는 JOIN 테이블명 ON 조건 혹은 JOIN 테이블명 USING (조건) 이런식으로 작성할 수 있는데 이때 USING의 경우에는 두 컬럼명이
--동일할 경우에만 사용이 가능하다.
-- 하지만 위 테이블같은 경우에는 JOBNO라는 컬럼은 TB_EMP 테이블에만 존재하므로 FROM TB_EMP JOIN TB_JOB ON JOBNO = JOBCODE 식으로 변경해야한다.

-- 수업 때 진행 했던 퀴즈도 다시 한번 더 살펴보기
