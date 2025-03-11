/*
	트리거 (TRIGGER)
	- 객체
	- 지정한 테이블에 DML문에 의해서 변경사항이 있을 때
	  자동으로 매번 실행한 내용을 미리 정의해두는 것
	  EX) 회원 탈퇴 시 기존 회원테이블에 데이터 삭제하고 탈퇴회원 테이블에 데이터 추가해야 할 때 자동으로 실행..
	  EX) 신고 횟수가 특정 값을 넘어갔을 때 블랙리스트로 처리
	  EX) 입출고에 대한 데이터를 관리할 때 해당 상품의 재고 수량을 갱신해야 할 때 
*/
-------
/*
	트리거의 종류
	- SQL문의 실행 시기에 따른 분류
		* BEFORE TRIGGER : 지정한 테이블에 이벤트가 발생하기 전에 트리거 실행
		* AFTER TRIGGER : 지정한 테이블에 이벤트가 발생한 후에 트리거 실행
	- SQL문에 의해 영향을 받는 각 행에 따른 분류
		* 문장 트리거 : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
		* 행 트리거 : 해당 SQL문이 실행될 때마다 매번 트리거 실행
					- FOR EACH ROW 옵션 설정해야 함.
					
				:OLD  ☞ BEFORE UPDATE (수정 전 데이터), BEFORE DELETE(삭제 전 데이터)
				:NEW ☞ AFTER INSERT (추가된 데이터), AFTER UPDATE(수정된 데이터)
*/
-------
/*
	TRIGGER 생성
	
	CREATE TRIGGER 트리거명									-- 트리거 기본정보
	BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명			-- 이벤트 관련 정보
	[FOR EACH ROW]											-- 트리거를 매번 발생 시킬 경우 작성
	[DECLARE]													-- 변수 / 상수 선언 및 초기화						
	BIGIN														-- 실행부(SQL문, 제어문, ...)
																	이벤트 발생 시 자동으로 처리하고자 하는 구문
	[EXCEPTION]												-- 예외처리부
	END;
*/
-- EMPLOYEE 테이블에 데이터가 추가될 때 마다 '신입사원님 환영합니다.' 출력
CREATE TRIGGER TRG_EMP_WELCOME
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
	DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다.');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE) 
	VALUES(SEQ_EID.NEXTVAL, '홍길동', '123456-1234567', 'J6', SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE) 
	VALUES(SEQ_EID.NEXTVAL, '김길동', '123456-1234567', 'J6', SYSDATE);

-------

-- 상품 입고, 출고 관련
-- TB_PRODUCT 테이블 생성
CREATE TABLE TB_PRODUCT (
	PNO NUMBER PRIMARY KEY,			-- 상품번호
	PNAME VARCHAR2(30) NOT NULL,		-- 상품명
	BRAND VARCHAR2(30) NOT NULL,		-- 브랜드
	PRICE NUMBER DEFAULT 0,			-- 가격
	STOCK NUMBER DEFAULT 0			-- 재고수량
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_PNO
	START WITH 200
	INCREMENT BY 5
	NOCACHE;

-- 샘플 데이터 추가
INSERT INTO TB_PRODUCT (PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '슬리퍼', '아들도스');
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '츄리닝', '나이스', 350000, 50);
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '가방', '델몬트', 150000, 50);
COMMIT;

-- TB_PDETAIL 테이블 생성 : 상품 입출고 내역을 저장하기 위한 테이블
CREATE TABLE TB_PDETAIL (
	DNO NUMBER PRIMARY KEY,						-- 입출고 내역 번호
	PNO NUMBER REFERENCES TB_PRODUCT,			-- 상품번호
	DDATE DATE DEFAULT SYSDATE,					-- 입출고일
	AMOUNT NUMBER NOT NULL,					-- 입출고수량
	DTYPE CHAR(10) CHECK(DTYPE IN ('입고', '출고'))	-- 입출고 종류
);
CREATE SEQUENCE SEQ_DNO
	NOCACHE;
----------------
-- 205번 상품, 오늘 5개 출고
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '출고');
UPDATE TB_PRODUCT
	SET STOCK = STOCK - 5
WHERE PNO = 205;	
COMMIT;

-- 200번 상품이 10개 입고
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');
UPDATE TB_PRODUCT
	SET STOCK = STOCK + 10
WHERE PNO = 205; -- UPDATE를 잘못함!! 롤백해야함!!
ROLLBACK;
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');
UPDATE TB_PRODUCT
	SET STOCK = STOCK + 10
WHERE PNO = 200;
-----------------------------------------------------------------------------------------------------
/*
	TB_PDETAIL 테이블에 데이터가 추가되었을 때
	TB_PRODUCT 테이블에 해당 데이터의 재고 수량을 갱신해야함
	
	UPDATE 조건
		- 상품이 입고된 경우 : 해당 상품을 찾아서 재고 수량을 증가
		UPDATE TB_PRODUCT
			SET STOCK = STOCK + 입고수량(TB_PDETAIL.AMOUNT) ☞ :NEW.AMOUNT
		WHERE PNO = 입고된상품번호(TB_PDETAIL.PNO) 	☞ :NEW.PNO
		
		- 상품이 출고된 경우 : 해당 상품을 찾아서 재고 수량을 증가
		UPDATE TB_PRODUCT
			SET STOCK = STOCK - 출고수량(TB_PDETAIL.AMOUNT) ☞ :NEW.AMOUNT
		WHERE PNO = 출고된상품번호(TB_PDETAIL.PNO) 	☞ :NEW.PNO
*/
-- TRG_STOCK_IO
--DROP TRIGGER TRG_STOCK_IO;
CREATE TRIGGER TRG_STOCK_IO
	AFTER INSERT ON TB_PDETAIL
	FOR EACH ROW
	BEGIN
		-- :NEW : 새로 추가된 데이터를 의미
		IF :NEW.DTYPE = '입고'
			THEN 
				UPDATE TB_PRODUCT
					SET STOCK = STOCK + :NEW.AMOUNT
				WHERE PNO =  :NEW.PNO;
		ELSIF  :NEW.DTYPE = '출고'
			THEN 
				UPDATE TB_PRODUCT
					SET STOCK = STOCK - :NEW.AMOUNT
				WHERE PNO =  :NEW.PNO;
		END IF;	
	END;
/
-- 데이터 추가
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PDETAIL;

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 210, SYSDATE, 7, '입고');

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 3, '출고');



























