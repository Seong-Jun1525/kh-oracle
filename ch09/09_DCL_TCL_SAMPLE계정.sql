-- TEST 테이블 추가
CREATE TABLE TEST (
	TEST_ID NUMBER,
	TEST_NAME VARCHAR2(10)
);
/*
ORA-01031: 권한이 불충분합니다
01031. 00000 -  "insufficient privileges"

사용자 생성 후 바로 테이블을 생성하면 위의 오류발생!!
관리자 계정에서 해당 사용자 계정한테 권한을 부여해야함!!
*/

INSERT INTO TEST VALUES(100, 'TEST1');
/*
SQL 오류: ORA-01950: 테이블스페이스 'USERS'에 대한 권한이 없습니다.
01950. 00000 -  "no privileges on tablespace '%s'"
*/