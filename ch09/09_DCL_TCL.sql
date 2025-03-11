/*
	DCL (DATA CONTROL LANGUAGE : 데이터 제어 언어
	
	☞ 계정에 시스템 권한 / 객체 접근 권한을 부여하거나 회수하는 구문
	
	- 시스템 권한 : DB에 접근하는 권한, 객체를 생성하는 권한
	- 객체접근 권한 : 특정 객체들을 조작할 수 있는 권한

*/

/*
	계정 생성
		CREATE USER 계정명 IDENTIFIED BY 비밀번호;
	
	권한 부여
		GRANT 권한(CONNECT, RESOURCE) TO 계정명;
		
		- 시스템 권한 종류
		CREATE SESSION : 접속 권한
		CREATE TABLE : 테이블 생성 권한
		CREATE VIEW : 뷰 생성 권한
		CREATE SEQUENCE : 시퀀스 생성 권한
		...
*/

-- 계정명 / PW : SAMPLE / SAMPLE
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;
-- 이렇게만 하면 다음 오류 발생!
-- 상태: 실패 -테스트 실패: ORA-01045: 사용자 C##SAMPLE는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다

-- CREATE SESSION 권한 부여
GRANT CREATE SESSION TO C##SAMPLE;

-- CREATE TABLE
GRANT CREATE TABLE TO C##SAMPLE;

-- TABLE SPACE 할당
ALTER USER C##SAMPLE QUOTA 2M ON USERS;
-- 2M 정도 테이블 스페이스 공간 할당

/*
	객체 접근 권한 종류
	===========================================================
	= 종류					|  	접근 객체							   =
	===========================================================
	= SELECT				|	TABLE, VIEW, SEQUENCE		☞ 조회	   =
	= INSERT 				|	TABLE, VIEW				☞ 추가      =
	= UPDATE 				|	TABLE, VIEW				☞ 수정      =
	= DELETE	 			|	TABLE, VIEW				☞ 삭제      =
	===========================================================
	
	권한 부여
	GRANT 권한종류 ON 특정객체 TO 계정명;
		EX) TEST 계정에 KH 계정의 EMPLOYEE 테이블을 조회할 수 있는 권한 부여
	
		GRANT SELECT ON C##KH.EMPLOYEE TO C##TEST;
	
	권한 회수
	REVOKE 회수할권한 FROM 계정명;
	
		EX) TEST 계정에 부여했던 KH 계정의 EMPLOYEE 테이블을 조회할 수 있는 권한을 회수
		
		REVOKE SELECT ON C##KH.EMPLOYEE FROM TEST;	
*/

/*
	ROLE : 특정 권한들을 하나의 집합으로 모아놓은 것
		- CONNECT : 접속 권한 (CREATE SESSION)
		- RESOURCE : 자원 관리. 특정 객체 생성 권한
						(CRAETE TABLE, CREATE SEQUENCE, ...)
*/

-- 롤 정보 조회
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('SET');

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');						
------------------------------------------------------------------------------------------------------
/*
	TCL (Transaction Control Language)
	- 트랜잭션
		☞ 데이터베이스의 논리적 연산단위
		☞ 데이터의 변경사항들(DML 사용 시)을 하나의 묶음처럼 트랜잭션에 모아둠
		☞ DML문 한 개를 수행할 때 트랜잭션이 존재하면 해당 트랜잭션에 모아서 같이 처리
								트랜잭션이 존재하지 않으면 트랜잭션을 만들어서 묶음
		☞ COMMIT 사용하기 전까지의 변경사항들을 하나의 트랜잭션으로 담게 됨
			☞ 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)
			
	- 트랜잭션 종류
		COMMIT; : 변경사항 적용. 트랜잭션에 담겨져 있는 변경사항들을 실제 DB에 적용하겠다는 의미
		ROLLBACK : 변경사항 취소. 트랜잭션에 담겨져 있는 변경사항들을 삭제(취소)하고, 마지막 COMMIT 시점으로 돌아감
		SAVEPOINT 포인트명; (☞시점명) : 현재 시점에 변경사항들을 임시로 저장해두는 것을 의미
										ROLLBACK 시 전체 변경사항들을 모두 삭제하지 않고, 해당 위치까지만 취소가 가능! (ROLLBACK TO 포인트명;)
*/
-- EMP01 테이블삭제
DROP TABLE EMP01;

-- EMP01 테이블 생성 EMPLOYEE 테이블에서 사번, 사원명, 부서명 정보로 복제
CREATE TABLE EMP01
AS (
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
);

DELETE FROM EMP01
WHERE EMP_ID IN (217, 214);
ROLLBACK;
------------------------------------------------------------------------------------------------------
DELETE FROM EMP01 WHERE EMP_ID = 217;
DELETE FROM EMP01 WHERE EMP_ID = 214;
COMMIT;
ROLLBACK;

SELECT * FROM EMP01;
------------------------------------------------------------------------------------------------------
-- 사원이 208, 209, 210번 삭제
DELETE FROM EMP01
WHERE EMP_ID IN (208, 209, 210);
SAVEPOINT SP; -- SP라는 이름으로 시점을 임시로 저장

INSERT INTO EMP01 VALUES(500, '홍길동', '인사관리부');
INSERT INTO EMP01 VALUES(211, '전형돈', '기술지원부');

-- 사번이 211번인 사원을 삭제
DELETE FROM EMP01 WHERE EMP_ID = 211;

ROLLBACK TO SP;

SELECT * FROM EMP01 ORDER BY EMP_ID;
DELETE FROM EMP01 WHERE EMP_ID = 221;

CREATE TABLE TEST (
	TID NUMBER
);

ROLLBACK;
-- DDL을 사용하게 되면 기존 트랜잭션에 저장된 변경사항들이 무조건 반영됨















