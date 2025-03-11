/*
	DCL (DATA CONTROL LANGUAGE : ������ ���� ���
	
	�� ������ �ý��� ���� / ��ü ���� ������ �ο��ϰų� ȸ���ϴ� ����
	
	- �ý��� ���� : DB�� �����ϴ� ����, ��ü�� �����ϴ� ����
	- ��ü���� ���� : Ư�� ��ü���� ������ �� �ִ� ����

*/

/*
	���� ����
		CREATE USER ������ IDENTIFIED BY ��й�ȣ;
	
	���� �ο�
		GRANT ����(CONNECT, RESOURCE) TO ������;
		
		- �ý��� ���� ����
		CREATE SESSION : ���� ����
		CREATE TABLE : ���̺� ���� ����
		CREATE VIEW : �� ���� ����
		CREATE SEQUENCE : ������ ���� ����
		...
*/

-- ������ / PW : SAMPLE / SAMPLE
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;
-- �̷��Ը� �ϸ� ���� ���� �߻�!
-- ����: ���� -�׽�Ʈ ����: ORA-01045: ����� C##SAMPLE�� CREATE SESSION ������ ���������� ����; �α׿��� �����Ǿ����ϴ�

-- CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO C##SAMPLE;

-- CREATE TABLE
GRANT CREATE TABLE TO C##SAMPLE;

-- TABLE SPACE �Ҵ�
ALTER USER C##SAMPLE QUOTA 2M ON USERS;
-- 2M ���� ���̺� �����̽� ���� �Ҵ�

/*
	��ü ���� ���� ����
	===========================================================
	= ����					|  	���� ��ü							   =
	===========================================================
	= SELECT				|	TABLE, VIEW, SEQUENCE		�� ��ȸ	   =
	= INSERT 				|	TABLE, VIEW				�� �߰�      =
	= UPDATE 				|	TABLE, VIEW				�� ����      =
	= DELETE	 			|	TABLE, VIEW				�� ����      =
	===========================================================
	
	���� �ο�
	GRANT �������� ON Ư����ü TO ������;
		EX) TEST ������ KH ������ EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο�
	
		GRANT SELECT ON C##KH.EMPLOYEE TO C##TEST;
	
	���� ȸ��
	REVOKE ȸ���ұ��� FROM ������;
	
		EX) TEST ������ �ο��ߴ� KH ������ EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ������ ȸ��
		
		REVOKE SELECT ON C##KH.EMPLOYEE FROM TEST;	
*/

/*
	ROLE : Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
		- CONNECT : ���� ���� (CREATE SESSION)
		- RESOURCE : �ڿ� ����. Ư�� ��ü ���� ����
						(CRAETE TABLE, CREATE SEQUENCE, ...)
*/

-- �� ���� ��ȸ
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('SET');

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');						
------------------------------------------------------------------------------------------------------
/*
	TCL (Transaction Control Language)
	- Ʈ�����
		�� �����ͺ��̽��� ���� �������
		�� �������� ������׵�(DML ��� ��)�� �ϳ��� ����ó�� Ʈ����ǿ� ��Ƶ�
		�� DML�� �� ���� ������ �� Ʈ������� �����ϸ� �ش� Ʈ����ǿ� ��Ƽ� ���� ó��
								Ʈ������� �������� ������ Ʈ������� ���� ����
		�� COMMIT ����ϱ� �������� ������׵��� �ϳ��� Ʈ��������� ��� ��
			�� Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML)
			
	- Ʈ����� ����
		COMMIT; : ������� ����. Ʈ����ǿ� ����� �ִ� ������׵��� ���� DB�� �����ϰڴٴ� �ǹ�
		ROLLBACK : ������� ���. Ʈ����ǿ� ����� �ִ� ������׵��� ����(���)�ϰ�, ������ COMMIT �������� ���ư�
		SAVEPOINT ����Ʈ��; (�ѽ�����) : ���� ������ ������׵��� �ӽ÷� �����صδ� ���� �ǹ�
										ROLLBACK �� ��ü ������׵��� ��� �������� �ʰ�, �ش� ��ġ������ ��Ұ� ����! (ROLLBACK TO ����Ʈ��;)
*/
-- EMP01 ���̺����
DROP TABLE EMP01;

-- EMP01 ���̺� ���� EMPLOYEE ���̺��� ���, �����, �μ��� ������ ����
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
-- ����� 208, 209, 210�� ����
DELETE FROM EMP01
WHERE EMP_ID IN (208, 209, 210);
SAVEPOINT SP; -- SP��� �̸����� ������ �ӽ÷� ����

INSERT INTO EMP01 VALUES(500, 'ȫ�浿', '�λ������');
INSERT INTO EMP01 VALUES(211, '������', '���������');

-- ����� 211���� ����� ����
DELETE FROM EMP01 WHERE EMP_ID = 211;

ROLLBACK TO SP;

SELECT * FROM EMP01 ORDER BY EMP_ID;
DELETE FROM EMP01 WHERE EMP_ID = 221;

CREATE TABLE TEST (
	TID NUMBER
);

ROLLBACK;
-- DDL�� ����ϰ� �Ǹ� ���� Ʈ����ǿ� ����� ������׵��� ������ �ݿ���















