/*
	VIEW
	- SELECT ���� ���� ����� ������� �����ص� �� �ִ� ��ü
		�� ���� ���Ǵ� �������� �����صθ� �Ź� �ٽ� �ش� �������� ����� �ʿ䰡 ����
	- �ӽ����̺�� ���� ���� (���� �����͸� �����ϴ°� �ƴ϶�, �������θ� ����Ǿ� ����)
*/

-- �ѱ����� �ٹ��ϴ� ��� ���� ���, �̸�, �μ���, �޿�, �ٹ�������
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

-- ���þƿ��� �ٹ��ϴ� ��� ���� ���, �̸�, �μ���, �޿�, �ٹ�������
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-- �Ϻ����� �ٹ��ϴ� ��� ���� ���, �̸�, �μ���, �޿�, �ٹ�������
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';

/*
	VIEW ����
	CREATE VIEW ��� AS (��������);
*/

CREATE VIEW VW_EMPLOYEE AS (
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
		JOIN NATIONAL USING (NATIONAL_CODE)
);

-- �並 ������ �� �ִ� ������ �ο�
GRANT CREATE VIEW TO C##KH;

SELECT * FROM VW_EMPLOYEE;

-- �並 ����Ͽ� '�ѱ�'���� �ٹ����� ������� ��ȸ
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

-- �並 ����Ͽ� '���þ�'���� �ٹ����� ������� ��ȸ
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

-- �並 ����Ͽ� '�Ϻ�'���� �ٹ����� ������� ��ȸ
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';

SELECT * FROM USER_VIEWS;
-- TEXT �÷��� ����� �������� ������ ����

------------------------------------------------------------------------------------------------------
-- ���, �����, ���޸�, ����(��/��), �ٹ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') AS "����",EXTRACT(YEAR FROM  SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
FROM EMPLOYEE
	JOIN JOB USING(JOB_CODE);
	
-- ������ VW_EMP_JOB �信 ����
DROP VIEW VW_EMP_JOB;
CREATE VIEW VW_EMP_JOB (���, �̸�, ���޸�, ����, �ٹ����)
AS (
	SELECT
		EMP_ID, 
		EMP_NAME, 
		JOB_NAME, 
		DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��'),
		EXTRACT(YEAR FROM  SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
	FROM EMPLOYEE
		JOIN JOB USING(JOB_CODE)
);

SELECT * FROM VW_EMP_JOB;

-- ���� ��� ��ȸ
SELECT * FROM VW_EMP_JOB
WHERE ���� = '��';

-- 20�� �̻� �ٹ��� ��� ��ȸ
SELECT * FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

------------------------------------------------------------------------------------------------------
/*
	������ �並 ���ؼ� DML ���
	
	�並 ���ؼ� DML�� �ۼ��ϰ� �Ǹ�, ���� �����Ͱ� ����Ǿ� �ִ� ���̺� �ݿ�
*/
-- JOB ���̺��� ��� ����
CREATE VIEW VW_JOB AS (
	SELECT * FROM JOB
);
SELECT * FROM VW_JOB; -- ������ ���̺�

INSERT INTO VW_JOB VALUES ('J8', '����');

UPDATE VW_JOB
	SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';	

DELETE FROM VW_JOB WHERE JOB_CODE = 'J8';

SELECT * FROM JOB;
------------------------------------------------------------------------------------------------------
/*
	DML ��ɾ�� ������ �Ұ����� ��찡 ����!
	
	1) �信 ���ǵ��� ���� �÷��� �����Ϸ��� ���
	2) �信 ���ǵǾ� ���� �ʰ� ���̺� NOT NULL ���������� �����Ǿ� �ִ� ���
		�� �߰� ������ �� ������ �߻��� �� �ִ�!
	3) �������� �Ǵ� �Լ������� ���ǵǾ� �ִ� ���
	4) DISTINCT ������ ���ԵǾ� �ִ� ���
	5) JOIN�� �̿��Ͽ� ���� ���̺��� ������ ���
	
	�� ��� ��κ� ��ȸ�� �뵵�� ����Ѵ�. ���� �ǵ����̸� DML�� ������� ����!
*/
------------------------------------------------------------------------------------------------------
/*
	VIEW ���� �ɼ�
	
	CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���
	AS (��������)
	[WITH CHECK OPTION]
	[WITH READ ONLY]
	
	- OR REPLACE : ������ ������ �̸��� �䰡 ���� ��� �����ϰ�, ���� ��� ���� ������
	- FORCE | NOFORCE
		�� FORCE : ���������� �ۼ��� ���̺��� �������� �ʾƵ� �並 ����
		�� NOFORCE : ���������� �ۼ��� ���̺��� �����ϴ� ��쿡�� �並 ����(�⺻��)
		
	- WITH CHECK OPTION : DML ��� �� ���������� �ۼ��� ���ǿ� �´� �����θ� ����ǵ��� �ϴ� �ɼ�
	- WITH READ ONLY : �並 ��ȸ�� �����ϵ��� �ϴ� �ɼ� (�߰����ִ� ���� �����ϴ�)
*/

-- FORCE | NOFORCE
--DROP VIEW VW_TEMP;
CREATE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT FROM TT;
/*
ORA-00942: ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�
00942. 00000 -  "table or view does not exist"
*/
CREATE FORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT FROM TT;
SELECT * FROM VW_TEMP; -- Can also be a table which has references to non-existent or inaccessible types. �並 ���������� ���̺��� �������� �ʴ´ٴ� ���� �߻�!
CREATE TABLE TT (
	TCODE NUMBER,
	TNAME VARCHAR2(20),
	TCONTENT VARCHAR2(200)
);
-- �ǵ��� ���̺� ���� �� �並 ������!!

DROP VIEW VW_EMP;
-- WITH CHECK OPTION
-- �ɼǾ��� �޿��� 300���� �̻��� ��� ������ �� ����
CREATE VIEW VW_EMP AS (
	SELECT * FROM EMPLOYEE
	WHERE SALARY >= 3000000
);

SELECT * FROM VW_EMP;

-- 204�� ����� �޿��� 200�������κ���
UPDATE VW_EMP
	SET SALARY = 2000000
WHERE EMP_ID = 204;
ROLLBACK;

-- �ɼ� �����ؼ� �ٽ� ����
CREATE OR REPLACE VIEW VW_EMP AS (
	SELECT * FROM EMPLOYEE
	WHERE SALARY >= 3000000
)
WITH CHECK OPTION;


UPDATE VW_EMP
	SET SALARY = 2000000
WHERE EMP_ID = 204;
ROLLBACK;
/*
SQL ����: ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
01402. 00000 -  "view WITH CHECK OPTION where-clause violation"
*/
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_EMP AS (
	SELECT * FROM EMPLOYEE
	WHERE SALARY >= 3000000
)
WITH READ ONLY;

DELETE FROM VW_EMP WHERE EMP_ID = 200;
/*
SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.
42399.0000 - "cannot perform a DML operation on a read-only view"
*/




