/*
	SELECT : ������ ��ȸ
	�� DQL�� �з��ȴ�. DML�� �Բ� ���� ��찡 ������ ��Ȯ�� �з��� DQL�� �з��ؾ��Ѵ�.
	
	[ǥ����]
	SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��;
	
	�� ���� ���� FROM���� Ȯ���ϰ� ���� �÷����� ��ȸ�Ѵ�.

	RESULT SET : �����͸� ��ȸ�� ���
*/

-- ��� ����� ������ ��ȸ
SELECT * FROM EMPLOYEE;

-- ��� ����� �̸�, �ֹι�ȣ, �ڵ��� ������ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;
-- �� EMPLOYEE ���̺� ��ȸ �� EMP_NAME, EMP_NO, PHONE �÷��� ���� �����͸� ����

-- ��� ���޿� ���� ����
SELECT * FROM JOB;

-- ���޸� ��ȸ
SELECT JOB_NAME FROM JOB; 

-- ������̺��� ��� ����� �̸�, �̸���, ����ó, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE,  SALARY
FROM EMPLOYEE;

/*
	�÷��� ��� ���� �߰��ϱ�
	�� SELECT ���� �÷��� �ۼ��κп� ��� ������ �� �� ����
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
-- DATEŸ�� - DATEŸ�� �� �� ������ ǥ�õ�

/*
	���ͷ� (�� ��ü) : ���Ƿ� ������ ���� ���ڿ�('' <- ���ڳ� ��¥�� ǥ���� �� ���)�� ǥ�� �Ǵ� ���ڷ� ǥ��
	�� SELECT ���� ����ϴ� ��� ��ȸ�� ���(RESULT SET)�� �ݺ������� ǥ�õ�
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

SELECT DISTINCT JOB_CODE, DEPT_CODE -- JOB_CODE, DEPT_CODE�� �� ������ ��� �ߺ� ���� �� ���� ���޿� ���� ��å�� ��쿡 �ش�
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
		�� �ش� �÷��� ���� �ּڰ� �̻��̰� �ִ� ������ ���
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

-- ==============================================================

/*
	LIKE : ���ϰ��� �ϴ� �÷��� ���� ������ Ư¡ ���Ͽ� ������ ��� ��ȸ
	
	�� Ư�� ���� : '%', '_'�� ���ϵ�ī��� ���
		[ǥ����] �񱳴���÷� LIKE '����'
		�� % : 0���� �̻�
			EX) �񱳴���÷� LIKE '����%' �� �񱳴���÷��� ���� ���ڷ� "����"�Ǵ� ���� ��ȸ
			EX) �񱳴���÷� LIKE '%����' �� �񱳴���÷��� ���� ���ڷ� "��"���� ���� ��ȸ
			EX) �񱳴���÷� LIKE '%����%' �� �񱳴���÷��� ���� ���ڰ� "����"�Ǵ� ���� ��ȸ �� Ű���� �˻�!
			
		�� _ : 1����
			EX) �񱳴���÷� LIKE '_����' �� �񱳴���÷��� ������ ���� �տ� ������ �� ���ڰ� ���� ��츦 ��ȸ 
			EX) �񱳴���÷� LIKE '__����' �� �񱳴���÷��� ������ ���� �տ� ������ �� ���ڰ� ���� ��츦 ��ȸ
			EX) �񱳴���÷� LIKE '_����_' �� �񱳴���÷��� ������ ���� ��, �ڷ� ������ �� ���ھ� ���� ��츦 ��ȸ
		
*/

-- ����� �߿� "��"�� ���� ���� ����� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", HIRE_DATE AS "�Ի���"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ����� "��"�� ���Ե� ����� �����, �ֹι�ȣ, ����ó ��ȸ
SELECT EMP_NAME AS "�����", EMP_NO AS "�ֹι�ȣ", PHONE AS "����ó"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ������� ��� ���ڰ� "��"�� ����� �����, ����ó ��ȸ( ������� 3������ ����� �� ��ȸ)
SELECT EMP_NAME AS "�����", PHONE AS "����ó"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ����� �� ����ó�� 3��° �ڸ��� 1�� ����� ���, �����, ����ó, �̸��� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�����", PHONE AS "����ó", EMAIL AS "�̸���"
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ����� �� �̸��Ͽ� 4��° �ڸ��� _�� ����� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�̸�", EMAIL AS "�̸���"
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- �� ���ϵ� ī��� ���Ǵ� ���ڿ� �÷��� ��� ���ڰ� �����ϱ� ������ ��� ���ϵ�ī��� �νĵ�
-- �� ������ ���ϵ� ī�带 ����ؾ��� ESCAPE �ɼ� �߰�!

SELECT EMP_ID AS "���", EMP_NAME AS "�̸�", EMAIL AS "�̸���"
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
-- �� ������ ���ϵ� ī��� ���� ���ϵ�ī�带 ���ڷ� �νĵǰ� �ϴ� �� ��

-- ==============================================================
/*
	IS NULL / IS NOT NULL
	- �÷� ���� NULL�� �ִ� ��� NULL���� ���� �� ���Ǵ� ������
	
	- IS NULL : �÷����� NULL ����
	- IS NOT NULL : �÷����� NULL�� �ƴ���
	
*/

-- ���ʽ��� ���� �ʴ� ������� ���, �����, �޿�, ���ʽ� ��ȸ �� ���ʽ��� ���� �ʴ� ����� ã�� ��!
SELECT EMP_ID AS "���", EMP_NAME AS "�����", SALARY AS "�޿�", BONUS AS "���ʽ�"
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ������� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�����", SALARY AS "�޿�", BONUS AS "���ʽ�"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; -- �̷��Ե� �����ϴ�

-- ����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME AS "�����", MANAGER_ID AS "������", DEPT_CODE AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- �μ� ��ġ�� ���� �ʾ�����, ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME AS "�����", BONUS AS "���ʽ�", DEPT_CODE AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
-- ==============================================================
-- ���� �ڵ尡 'J7' �̰ų� 'J2'�� ����� �� �޿��� 200���� �̻��� ����� ��� ������ ��ȸ
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN('J7', 'J2') AND SALARY >= 2000000;

/*
	������ �켱����
		(0) () �Ұ�ȣ
		(1) ��������� : * / + -
		(2) ���Ῥ���� : ||
		(3) �񱳿����� : > < <= >= = != <> ^=
		(4) IS NULL / LIKE '����' / IN
		(5) BETWEEN - AND -
		(5) NOT
		(6) AND
		(7) OR
*/
-- ==============================================================
/*
	���� : ORDER BY
	�� SELECT ������ ���� ������ �ٿ� �ۼ�
	�� ���� ���� ���� ���� �������� ����
	
	[ǥ����]
	SELECT ��ȸ�� �÷�, ...
	FROM ���̺��
	WHERE ����
	ORDER BY ���ı����̵Ǵ��÷� | ��Ī | �÷����� [ASC | DESC] [NULLS FIRST | NULLS LAST]
	(�� ���� �������� ����Ǳ� ������ ��Ī�� ����� �� �ְ� �÷������� ����� �� �ִ�)
	
	ASC : �������� - �⺻��
	DESC : ��������
	
	NULLS FIRST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �տ� ��ġ (DESC�� ��쿡 �⺻��)
	NULLS LAST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �ڿ� ��ġ(ASC�� ��쿡 �⺻��)
	
*/

-- ��� ����� �����, ���� ��ȸ (������ �������� ����)
SELECT EMP_NAME AS "�����", (SALARY * 12) AS "����"
FROM EMPLOYEE
-- ORDER BY SALARY * 12 DESC;
ORDER BY ���� DESC;
-- ORDER BY 2 DESC;

-- ORACLE�� ������ 1���� ����!

-- ���ʽ� �������� ����
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS; -- �⺻�� ASC �� ASC�� ��� NULLS LAST�� �⺻��
ORDER BY BONUS DESC, SALARY; -- �� BONUS�� ���� �����ϴµ� ���� ���� ��� SALARY �������� �������� �����Ѵ�


















