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
	- ������ ���߿� �������� : ���������� ����� ���� �� ���� ���� �� (N�� N��)
	
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
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
	SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE
);

-- ������ ����� ���� �μ��� ������� ���, �����, ����ó, �Ի���, �μ����� ��ȸ
-- ��, ������ ����� �����ϰ� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE,  DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND EMP_NAME != '������' AND DEPT_CODE = (
	SELECT DEPT_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME = '������'
);

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME != '������' AND DEPT_CODE = (
	SELECT DEPT_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME = '������'
);
-- =============================================================================
/*
	������ �������� : �������� ����� ���� ���� ��� (N�� 1��)
	IN (��������) : ���� ���� ����� �߿� �ϳ��� ��ġ�ϴ� ���� ���� ��� ��ȸ
	
	�� > ANY (��������) : ���� ���� ����� �߿��� �ϳ��� ū ��찡 �ִٸ� ��ȸ
	�� < ANY (��������) : ���� ���� ����� �߿��� �ϳ��� ���� ��찡 �ִٸ� ��ȸ
	
	�� > ALL (��������) : ���� ���� ��� ��������� ū ��찡 �ִٸ� ��ȸ
	�� < ALL (��������) : ���� ���� ��� ��������� ���� ��찡 �ִٸ� ��ȸ
*/
-- ����� ��� �Ǵ� ������ ����� ���� ������ ������� ���� ��ȸ (���, �����, �����ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (
	SELECT JOB_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME IN ('�����', '������')
);

-- �븮������ ����� �� ���� ������ �޿����� ���� �޴� ��� ������ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
	JOIN JOB USING(JOB_CODE) 
WHERE JOB_NAME = '�븮' AND SALARY > ANY (
	SELECT SALARY
	FROM EMPLOYEE
		JOIN JOB USING (JOB_CODE)
	WHERE JOB_NAME = '����'
);
-- =============================================================================
/*
	���߿� �������� : �������� ����� 1�� ���̰�, ���� ���� ���� ���
*/
-- ������ ����� ���� �μ�, ���� ������ ��� ������ ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- ������ ���������� ����Ѵٸ�
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (
	SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������'
) AND JOB_CODE = (
	SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������'
);

-- ���߿� ���������� ����Ѵٸ�?
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
	SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������'
);

-- �ڳ��� ����� ������ ����, ����� ������ ����� �����, �����ڵ�, �����ȣ�� ��ȸ
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME <>  '�ڳ���' AND (JOB_CODE, MANAGER_ID) = (
	SELECT JOB_CODE, MANAGER_ID
	FROM EMPLOYEE
	WHERE EMP_NAME = '�ڳ���'
);

-- =============================================================================
/*
	������ ���߿� �������� : ���������� ����� ���� ��, ���� ���� ���
*/
-- �� ���޺��� �ּұ޿��� �޴� ��� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
	SELECT JOB_CODE, MIN(SALARY)
	FROM EMPLOYEE
	GROUP BY JOB_CODE
)
ORDER BY JOB_CODE;

-- =============================================================================
/*
	�ζ��� �� : ���������� FROM ���� ����ϴ� ��
		�� ���������� ����� ��ġ ���̺�ó�� ����ϴ� ��
*/
-- ���, �̸�, ���ʽ� ���� ����, �μ��ڵ带 ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�����", (SALARY + (NVL(BONUS, 0) * SALARY)) * 12 AS "���ʽ� ���� ����", DEPT_CODE AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE ((SALARY + (NVL(BONUS, 0) * SALARY)) * 12) >= 30000000;

-- TOP-N �м�
-- �� ROWNUM ��ȸ�� �࿡ ���Ͽ� ������� 1���� ������ �ο����ִ� �����÷�
SELECT ROWNUM, "���", "�����", "���ʽ� ���� ����", "�μ��ڵ�" -- ��Ī�� ��������� ��Ī���� �ۼ�������Ѵ�
FROM (
	SELECT EMP_ID AS "���", EMP_NAME AS "�����", (SALARY + (NVL(BONUS, 0) * SALARY)) * 12 AS "���ʽ� ���� ����", DEPT_CODE AS "�μ��ڵ�"
	FROM EMPLOYEE
	WHERE ((SALARY + (NVL(BONUS, 0) * SALARY)) * 12) >= 30000000
	ORDER BY 3 DESC
)
WHERE ROWNUM <= 5;

-- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ
SELECT ROWNUM, EMP_ID, EMP_NAME, HIRE_DATE
FROM (
	SELECT EMP_ID, EMP_NAME, HIRE_DATE
	FROM EMPLOYEE
	ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;
-- ROWNUM�� ���� ������ �߰� ��ġ�� �ϰ��� �� ��� �ζ��� �信 �÷��� ���� �ۼ� �� ����ؾ� ��
-- =============================================================================
/*
	* ������ �ű�� �Լ�(WINDOW FUNCTION)
	- RANK() OVER (���� ����)			: ������ ���� ������ ����� ������ �� ��ŭ �ǳʶٰ� ���� ���
	- DENSE_RANK() OVER (���� ����) 		: ������ ������ �ִ��� �� ���� ����� +1�ؼ� ���� ���
	
	�� SELECT �������� ��� �����ϴ�!
*/
-- �޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999'), RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- ���� 19���� 2���� �ְ�, �� ���� ������ 21���� ǥ�õ�

SELECT EMP_NAME AS "�����", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�", DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- ���� 19���� 2���� �ְ�, �� ���� ������ 20���� ǥ�õ�

-- ���� 5�� ��ȸ
SELECT �����, �޿�, ����
FROM (
	SELECT EMP_NAME AS "�����", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�", DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
	FROM EMPLOYEE
)
WHERE ROWNUM <= 5;

-- ���� 3�� ~ 5��
SELECT *
FROM (
	SELECT EMP_NAME AS "�����", TO_CHAR(SALARY, 'L999,999,999') AS "�޿�", RANK() OVER(ORDER BY SALARY DESC) AS "����"
	FROM EMPLOYEE
)
WHERE ���� BETWEEN 3 AND 5;

-- =============================================================================
-- [1] ROWNUM�� Ȱ���Ͽ� �޿��� ���� ���� 5�� ��ȸ�Ϸ� ������ ����� ��ȸ���� �ʾҴ�.
/*
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

���� SELECT���� �������� �ذ����� �ۼ��Ͽ���
�� ������ : ROWNUM�� ���� ��ȣ�� �Ű��ִ� ���̴�.
		�̰��� �׳� �÷������� �ۼ��ϰԵǸ� �⺻������ ����Ǿ� �ִ� �÷��� �������� ����ǰ�
		�� �� SALARY�� �������� �������� ���������Ƿ� ����� ���۵��� �ʴ´�.
		
�� �ذ��� 
SELECT ROWNUM, EMP_NAME, SALARY
FROM (
	SELECT EMP_NAME, SALARY
	FROM EMPLOYEE
	ORDER BY SALARY DESC
)
WHERE ROWNUM <= 5;
�������� �� �ζ��� �並 Ȱ���Ͽ� SALARY�� �������� �������� ���ĵ� �����͸� ���̺�� Ȱ���ϰ� �װ��� ������� ROWNUM ������ �ָ� �ذ�ȴ�.

*/
SELECT ROWNUM, EMP_NAME, SALARY
FROM (
	SELECT EMP_NAME, SALARY
	FROM EMPLOYEE
	ORDER BY SALARY DESC
)
WHERE ROWNUM <= 5;

-- [2] �μ����� ��ձ޿��� 270������ �ʰ��ϴ� �μ��� �ش��ϴ� �μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� ��� ���� ��ȸ�Ϸ� ������ ����� ��ȸ�� ���� �ʾҴ�.
/*
SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���, COUNT(*) �����
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

���� SELECT���� �������� �ذ����� �ۼ��Ͽ���
�� ������ : WHERE ���� �׷�ȭ �ϱ� ������ ������ ���¿��� ������ �Ǻ��ϴ°ǵ� ��� �޿��� 270���� �ʰ��ϴ� ���� ã������ �׷�ȭ�� �Ŀ� ������ ����Ѵ�
�� �ذ��� : WHERE���� �ƴ� HAVING ���� ����ؾ��Ѵ�

SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���, COUNT(*) �����
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;
*/
SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���, COUNT(*) �����
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

-- �Ǵ�
SELECT *
FROM (
	SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���, COUNT(*) �����
	FROM EMPLOYEE
	GROUP BY DEPT_CODE
)
WHERE ��� > 2700000;