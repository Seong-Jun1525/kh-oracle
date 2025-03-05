/*
	GROUP BY ��
	�� �׷� ������ ������ �� �ִ� ����
	�� ���� ���� ������ �ϳ��� �׷����� ��� ó���ϴ� �������� ���
*/

-- ��ü ����� �� �޿� ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEE;

-- �μ��� �� �޿� ��ȸ
SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999') AS "�޿� �� ��"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �μ��� ��� �� ��ȸ
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �μ��ڵ尡 'D1', 'D6', 'D9'�� �� �μ��� �޿� ����, ��� �� ��ȸ
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "�޿� �� ��", COUNT(*) AS "�����"
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1', 'D6', 'D9')
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- �� ���� �� �� �����, ���ʽ��� �޴� ��� ��, �޿� ��, ��� �޿�, ���� �޿�, �ְ� �޿�
-- ���� �ڵ� ���� ���� ����
SELECT JOB_CODE, COUNT(*) AS "�� �����",
	COUNT(BONUS) AS "���ʽ��� �޴� ��� ��",
	TO_CHAR(SUM(SALARY), 'L999,999,999') AS "�޿� ��", 
	TO_CHAR(ROUND(AVG(SALARY)), 'L999,999,999') AS "��ձ޿�",
	TO_CHAR(MIN(SALARY), 'L999,999,999') AS "���� �޿�",
	TO_CHAR(MAX(SALARY), 'L999,999,999') AS "�ְ� �޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- ���� �����, ���� ��� �� ��ȸ
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') AS "����", COUNT(*) AS "�����"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- �μ� ���� ���޺� �����, �޿� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*) AS "�����", TO_CHAR(SUM(SALARY), 'L999,999,999') AS "�޿� ����"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- �μ��ڵ� �������� �׷�ȭ�ϰ�, �׷� ������ �����ڵ� �������� ���α׷�ȭ�� ��
ORDER BY DEPT_CODE;

-- ==============================================================
/*
	WHERE ���� �׷�ȭ �ϱ� ���� ���ǽ� ��

	HAVING ��
	�� �׷쿡 ���� ������ ������ �� ����ϴ� ����(����, �׷��Լ����� ����Ͽ� ������ �ۼ���)

*/
-- �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE, TO_CHAR(ROUND(AVG(SALARY))) AS "��� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��� ��ȸ
SELECT DEPT_CODE, TO_CHAR(ROUND(AVG(SALARY))) AS "��� �޿�"
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, TO_CHAR(ROUND(AVG(SALARY))) AS "��� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) >= 3000000;

-- �μ����� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

SELECT BONUS FROM EMPLOYEE WHERE DEPT_CODE = 'D2';