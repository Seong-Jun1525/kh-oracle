/*
	* �������� (SUBQUERY)
	- �ϳ��� ������ ���� ���Ե� �� �ٸ� ������
	- ���� ������ �ϴ� �������� ���� ���� ������ �ϴ� ������
*/
-- "���ö" ����� ���� �μ��� ���� ��� ������ ��ȸ
-- 1) ���ö ����� �μ��ڵ带 ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 D9�� ��� ����
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (
	SELECT DEPT_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME = '���ö'
);
	
-- ��ü ����� ��� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY > (
	SELECT ROUND(AVG(SALARY))
	FROM EMPLOYEE
);
-- =============================================================================
/*
	* ���������� ����
	- ���������� ������ ������� �� �� �� ���� �����Ŀ� ���� �з�
	
	- ������ �������� : ���������� ����� ������ 1���� �� (1�� 1��)
	- ������ �������� : ���������� ����� ���� ���� �� (N�� 1��)
	- ���߿� �������� : ���������� ����� �� ���̰� ���� ���� �� (1�� N��)
	-- ������ ���߿� �������� : ���������� ����� ���� �� ���� ���� �� (N�� N��)
	
	�� ������ ���� �������� �տ� �ٴ� �����ڰ� �޶���
*/
-- ������ ��������
-- �� �Ϲ����� �񱳿����� ��� ����

-- �� ����� ��� �޿����� �� ���� �޿��� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME AS "�����", JOB_CODE AS "�����ڵ�", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�"
FROM EMPLOYEE
WHERE SALARY < (
	SELECT ROUND(AVG(SALARY))
	FROM EMPLOYEE
);

-- �޿��� ���� ���� ����� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME AS "�����", JOB_CODE AS "�����ڵ�", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�"
FROM EMPLOYEE
WHERE SALARY = (
	SELECT MIN(SALARY)
	FROM EMPLOYEE
);
--WHERE SALARY = MIN(SALARY) -- �̷������� ������ �� �� ����
/*
	ORA-00934: �׷� �Լ��� �㰡���� �ʽ��ϴ�
	00934. 00000 -  "group function is not allowed here"
*/

-- ���ö ����� �޿����� ���� �޴� ����� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME AS "�����", DEPT_CODE AS "�μ��ڵ�", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�"
FROM EMPLOYEE
WHERE SALARY > (
	SELECT SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '���ö'
);

-- �μ��ڵ带 �μ������� ��ȸ�ϰ��� �Ѵٸ�?
-- ����Ŭ ����
SELECT EMP_NAME AS "�����", DEPT_TITLE AS "�μ��ڵ�", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND SALARY > (
	SELECT SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '���ö'
);

-- ANSI ����
SELECT EMP_NAME AS "�����", DEPT_TITLE AS "�μ��ڵ�", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�"
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (
	SELECT SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '���ö'
);

-- �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) AS "�޿���"
FROM EMPLOYEE
GROUP BY DEPT_CODE;