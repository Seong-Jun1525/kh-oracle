/*
	DDL : 데이터 정의 언어
	
	오라클에서 제공하는 객체를 새로 만들고 (CREATE)
									변경하고(ALTER)
									삭제하는(DROP) 언어이다.
	
	☞ 실제데이터가 아닌 규칙/구조를 정의하는 언어
	
	* 오라클에서의 객체(구조) : 테이블, 뷰, 시퀀스, 인덱스, 패키지, 트리거, 프로시저, 함수, 동의어, 사용자, ...
*/

/*
	* CREATE : 객체를 새로 생성하는 구문
	
	[테이블을 생성]
	- 테이블 : 행과 열로 구성되는 가장 기본적인 객체. 모든 데이터들은 테이블을 통해 저장됨
	CREATE TABLE 테이블명 (
		컬럼명 데이터타입(크기), 
		컬럼명 데이터타입,
		컬럼명 데이터타입(크기),
	);
	
	자료형(데이터타입)
		- 문자 ☞ 반드시 크기를 지정해줘야 함
			+ CHAR(바이트크기)			: 고정 길이(고정된 길이의 데이터를 담을 경우)
												☞ 지정한 길이보다 작은 길이의 값이 저장될 경우 공백으로 채워서 저장
												☞ 최대 2000 BYTE 까지 지정 가능
			+ VARCHAR2(바이트크기)		: 가변 길이(데이터의 길이가 정해져 있지 않은 경우)
												☞ 저장되는 데이터 길이만큼만 공간이 사용된다.
												☞ 최대 4000 BYTE 까지 지정 가능
		- 숫자	: NUMBER
		- 날짜	: DATE, DATETIME, TIMESTAMP
*/
-- 회원 정보를 저장할 테이블 생성
-- 테이블 명 : MEMBER
/*
	컬럼 정보
	- 회원 번호			: NUMBER 
	- 회원 아이디			: VARCHAR2(20)
	- 회원 비밀번호		: VARCHAR2(20)
	- 회원 이름			: VARCHAR2(20)
	- 회원 성별			: CHAR(3) -- 한글은 3바이트
	- 회원 이메일			: VARCHAR2(20)
	- 회원 연락처			: CHAR(13) -- 그 외 1바이트
	- 가입일				: DATE
*/
CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	MEM_EMAIL VARCHAR2(20) NOT NULL,
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
);

-- 컬럼에 COMMNET 추가하기
/*
	COMMNET ON COLUMN 테이블명.컬럼명 IS '설명';
	
	☞ 잘못 작성했을 경우 다시 작성 후 실행 (덮어씀)
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원 번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEM_PW IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.MEM_GENDER IS '회원 성별';
COMMENT ON COLUMN MEMBER.MEM_EMAIL IS '회원 이메일';
COMMENT ON COLUMN MEMBER.MEM_PHONE IS '회원 연락처';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '가입 날짜';

-- 테이블 삭제
--DROP TABLE MEMBER;

-- 테이블에 데이터 추가하기
INSERT INTO MEMBER VALUES(1, 'SEONG JUN', '1234', '임성준', '남', 'SJ@emil.com', '010-1234-5678', SYSDATE);

INSERT INTO MEMBER VALUES(2, 'HONG KI', '4321', '이홍기', '남', 'HK@emil.com', NULL, SYSDATE);
COMMIT; -- 변경사항 적용
-- 데이터 전체 삭제
--DELETE FROM MEMBER;

/*
	* 제약조건
	- 원하는 데이터 값만 유지하기 위해서 특정 컬럼에 설정하는 제약
	- 데이터 무결성을 보장하기 위한 목적
	
	- 설정 방식 : 컬럼레벨방식 / 테이블레벨방식
	
	- 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FORIGN KEY
*/
/*
	NOT NULL
	- 해당 컬럼에 반드시 값이 존재해야 하는 경우
		☞ 절대 NULL 값이 저장되면 안되는 경우
		
	- 데이터 추가(삽입) / 수정 시 NULL 값을 허용하지 않음
	
	- 컬럼 레벨 방식으로만 설정 가능!!!
*/

-- 테이블명 : MEMBER_NOTNULL
-- 회원번호, 아이디, 비밀번호, 이름에 대한 데이터는 NULL값을 허용하지 않는다
CREATE TABLE MEMBER_NOTNULL (
	MEM_NO NUMBER NOT NULL,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
);

INSERT INTO MEMBER_NOTNULL VALUES(1, 'HONG123', '1234', '홍길동', '남', 'hong123@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_NOTNULL VALUES(2, 'MYU1234', '4321', '마이유', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_NOTNULL VALUES(3, NULL, '5621', '하이유', NULL, NULL, NULL, NULL);

INSERT INTO MEMBER_NOTNULL VALUES(1, 'HONG123', '1234', '홍길동', '남', 'hong123@emil.com', '010-1234-5678', SYSDATE);
-- 중복되는 데이터가 있음에도 추가되므로 막아야한다

/*
	* UNIQUE *
	- 해당 컬럼에 중복된 값이 있을 경우 제한하는 제약조건
	
	☞ 데이터 추가(삽입) / 수정 시 기존에 있는 데이터 값 중 중복되는 값이 있을 경우 오류 발생
*/
-- UNIQUE 제약 조건을 추가하여 테이블 생성
-- 테이블명 : MEMBER_UNIQUE
-- 회원 아이디가 중복되지 않도록 제한
CREATE TABLE MEMBER_UNIQUE (
	MEM_NO NUMBER NOT NULL,
	MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
--	, UNIQUE (MEM_ID) -- 테이블레벨방식으로 작성
);

INSERT INTO MEMBER_UNIQUE VALUES(1, 'HONG123', '1234', '홍길동', '남', 'hong123@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(2, 'MYU1234', '4321', '마이유', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_UNIQUE VALUES(3, NULL, '5621', '하이유', NULL, NULL, NULL, NULL);

INSERT INTO MEMBER_UNIQUE VALUES(1, 'HONG123', '1234', '홍길동', '남', 'hong123@emil.com', '010-1234-5678', SYSDATE);
-- ORA-00001: 무결성 제약 조건(C##KH.SYS_C008380)에 위배됩니다
-- (C##KH.SYS_C008380) ☞ 계정명.제약조건명
-- 제약 조건 설정 시 제약조건명을 지정하지 않으면 시스템에서 자동으로 만들어줌!!!

/*
	* 제약조건명 설정하기
	[1] 컬럼 레벨 방식
		CREATE TABLE 테이블명(
			컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건
		);
		
	[2] 테이블 레벨 방식
		CREATE TABLE 테이블명(
			컬럼명 자료형,
			컬럼명 자료형,
			컬럼명 자료형,
			...,
			
			[CONSTRAINT 제약조건명] 제약조건 컬럴명
		);
*/
--DROP TABLE MEMBER_UNIQUE;
CREATE TABLE MEMBER_UNIQUE (
	MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
	MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,
	MEM_PW VARCHAR2(20) CONSTRAINT MEMPW_NT NOT NULL,
	MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
	, CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO MEMBER_UNIQUE VALUES(1, 'QQQQ', '1234', '테스트', '남', 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(2, 'TEST2', '4321', '테스트2', NULL, NULL, NULL, NULL);
SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE VALUES(3, 'QQQQ', '2222', '테스트3', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_UNIQUE VALUES(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- CHECK
/*
	CHECK(조건식)
	- 해당 컬럼에 저장할 수 있는 값에 대한 조건을 제시
	- 조건에 만족하는 값만을 저장할 수 있음
	☞ 정해진 값만을 저장하고자 할 때 사용
*/
-- CHECK 제약 조건을 추가한 테이블 생성
-- 테이블명 : MEMBER_CHECK
-- 성별 컬럼에 '남' 또는 '여' 데이터만 저장될 수 있도록 제한
CREATE TABLE MEMBER_CHECK (
	MEM_NO NUMBER NOT NULL,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3) CHECK(MEM_GENDER IN ('남', '여')),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
--	, CHECK(MEM_GENDER IN ('남', '여'))
);

INSERT INTO MEMBER_CHECK VALUES(1, 'TEST2', '4321', '테스트2', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_CHECK VALUES(2, 'QQQQ', '1234', '테스트', NULL, 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_CHECK VALUES(3, 'TEST23', '4321', '테스트2', '남', NULL, NULL, NULL);

/*
	PRIMARY KEY(기본키)
	- 테이블에서 각 행을 식별하기 위해 사용되는 컬럼에 부여하는 제약조건
	
	- NOT NULL + UNIQUE
*/
CREATE TABLE MEMBER_PRI (
	MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
	, CHECK(MEM_GENDER IN ('남', '여'))
);

INSERT INTO MEMBER_PRI VALUES(1, 'TEST2', '4321', '테스트2', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_PRI VALUES(2, 'QQQQ', '1234', '테스트', NULL, 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_PRI VALUES(2, 'TEST23', '4321', '테스트2', '남', NULL, NULL, NULL);
INSERT INTO MEMBER_PRI VALUES(NULL, 'TEST23', '4321', '테스트2', '남', NULL, NULL, NULL);

-- 두 개의 컬럼으로 기본키를 설정하여 테이블 생성
-- 테이블명 : MEMBER_PRI2
-- 회원번호, 회원아이디를 기본키로 설정 (복합키)
CREATE TABLE MEMBER_PRI2 (
	MEM_NO NUMBER,
	MEM_ID VARCHAR2(20),
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
	,  CONSTRAINT MEMPRI2_PK PRIMARY KEY (MEM_NO, MEM_ID)
	, CHECK(MEM_GENDER IN ('남', '여'))
);

INSERT INTO MEMBER_PRI2 VALUES(1, 'TEST2', '4321', '테스트2', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_PRI2 VALUES(2, 'QQQQ', '1234', '테스트', NULL, 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_PRI2 VALUES(2, 'TEST23', '4321', '테스트2', '남', NULL, NULL, NULL);
INSERT INTO MEMBER_PRI2 VALUES(NULL, 'TEST23', '4321', '테스트2', '남', NULL, NULL, NULL);

-- 어떤 회원이 제품을 장바구니에 담는 정보를 저장하는 테이블
-- 회원번호, 제품명, 저장날짜

CREATE TABLE MEMBER_LIKE (
	MEM_NO NUMBER,
	PRODUCT_NAME VARCHAR2(50),
	LIKE_DATE DATE,
	
	PRIMARY KEY (MEM_NO, PRODUCT_NAME)
);

INSERT INTO MEMBER_LIKE VALUES(1, '키보드', SYSDATE);
INSERT INTO MEMBER_LIKE VALUES(1, '마우스', SYSDATE);
INSERT INTO MEMBER_LIKE VALUES(2, '키보드', SYSDATE);

/*
	FOREIGN KEY (외래키)
	- 다른 테이블에서 존재하는 값을 저장하고자 할 때 사용되는 제약조건
		☞ 다른 테이블을 참조
		☞ 주로 외래키를 통해서 테이블 간의 관계를 형성
		
	- 컬럼레벨방식
		컬럼명 [자료형] REFERENCES 참조할테이블명 [(참조할컬럼명)]
		
	- 테이블레벨방식
		FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 [(참조할컬럼명)]
	
	
	☞ 참조할컬럼명 생략 시 참조하는 테이블의 기본키 컬럼이 매칭됨
*/
-- 회원 등급 저장 테이블
DROP TABLE MEMBER_GRADE;
CREATE TABLE MEMBER_GRADE (
	GRADE_NO NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP회원');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP회원');

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	ENROLLDATE DATE,
	GRADE_ID REFERENCES MEMBER_GRADE -- NUMBER 생략 가능
	
	, CHECK(MEM_GENDER IN ('남', '여'))
	
	-- 테이블 레벨 방식
--	, FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER VALUES (1, 'qwer', 1234, '임성준', '남', SYSDATE, 300);
INSERT INTO MEMBER VALUES (2, 'asdf', '4321', '홍길동', '남', SYSDATE, 200);
INSERT INTO MEMBER VALUES (3, 'zxcv', '2222', '최수진', '여', SYSDATE, NULL);
-- 외래키로 설정한 컬럼에는 기본적으로 NULL 값은 저장 가능
INSERT INTO MEMBER VALUES (4, 'zasd', '1111', '박수진', '여', SYSDATE, 400);
-- ORA-02291: 무결성 제약조건(C##KH.SYS_C008425)이 위배되었습니다- 부모 키가 없습니다
-- ☞ 참조하는 테이블에 저장되지 않은 값을 사용할 경우 오류 발생
-- MEMBER_GRADE (부모테이블) -|--------------------<- MEMBER (자식테이블)

INSERT INTO MEMBER VALUES (4, 'zasd', '1111', '박수진', '여', SYSDATE, 100);
DELETE FROM MEMBER WHERE MEM_NO = 4;

-- 부모테이블(MEMBER_GRADE)에서 "일반회원" 등급을 삭제한다면?
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 300;
-- ORA-02292: 무결성 제약조건(C##KH.SYS_C008425)이 위배되었습니다- 자식 레코드가 발견되었습니다

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;

-- 자식테이블에서 이미 사용하고 있는 값이 있을 경우
	-- 부모테이블로부터 무조건 삭제가 되지 않는 "삭제옵션"이 있음!
ROLLBACK;
/*
	외래키 제약조건 - 삭제옵션
	- 부모테이블의 데이터 삭제 시 해당 데이터를 사용하고 있는 자식테이블의 값을 어떻게 할 것인지에 대한 옵션
	
	- ON DELETE RESTRICTED (기본값) : 자식 테이블로부터 사용중인 값이 있을 경우
										부모 테이블에서 데이터를 삭제 불가
	- ON DELETE SET NULL : 부모 테이블에 있는 데이터 삭제 시 해당 데이터를 사용하고 있는 자식 테이블 값을 NULL로 변경
	
	- ON DELETE CASCADE : 부모 테이블에 있는 데이터 삭제 시 해당 데이터를 사용하고 있는 자식 테이블 값도 삭제
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	ENROLLDATE DATE,
	GRADE_ID -- NUMBER 생략 가능
	
	, CHECK(MEM_GENDER IN ('남', '여'))
	
	-- 테이블 레벨 방식
	, FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
);

INSERT INTO MEMBER VALUES (1, 'qwer', 1234, '임성준', '남', SYSDATE, 100);
INSERT INTO MEMBER VALUES (2, 'asdf', '4321', '홍길동', '남', SYSDATE, 200);
INSERT INTO MEMBER VALUES (3, 'zxcv', '2222', '최수진', '여', SYSDATE, NULL);

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
SELECT * FROM MEMBER;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	ENROLLDATE DATE,
	GRADE_ID -- NUMBER 생략 가능
	
	, CHECK(MEM_GENDER IN ('남', '여'))
	
	-- 테이블 레벨 방식
	, FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
);

INSERT INTO MEMBER VALUES (1, 'qwer', 1234, '임성준', '남', SYSDATE, 100);
INSERT INTO MEMBER VALUES (2, 'asdf', '4321', '홍길동', '남', SYSDATE, 200);
INSERT INTO MEMBER VALUES (3, 'zxcv', '2222', '최수진', '여', SYSDATE, NULL);

SELECT * FROM MEMBER;

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;

/*
	기본값(DEFAULT)
	- 제약조건은 아님!
	- 컬럼을 제시하지 않고 데이터 추가 시 NULL 값이 추가되는데 이때, NULL값이 아닌 다른 값으로 저장하고자 할 때
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_NAME VARCHAR2(20) NOT NULL,
	AGE NUMBER,
	HOBBY VARCHAR2(30) DEFAULT '취미없음',
	ENROLLDATE DATE
);

INSERT INTO MEMBER VALUES (1, '민영', 24, '음악감상', SYSDATE);
INSERT INTO MEMBER VALUES (2, '윤서', 23, '게임', NULL);
INSERT INTO MEMBER VALUES (3, '성준', 26, NULL, SYSDATE);
INSERT INTO MEMBER (MEM_NO, MEM_NAME) VALUES (4, '원일');
-- 지정하지 않은 컬럼에 대한 값은 기본적으로 NULL값이 저장됨
-- 단, 해당 컬럼에 기본값이 설정되어 있을 경우 NULL 값이 아닌 기본값으로 저장됨
-- =====================================================================
-- 테이블 복제
/*
	CREATE TABLE AS 서브쿼리;
	
	서브쿼리의 결과로 테이블 생성
	- 복제만 할 뿐 제약조건은 추가되지 않음
*/

-- MEMBER 테이블복제
CREATE TABLE MEMBER_COPY AS (
	SELECT * FROM MEMBER
);

/*
	테이블의 변경사항을 적용하고자 할 때 ☞ ALTER TABLE
	
		ALTER TABLE 테이블명 변경할 내용
		
	[변경할 내용]에 작성	
	- UNIQUE : ADD UNIQUE(컬럼명);
	- CHECK : ADD CHECK(조건식);
	- PRIMARY KEY : ADD PRIMARY KEY (컬럼명);
	- FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 [(참조할컬럼명)];
	
	- NOT NULL : MODIFY 컬럼명 NOT NULL;
	- DEFAULT 옵션 : MODIFY 컬럼명 DEAFULT 기본값;
*/
-- MEMBER_COPY 테이블에 회원번호 컬럼에 기본키 설정
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY (MEM_NO);

-- MEMBER_COPY 테이블에 HOBBY 컬럼에 기본값 설정
ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '없음';