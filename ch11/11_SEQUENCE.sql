/*
	시퀀스(SEQUENCE)
	- 자동으로 번호를 발생시켜주는 역할을 하는 객체
	- 정수를 순차적으로 일정한 값마다 증가시키면서 생성
*/

/*
	시퀀스 생성
	[표현법]
		CREATE SEQUENCE 시퀀스명
		[START WITH 숫자]			☞ 처음 발생시킬 시작값 지정 (생략 시 기본값은 1)
		[INCREMENT BY 숫자]		☞ 얼마만큼씩 증가시킬 것인지에 대한 값 지정 (생략 시 기본값은 1)
		[MAXVALUE 숫자]			☞ 최대값 (생략 시 기본값은 엄청크다)
		[MINVALUE 숫자]			☞ 최솟값 (생략 시 기본값은 1)
		[CYCLE | NOCYCLE]			☞ MAX 혹은 MINVALUE와 연관있음. 값의 순환여부 (기본값은 NOCYCLE)
											* CYCLE : 시퀀스 값이 최대값에 도달하면 최소값으로 다시 순환하도록 설정
											* NOCYCLE : 시퀀스 값이 최대값에 도달하면 최소값으로 다시 순환하도록 설정
		 [NOCACHE | CACHE 숫자]		☞ 캐시메모리 할당 여부 (기본값 CACHE 20)
											* 캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간
															매번 호출될 때마다 새로 번호를 생성하는 것이 아니라
															캐시메모리라는 공간에 미리 생성해둔 값을 가져다가 사용 (속도가 빠름)
															
		* 참고
			- 테이블 : TB_
			- 뷰		: VW_
			- 시퀀스 : SEQ_
			- 트리거 : TRG_ 
		
*/

CREATE SEQUENCE SEQ_TEST;

-- 현재 계정에 생성된 시퀀스 조회
SELECT * FROM USER_SEQUENCES;

-- SEQ_EMPNO 시퀀스 생성
CREATE SEQUENCE SEQ_EMPNO
	START WITH 300
	INCREMENT BY 5
	MAXVALUE 310
	NOCYCLE -- 기본값이라 생략가능
	NOCACHE;
	
/*
	시퀀스 사용
	
	- 시퀀스명.CURRAL : 현재 시퀀스 값. 마지막으로 성공한 NEXTVAL의 수행한 값.
	- 시퀀스명.NEXTVAL : 시퀀스 값에 일정 값을 증가시켜 발생한 결과값
							현재 시퀀스 값에서 INCREMENT BY에 설정된 값만큼 증가된 값	
*/	

-- SEQ_EMPNO 시퀀스의 현재 시퀀스 값 조회
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 오류 발생! NEXTVAL을 한번도 사용하지 않은 시퀀스는 CURRVAL를 사용할 수 없다

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 처음 수행 시 시작 값을 확인할 수 있음.
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 증가된 값 확인!
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 증가된 값 확인!
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 오류발생!! 최대값을 넘기려고 함

/*
	* 시퀀스 변경
	ALTER SEQUENCE 시퀀스명
	[INCREMENT BY 숫자]
	[MAXVALUE 숫자]
	[MINVALUE 숫자]
	[CYCLE | NOCYCLE]
	[NOCACHE | CACHE 숫자]
	
	☞ 시작 값만 변경 불가!
*/

-- SEQ_EMPNO 시퀀스의 증가값을 10, 최대값을 400으로 변경
ALTER SEQUENCE SEQ_EMPNO
	INCREMENT BY 10
	MAXVALUE 400;
	
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310	

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320

/*
	시퀀스 삭제
	DROP SEQUENCE 시퀀스명;
*/
DROP SEQUENCE SEQ_EMPNO;

SELECT * FROM USER_SEQUENCES;
------------------------------------------------------------------------------------------
/*
	시퀀스 사용
*/

SELECT * FROM EMPLOYEE;

-- 시퀀스 생성 (SEQ_EID) 300번 부터 시작, 캐시메모리 사용X, 증가값은 1
CREATE SEQUENCE SEQ_EID
	START WITH 300
	NOCACHE;
	
-- 시퀀스 사용 : EMPLOYEE 테이블에 데이터가 추가될 때
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
	VALUES (SEQ_EID.NEXTVAL, '임성준', '250311-1231233', 'J1', SYSDATE);
ROLLBACK;