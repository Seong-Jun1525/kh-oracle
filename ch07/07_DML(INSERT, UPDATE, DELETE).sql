/*
	DQL (DATA QUERY LANGUAGE) 				: SELECT
	DML (DATA MANIPULATION LANGUAGE) 		: INSERT, UPDATE, DELETE
	DDL (DATA DEFINITION LANGUAGE)			: CREATE, ALTER, DROP
	DCL (DATA CONTROL LANGUAGE)				: GRANT, REVOKE
	TCL (TRANSACTION CONTROL LANGUAGE)	: COMMIT, ROLLBACK
*/
--==========================================================================================================
/*
	DML ������ ���� ���
	- ���̺� �����͸� �߰��ϰų� (INSERT),
		�����ϰų�(UPDATE),
		����(DELETE)�ϱ� ���� ����ϴ� ���
*/
-- INSERT : ���̺� ���ο� ���� �߰��ϴ� ����
/*
	[ǥ����]
		(1) INSERT INTO ���̺�� VALUES(��1, ��2, ...);
			�� ���̺� ��� �÷��� ���� ���� ���� �����Ͽ� �� ���� �߰��ϰ��� �� �� ���
			�� �÷� ������ �°� VALUES�� ���� �����ؾ���(�ش� �÷��� �´� ������Ÿ������ �����ؾ���)
			* ���� �����ϰ� �������� ��� �� NOT ENOUGH VALUE ���� �߻�
			* ���� �� ���� �������� ��� �� TOO MANY VALUES ���� �߻�
*/
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE VALUES (900, '������', '990307-2000000', 'my_u220@kh.or.kr', '01012344567', 'D4', 'J4', 3000000, 0.3,  NULL, SYSDATE, NULL, 'N');
/*
	(2) INSERT INTO ���̺�� (�÷���1, �÷���2, �÷���3) VALUES (��1, ��2, ��3);
	
	���õ��� ���� �÷��� ���� ���� �⺻������ NULL���� ����ǰ� NULL���� �ƴ� �ٸ� ������ �����ϰ��� �� ���� �⺻�� �ɼ��� �����ϸ� �ȴ�.
	
	���õ��� ���� �÷��� NOT NULL ���������� �ִٸ�, �ݵ�� ���� ���� �����Ͼ־� �� �Ǵ� �⺻�� �ɼ��� �߰��ؾ���
*/
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
					VALUES (901, '����Ŭ', '880707-1000000', 'oracle00@or.kr', 'J7');
SELECT * FROM EMPLOYEE;

/*
	(3) INSERT INTO ���̺�� (��������);
	�� VALUES ���� ���� ����ϴµ���
		���������� ��ȭ�� ������� ��ä�� INSERT �ϴ� ���( ���� �� �߰��ϴ� ���	
*/
CREATE TABLE EMP01 (
	EMP_ID NUMBER,
	EMP_NAME VARCHAR2(20),
	DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP01;

-- ��ü ����� ���, �����, �μ��� ��ȸ
-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
	
-- ORACLE	
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

INSERT INTO EMP01 (
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE
	FROM EMPLOYEE, DEPARTMENT
	WHERE DEPT_CODE = DEPT_ID(+)
);

/*
	(4) INSERT ALL
	- �� �� �̻��� ���̺� ���� �����͸� �߰��� �� ���Ǵ� ���������� ������ ��� ����ϴ� ���
	
	INSERT ALL 
		INTO ���̺��1 VALUES (�÷���, �÷���, ...)
		INTO ���̺��2 VALUES (�÷���, �÷���, ...)
		��������;
*/
-- EMP_DEPT ���̺� : ���, �����, �μ��ڵ� �Ի���
CREATE TABLE EMP_DEPT AS (
	SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
	FROM EMPLOYEE
	WHERE 1 = 0  -- �ƹ��ǹ̾��� ������ �༭ FALSE�� �������� �� �� ������ ���� �÷������� �����ϱ� ���� ���!!!
);

SELECT * FROM EMP_DEPT;

CREATE TABLE EMP_MANAGE AS (
	SELECT EMP_ID, EMP_NAME, MANAGER_ID
	FROM EMPLOYEE
	WHERE 1 = 0
);

SELECT * FROM EMP_MANAGE;

-- �μ��ڵ尡 'D1'�� ����� ���, �����, �μ��ڵ�, ������, �Ի��� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

INSERT ALL
	INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
	INTO EMP_MANAGE VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
(
	SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
	FROM EMPLOYEE
	WHERE DEPT_CODE = 'D1'
);
--==========================================================================================================
/*
	UPDATE : ���̺� ����Ǿ� �ִ� ������ ������ ���� �����ϴ� ����
	
	�� UPDATE Ȥ�� DELETE�� �ϱ� ������ �׻� SELECT�� �����͸� Ȯ������!!
	
	[ǥ����]
		UPDATE ���̺�� 
			SET �÷��� = ������ ��,
				�÷��� = ������ ��,
				...
		[WHERE ���ǽ�];
		
		�� SET ������ ���� ���� �÷� ���� ���ÿ� ������ �� �ְ� �޸��� �����Ͽ� �����Ѵ�
		�� WHERE ���� �������� ��� ���̺��� �ش� �÷��� ��� �����Ͱ� ����ȴ� !!!
	
	�����͸� ������ �� ���������� �� Ȯ���ؾ� ��!!!	
		
*/
-- DEPT_TABLE�̶�� ���̺� DEPARTMENT ���̺��� ����(����������)
CREATE TABLE DEPT_TABLE AS (
	SELECT * FROM DEPARTMENT
);
SELECT * FROM DEPT_TABLE;

-- �μ��ڵ尡 'D1'�� �μ��� �μ����� '�λ���'���� ����
UPDATE DEPT_TABLE
	SET DEPT_TITLE = '�λ���'
WHERE DEPT_ID = 'D1';

SELECT * FROM DEPT_TABLE;

-- �μ��ڵ尡 'D9'�� �μ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_TABLE
	SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_TABLE;

-- ������̺��� EMP_TABLE�� ���, �̸�, �μ��ڵ�, �޿�, ���ʽ� ������ ���� ������ ����!!
CREATE TABLE EMP_TABLE AS (
	SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
	FROM EMPLOYEE
);

SELECT * FROM EMP_TABLE;

-- ����� 900�� ����� �޿��� 400�������� �λ�(����)
UPDATE EMP_TABLE
	SET SALARY = 4000000
WHERE EMP_ID = 900;

SELECT * FROM EMP_TABLE WHERE EMP_ID = 900;

-- ���ȥ ����� �޿��� 500����, ���ʽ��� 0.2�� ����
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '���ȥ';

UPDATE EMP_TABLE
	SET SALARY = 5000000,
		BONUS = 0.2
WHERE EMP_NAME = '���ȥ';	
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '���ȥ';

-- ��ü ����� �޿��� ���� �޿��� 10% �λ�
UPDATE EMP_TABLE
	SET SALARY = SALARY * 1.1;
	
SELECT * FROM EMP_TABLE;
--==========================================================================================================
/*
	UPDATE���� �������� ����
	
	[ǥ����]
		UPDATE ���̺��
			SET �÷��� = (��������)
		[WHERE ���ǽ�];	
*/
-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ� ���� �����ϰ� ����
SELECT * FROM EMP_TABLE WHERE EMP_NAME IN ('����', '�����');

UPDATE EMP_TABLE
	SET (SALARY, BONUS) = (
		SELECT SALARY, BONUS
		FROM EMP_TABLE
		WHERE EMP_NAME = '�����'
	)
WHERE EMP_NAME = '������';

SELECT * FROM EMP_TABLE WHERE EMP_NAME IN ('����', '������', '�����');

-- ASIA �������� �ٹ� ���� ������� ���ʽ��� 0.3���� ����

-- [1] ASIA ������ ���� ����
SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE 'ASIA%';

-- [2] ASIA ������ �μ� ����
SELECT *
FROM DEPARTMENT
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

-- [3] ASIA ������ �μ��� ���� ��� ���� ��ȸ (���)
SELECT EMP_ID
FROM EMP_TABLE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';

-- ������ ��������

UPDATE EMP_TABLE
	SET BONUS = 0.3
WHERE EMP_ID IN (
	SELECT EMP_ID
	FROM EMP_TABLE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	WHERE LOCAL_NAME LIKE 'ASIA%'
);

SELECT * FROM EMP_TABLE;

COMMIT;
--==========================================================================================================
/*
	DELETE : ���̺� ����Ǿ� �ִ� �����͸� ������ �� ����ϴ� ����
	
	[ǥ����]
		DELETE FROM ���̺��
		[WHERE ���ǽ�];	
*/

DELETE FROM EMPLOYEE; -- ���� DB�� �ݿ��Ǵ� ���� �ƴ� �� ROLLBACK�� �Ͽ� �ǵ��� �� ���� ������ �ٸ� �۾��� �ϰ� Ŀ���� �ϸ� ������ Ŀ�� �������� ���ư�..
ROLLBACK;

DELETE FROM EMPLOYEE WHERE EMP_ID = 901;
DELETE FROM EMPLOYEE WHERE EMP_NAME = '������';

SELECT * FROM EMPLOYEE;
COMMIT;

-- �ܷ�Ű�� �����Ǿ� �ִ� ��� ������� �����Ͱ� ���� �� ���� �Ұ�!

/*
	TRUNCATE :
	- ���̺��� ��ü �����͸� ������ �� ���Ǵ� ����
	- DELETE���� ����ӵ��� ������
	- ������ ������ ������ �� ���� ROLLBACK�� �Ұ��ϴ� (�ǵ��� �� ����)
	
	TRUNCATE TABLE ���̺��
*/