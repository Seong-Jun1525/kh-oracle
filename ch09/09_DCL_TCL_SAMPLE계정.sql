-- TEST ���̺� �߰�
CREATE TABLE TEST (
	TEST_ID NUMBER,
	TEST_NAME VARCHAR2(10)
);
/*
ORA-01031: ������ ������մϴ�
01031. 00000 -  "insufficient privileges"

����� ���� �� �ٷ� ���̺��� �����ϸ� ���� �����߻�!!
������ �������� �ش� ����� �������� ������ �ο��ؾ���!!
*/

INSERT INTO TEST VALUES(100, 'TEST1');
/*
SQL ����: ORA-01950: ���̺����̽� 'USERS'�� ���� ������ �����ϴ�.
01950. 00000 -  "no privileges on tablespace '%s'"
*/