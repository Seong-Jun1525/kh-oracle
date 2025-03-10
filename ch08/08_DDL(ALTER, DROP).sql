/*
	DDL 데이터 정의 언어
	
	객체들을 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 언어
*/
------------------------------------------------------------------------------------------------------
/*
	ALTER : 객체 변경하는 구문
	
	- 테이블에 대한 변경
	
	[표현법]
		ALTER TABLE 테이블명 변경할내용
		
	변경되는 내용
		- 컬럼 추가 / 수정 / 삭제
		- 제약조건 추가 / 삭제				☞ 수정 불가 (수정이 필요할 경우 삭제하고 다시 만들어야 함)
		- 컬럼명 / 제약조건명 / 테이블명 변경
*/

/*
	컬럼 추가 

	ADD 컬럼명 데이터타입 [DEFAULT 기본값] [제약조건];
*/
-- DEPT_TABLE 테이블에 CNAME VARCHAR2(20) 컬럼추가
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);

-- ☞ 새로운 컬럼이 추가되고, 기본적으로 NULL 값으로 채워짐

-- DEPT_TABLE 테이블에 LNAME VARCHAR2(20) 컬럼 추가, 기본값을 지정 : '한국'
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '한국';

------------------------------------------------------------------------------------------------------

/*
	컬럼 수정(MODIFY)
		- 데이터 타입 수정 : MODIFY 컬럼명 변경할 데이터타입;
		- 기본값 수정		 : MODIFY 컬럼명 DEFAULT 변경할 기본값;
*/

-- DEPT_TABLE 테이블의 DEPT_ID 컬럼을 변경
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);

-- 데이터 타입 : 숫자 타입으로 변경 CHAR(5) ☞ NUMBER
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;
/*
	ORA-01439: 데이터 유형을 변경할 열은 비어 있어야 합니다
	01439. 00000 -  "column to be modified must be empty to change datatype"
	
	형식 오류 발생! (기존 문자타입에서 숫자타입으로 변경 X)
	하지만 값들이 없다면 변경됨
*/
-- DEPT_TABLE 테이블의 DEPT_TITLE 컬럼 변경
-- 데이터타입 VARCHAR2(35) ☞ VARCHAR2(10)
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10);
/*
	ORA-01441: 일부 값이 너무 커서 열 길이를 줄일 수 없음
	01441. 00000 -  "cannot decrease column length because some value is too big"
	
	이미 저장된 값들은 변경 전 크기를 기준으로 저장되어 있으므로
	데이터 손실을 할 수 없기 때문에 변경이 안된다
*/
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(50); -- 더 큰 크기로는 변경이 가능하다

-- EMP_TABLE의 SALARY 컬럼을 변경
-- NUMBER  ☞ VARCHAR2(50)
ALTER TABLE EMP_TABLE MODIFY SALARY VARCHAR2(50);
/*
	ORA-01439: 데이터 유형을 변경할 열은 비어 있어야 합니다
	01439. 00000 -  "column to be modified must be empty to change datatype"
	
	변환이 가능한 데이터타입이더라도 데이터가 있다면 변경할 수 없다
*/

-- 여러 개의 컬럼 변경 가능!!
-- DEPT_TABLE 테이블의 DEPT_TITLE 컬럼은 VARCHAR2(55),
-- 						LNAME 컬럼은 기본값을 '코리아'로 변경
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(55)
							MODIFY LNAME DEFAULT '코리아';
						
------------------------------------------------------------------------------------------------------	
/*
	컬럼 삭제
	
	DROP COLUMN 삭제
*/
--DEPT_TABLE 테이블을 DEPT_COPY 테이블로 복제 
CREATE TABLE DEPT_COPY
AS (SELECT * FROM DEPT_TABLE);

-- DEPT_COPY 테이블에서 LNAME 컬럼 삭제
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
-- 테이블에는 최소한 한 개의 컬럼은 존재해야함 


/*
	제약조건 추가 / 삭제
	
	-- 제약조건 추가
	-- 기본키 (PRIMARY KEY) : ADD PRIMARY KEY (컬럼명);
	-- 외래키 (FOREIGN KEY) : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할 테이블명 ([참조할 컬럼명]);
	-- UNIQUE 				: ADD UNIQUE(컬럼명)
	-- CHECK 				: ADD CHECK (컬럼에 대한 조건식) 특정 값들만 저장하고자 할 때 사용! NULL 값도 저장 가능
	-- NOT NULL				: MODIFY 컬럼명 NOT NULL |NULL 값을 허용할지 말지에 대한 제약조건
	
	제약조건명을 지정하고자 한다면 CONSTRAINT 제약조건명 추간	
*/

-- DEPT_TABLE 테이블에
-- DEPT_ID 컬럼에 기본키 추가
-- DEPT_TITLE 컬럼에 UNIQUE 추가
-- LNAME 컬럼에 NOT NULL 추가

ALTER TABLE DEPT_TABLE ADD CONSTRAINT DT_PK PRIMARY KEY (DEPT_ID)
							ADD CONSTRAINT DT_UQ UNIQUE (DEPT_TITLE)
							MODIFY LNAME NOT NULL;

/*
	제약조건 삭제
	DROP CONSTRAINT 제약조건명
	MODIFY 컬럼명 NULL(NOT NULL 제약을 NULL로 변경)

*/
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_UQ
								MODIFY LNAME NULL;

/*
	컬럼명, 제약조건명, 테이블명 변경(RENAME)
*/
-- 1) 컬럼명 : RENAME COLUMN 기존 컬럼명 TO 변경할 컬럼명
--DEPT_TABLE 테이블의 DEPT_TITLE 컬럼의 이름을 DEPT_NAME으로 변경
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 2) 제약조건명 변경 : RENAME CONSTRAINT 기존 제약조건명 TO 변경할제약조건명
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008469 TO DT_DEPTID_NN;

-- 3) 테이블명 변경 : RENAME TO 변경할 테이블 명
ALTER TABLE DEPT_TABLE RENAME TO DEPT_END;

/*
	DROP : 객체를 삭제하고자 할 때 사용하는 구문
	
	- 테이블 삭제
		DROP TABLE 테이블명
*/
--DROP TABLE DEPT_END;
-- 어딘가에 참조되고 있는 부모테이블은 삭제가 되지 않음
-- 지우고자 할 경우, 1) 자식테이블 삭제 후 부모테이블 삭제
-- 					2) 부모테이블 삭제할 때 제약조건 까지 삭제 DROP TABLE 테이블명 CASCADE CONSTRAINT
