/*
	ROLLUP, CUBE : �׷� �� ���� ��� ���� ���� ��� �Լ�
	
	�� ROLLUP : ���޹��� �׷� �� ���� ���� ������ �׷� ���� �߰��� ���� �����ȯ
	�� CUBE : ���޹��� �׷��� ������ ��� ���� �� ���� ��� ��ȯ
*/
-- �� �μ��� �μ��� ���޺� �޿���, �μ� �� �޿���, ��ü ���� �޿� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;
-- ==============================================================
/*
	���� ����
	SELECT ��ȸ�ϰ��� �ϴ� �÷� AS "��Ī" �Ǵ� * �Ǵ� �Լ��� �Ǵ� �����						5
	FROM ��ȸ�ϰ��� �ϴ� ���̺� �� �Ǵ� DUAL												1
	WHERE ���ǽ� (�����ڵ��� Ȱ���Ͽ� �ۼ�)												2
	GROUP BY �׷�ȭ ������ �Ǵ� �÷� �Ǵ� �Լ��� �Ǵ� �����								3
	HAVING ���ǽ�(�׷��Լ��� Ȱ���Ͽ� �ۼ�)												4
	ORDER BY �÷��� Ȥ�� �÷� ���� Ȥ�� ��Ī [ ASC | DESC] [NULLS LAST | NULLS FIRST]		6
	
	����Ŭ������ ���� 1���� ����!!
*/
-- ==============================================================
/*
	���� ������ : ���� ���� ��ɹ�(SQL�� / ������)�� �ϳ��� ��ɹ����� ������ִ� ������
	
	- UNION : ������ (�� ��ɹ��� ������ ��� ���� ������) ��  OR �����ڿ� ����
	- INTERSECT : ������ (�� ��ɹ��� ������ ��� ���� �ߺ��� �κ��� ��������) �� AND �����ڿ� ����
	- UNION ALL : ������ + ������ (�ߺ��Ǵ� �κ��� �ι� ��ȸ�� �� ����)
	- MINUS : ������ (���� ������� ���� ����� �� ������)
*/
-- ** UNION **
-- �μ� �ڵ尡 'D5'�� ��� �Ǵ� �޿��� 300������ �ʰ��ϴ� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 OR DEPT_CODE = 'D5';


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** INTERSECT **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 AND DEPT_CODE = 'D5';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** UNION ALL **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** MINUS **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

/*
	���� ������ ��� �� ���ǻ��� �ڡڡ�
	1) ��ɹ����� �÷� ������ �����ؾ� ��
	2) �÷� �ڸ����� ������ ������Ÿ������ �ۼ��ؾ���
	3) ������ �ϰ��� �� ��� ORDER BY ���� ��ġ�� ���� �������� �ۼ��ؾ���
	
	�� RESULT SET�� ���� �۾��ϱ� ����!!
*/