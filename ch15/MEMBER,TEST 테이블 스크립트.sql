-- 회원 정보를 저장할 테이블 (MEMBER)
DROP TABLE MEMBER; -- 혹시라도 테이블이 있을 수 있기 때문에
CREATE TABLE MEMBER (
	MEMBERNO NUMBER PRIMARY KEY,					-- 회원번호
	MEMBERID VARCHAR2(20) NOT NULL UNIQUE,			-- 회원ID
	MEMBERPW VARCHAR2(20) NOT NULL,				-- 회원PW
	GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),			-- 성별
	AGE NUMBER,										-- 나이
	EMAIL VARCHAR2(30),								-- 이메일
	ADDRESS VARCHAR2(100),							-- 주소
	PHONE VARCHAR2(13),								-- 연락처
	HOBBY VARCHAR2(50),								-- 취미
	ENROLLDATE DATE DEFAULT SYSDATE NOT NULL		-- 가입날짜
);

-- 회원번호에 대한 시퀀스 객체 생성
DROP SEQUENCE SEQ_MNO;
CREATE SEQUENCE SEQ_MNO NOCACHE;

-- 샘플데이터
INSERT INTO MEMBER VALUES (SEQ_MNO.NEXTVAL, 'ADMIN', '1234', 'M', 26, 'admin@email.com', '인천', '010-1234-1234', NULL, '2020/0312');
INSERT INTO MEMBER VALUES (SEQ_MNO.NEXTVAL, 'SJ', '4321', 'M', 26, 'sj@email.com', '인천', '010-3214-3214', NULL, DEFAULT);
COMMIT;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 테스트용 테이블 TEST
DROP TABLE TEST;
CREATE TABLE TEST (
	TNO NUMBER,
	TNAME VARCHAR2(30),
	TDATE DATE
);

INSERT INTO TEST VALUES (1, '홍길동', SYSDATE);
COMMIT;

SELECT * FROM TEST;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--INSERT INTO MEMBER
--	VALUES (SEQ_MNO.NEXTVAL, '회원아이디', '회원비밀번호', '성별', 나이, '이메일', '주소', '연락처', '취미', DEFAULT);

SELECT * FROM MEMBER;
SELECT * FROM MEMBER WHERE MEMBERID = 'ADMIN';

DELETE FROM MEMBER;