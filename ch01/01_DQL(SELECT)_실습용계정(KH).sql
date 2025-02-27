/*
	SELECT : ������ ��ȸ
	
	[ǥ����]
	SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��;

	RESULT SET : �����͸� ��ȸ�� ���
*/

-- ��� ����� ������ ��ȸ
SELECT * FROM EMPLOYEE;

-- ��� ����� �̸�, �ֹι�ȣ, �ڵ��� ������ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;
-- => EMPLOYEE ���̺� ��ȸ -> EMP_NAME, EMP_NO, PHONE �÷��� ���� �����͸� ����

-- ���� ���� FROM���� Ȯ���ϰ� ���� �÷����� ��ȸ�Ѵ�.

-- ��� ���޿� ���� ����
SELECT * FROM JOB;

-- ���޸� ��ȸ
SELECT JOB_NAME FROM JOB; 

-- ������̺��� ��� ����� �̸�, �̸���, ����ó, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE,  SALARY
FROM EMPLOYEE;

/*
	�÷��� ��� ���� �߰��ϱ�
	=> SELECT ���� �÷��� �ۼ��κп� ��� ������ �� �� ����
*/

-- �����, ���� ���� ��ȸ
SELECT EMP_NAME AS �����, (SALARY * 12) AS ����
FROM EMPLOYEE;

-- �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ������ ��ȸ
SELECT EMP_NAME AS �����, SALARY AS �޿�, (SALARY * 12) AS ����, BONUS AS ���ʽ�, ((SALARY + (SALARY * BONUS)) * 12) AS "���ʽ� ���� ����"
FROM EMPLOYEE;

/*
	�÷��� ��Ī �ο��ϱ�
	- ������� ����� ��� �ǹ̸� �ľ��ϱ� ��Ʊ� ������ ��Ī�� �ο��Ͽ� ��Ȯ�ϰ� ����ϰ� ��ȸ�� �� �ִ�.
	
	[ǥ����]
		(1) �÷��� ��Ī
		(2) �÷��� AS ��Ī
		(3) �÷��� "��Ī"
		(4) �÷��� AS "��Ī"
*/
SELECT EMP_NAME AS �����, SALARY AS �޿�, BONUS AS ���ʽ�, (SALARY * 12) AS ����, ((SALARY + (SALARY * BONUS)) * 12) AS "���ʽ� ���� ����"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

/*
	- ���� ��¥ �ð� ���� : SYSDATE
	- �������̺�(�ӽ����̺�) : DUAL
*/

SELECT SYSDATE FROM DUAL; -- YY/MM/DD �������� ��ȸ��

-- ��� ����� �����, �Ի���, �ٹ��ϼ� ��ȸ
-- �ٹ��ϼ� = ���糯¥ - �Ի��� + 1
SELECT EMP_NAME AS "�����", HIRE_DATE AS "�Ի���", (SYSDATE - HIRE_DATE + 1) AS "�ٹ��ϼ�"
FROM EMPLOYEE;
-- DATEŸ�� - DATEŸ�� => �� ������ ǥ�õ�

/*
	���ͷ� (�� ��ü) : ���Ƿ� ������ ���� ���ڿ�('' <- ���ڳ� ��¥�� ǥ���� �� ���)�� ǥ�� �Ǵ� ���ڷ� ǥ��
	=> SELECT ���� ����ϴ� ��� ��ȸ�� ���(RESULT SET)�� �ݺ������� ǥ�õ�
*/
-- �����, �޿�, '��' ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", '��' AS "��"
FROM EMPLOYEE;

/*
	���� ������ : ||
	�� ���� �÷� �Ǵ� ���� �÷��� �������ִ� ������
*/
-- XXX�� �������� �޿� ������ ��ȸ
SELECT SALARY || '��' AS "�޿�"
FROM EMPLOYEE;

-- ���, �̸�, �޿��� �� ���� ��ȸ
SELECT (EMP_ID || '  ' || EMP_NAME || '  ' || SALARY) AS "��� ����"
FROM EMPLOYEE;

-- "XXX�� �޿��� XXXX�� �Դϴ�." �������� ��ȸ
SELECT (EMP_NAME || '�� �޿��� ' || SALARY || '�� �Դϴ�.') AS "�޿�����"
FROM EMPLOYEE;

/*
	�ߺ� ���� : DISTINCT
	�ߺ��� ������� ���� ��� ��ȸ ����� �ϳ��� ǥ������
	
	SELECT ������ DISTINCT�� �ѹ��� �����ϴ�
*/
-- ������̺��� �ߺ����� ��å�ڵ� ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- ������̺��� �μ��ڵ� �ߺ����� ��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT DISTINCT JOB_CODE, DEPT_CODE -- JOB_CODE, DEPT_CODE�� �� ������ ��� �ߺ� ���� => ���� ���޿� ���� ��å�� ��쿡 �ش�
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

-- ==============================================================
/*
	WHERE ��
	- ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����ϰ��� �� �� ���
	
	[ǥ����]
		SELECT �÷���, �÷� �Ǵ� ������ ���� �����
		FROM ���̺� ��
		[WHERE ����]
		
	- �񱳿�����
		��Һ� : > < >= <=
		�����
			- ���� �� �� : =
			- �ٸ� �� �� : != <> ^=
*/
-- ������̺��� �μ��ڵ尡 'D9'�� ������� ������ ��ȸ
SELECT * 							-- (3)
FROM EMPLOYEE					-- (1)
WHERE DEPT_CODE = 'D9';			-- (2)

-- ��� ���� �� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ带 ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", DEPT_CODE AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- ��� ���� �� �μ��ڵ尡 'D1'�� �ƴ� ������� �����, �޿�, �μ��ڵ带 ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", DEPT_CODE AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE DEPT_CODE<> 'D1';
-- WHERE DEPT_CODE ^= 'D1';
-- WHERE DEPT_CODE != 'D1';

-- �޿��� 4000000 �̻��� ������� �����, �μ��ڵ�, �޿������� ��ȸ
SELECT EMP_NAME AS "�����", DEPT_CODE AS "�μ��ڵ�", SALARY AS "�޿�����"
FROM EMPLOYEE
WHERE SALARY >= 4000000;


-- �޿��� 4000000 �̸��� ������� �����, �μ��ڵ�, �޿������� ��ȸ
SELECT EMP_NAME AS "�����", DEPT_CODE AS "�μ��ڵ�", SALARY AS "�޿�����"
FROM EMPLOYEE
WHERE SALARY < 4000000 AND DEPT_CODE IS NOT NULL;

-- ==============================================================
-- ���� ��� �� ���ʽ� ����
-- ��� ��Ī ����

-- [1] �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", HIRE_DATE AS "�Ի���", (SALARY * 12) AS "����"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- [2] ������ 5õ���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", (SALARY * 12) AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY * 12) >= 50000000;

-- [3] �����ڵ尡 'J5'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_ID AS "�����ȣ", EMP_NAME AS "�����", JOB_CODE AS "�����ڵ�", ENT_YN AS "��翩��"
FROM EMPLOYEE
WHERE JOB_CODE <> 'J5';

-- [4] �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ
--	�� ������ : AND, OR�� ���� ������ �� ����
SELECT EMP_NAME AS "�����", EMP_ID AS "�����ȣ", SALARY AS "�޿�"
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000;

/*
	[ǥ����]
		BETWEEN A AND B
		- �÷��� : �� ��� �÷�
		- A : �ּڰ�
		- B : �ִ�
		==> �ش� �÷��� ���� �ּڰ� �̻��̰� �ִ� ������ ���
*/

SELECT EMP_NAME AS "�����", EMP_ID AS "�����ȣ", SALARY AS "�޿�"
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

-- NOT ������
SELECT EMP_NAME AS "�����", EMP_ID AS "�����ȣ", SALARY AS "�޿�"
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

/*
	IN : �� ��� �÷��� ���� ������ ���� �߿� ��ġ�ϴ� ���� �ִ� ��츦 ��ȸ�ϴ� ����
	
	[ǥ����]
		�÷��� IN (��1, ��2, ...)
		�Ʒ��� ������
		�÷��� = ��1 OR �÷��� = ��2 OR ...
*/

-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� ������� �����, �μ��ڵ�, �޿��� ��ȸ
SELECT EMP_NAME AS "�����", DEPT_CODE AS "�μ��ڵ�", SALARY AS "�޿�"
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN('D6',  'D8', 'D5');


/*
SELECT DISTINCT 
	JOB_CODE
FROM EMPLOYEE;

-- WHERE��. ����� �����ڴ� = �̴�.
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� ���� ���� �ۼ� �� AND / OR ���
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 200000;
*/