/*
	�ڡڡ� JOIN
	�� �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� ����
		��ȸ ����� �ϳ��� �����(Result Set)�� ����
	�� ������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺� ����
		�� �ߺ� ������ �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� ������
	�� ������ �����ͺ��̽����� �������� ����Ͽ� ���̺� ���� "����"�� �δ� ���
			(�� ���̺� ���� �����(�ܷ�Ű)�� ���ؼ� �����͸� ��Ī���� ��ȸ��)
	
	�� JOIN�� ũ�� "����Ŭ ���� ����"�� ANSI ����(ǥ��)"
			����Ŭ ���� ����			|				ANSI ����
		=====================================================
				� ����			|				���� ����
			   (EQUAL JOIN)			|			(INNER JOIN) �� JOIN ON / USING
	----------------------------------------------------------------------------------------------------
				���� ����			|			  ���� �ܺ� ����(LEFT OUTER JOIN)
			 (LEFT JOIN)				| 			������ �ܺ� ����(RIGHT OUTER JOIN)
			 (RIGHT JOIN)			|			��ü �ܺ� ����(FULL OUTER JOIN)
	----------------------------------------------------------------------------------------------------
			��ü ����(SELF JOIN)		|				JOIN ON
	�� ����(NON EQUAL JOIN)	|
	========================================================================
	
*/
-- ��ü ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- �μ� �������� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, ���� �ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

-- ���� �������� ���� �ڵ�, ���޸� ��ȸ
SELECT JOB_CODE, JOB_NAME
FROM JOB;
-- ==============================================================
/*
	* � ����(EQUAL JOIN) / ���� ����(INNER JOIN)
	- �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ (�� ��ġ���� �ʴ� ���� ������� ����)
*/
-- ORACLE ���� ����
/*
	- FROM ���� ��ȸ�ϰ��� �ϴ� ���̺��� ����(�޸�(,)�� ����)
	- WHERE ���� ��Ī��ų �÷��� ���� ������ �ۼ�
*/
-- ����� ���, �̸�, �μ����� ��ȸ
-- �� �μ��ڵ� �÷����� ����!
SELECT EMP_ID AS "���", EMP_NAME AS "�����", DEPT_TITLE AS "�μ���"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- �� ��ġ���� �ʴ� ������ ������� ���ܵ�
	-- EMPLOYEE ���̺����� DEPT_CODE ���� NULL�� ���
	-- DEPARTMENT ���̺����� EMPLOYEE ���̺� �������� �ʴ� ������
	-- �� �� ���̺����� �����ϴ� �����͵��� ���ܵ�

-- ����� ���, �����, ���޸��� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�����", JOB_NAME AS "���޸�", J.JOB_CODE AS "�����ڵ�"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE
-- ==============================================================
-- * ANSI ���� *
/*
	- FROM ���� ������ �Ǵ� ���̺� �ϳ� �ۼ�
	- JOIN ���� �����ϰ��� �ϴ� ���̺��� ��� + ��Ī��Ű���� �ϴ� ���� �ۼ�
		* JOIN ON : �÷����� ���ų� �ٸ���� �Ѵ� ��� ����
			FROM ���̺�1
				JOIN ���̺�2 ON (���ǽ�)
		* JOIN USING : �÷����� ���� ��츸 ��� ����
			FROM ���̺�1
				JOIN ���̺�2 USING (�÷���)
*/
-- ���, �����, �μ��� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�����", D.DEPT_TITLE AS "�μ���"
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

-- ��� �����, ���޸� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�����", J.JOB_NAME AS "�μ���"
FROM EMPLOYEE E JOIN JOB J USING (JOB_CODE);

SELECT EMP_ID AS "���", EMP_NAME AS "�����", J.JOB_NAME AS "�μ���"
FROM EMPLOYEE E JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- �븮 ������ ����� ���, �����, ���޸�, �޿�
-- ORACLE ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE AND JOB.JOB_NAME = '�븮';

-- ANSI ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '�븮';

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '�븮');
-- ==============================================================
-- [1] �μ��� �λ�������� ������� ���, �����, ���ʽ� ��ȸ
-- ORACLE ����
SELECT EMP_ID AS "���", EMP_NAME AS "�����", NVL(BONUS, 0) AS "���ʽ�"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE = '�λ������';

-- ANSI ����
SELECT EMP_ID AS "���", EMP_NAME AS "�����", NVL(BONUS, 0) AS "���ʽ�"
FROM EMPLOYEE E JOIN  DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

-- [2] �μ��� ���������� �����Ͽ�, ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
		-- ���� : LOCATION ���̺� ����
-- ORACLE ���� 
SELECT D.DEPT_ID, D.DEPT_TITLE, L.LOCAL_CODE, L.LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

-- ANSI ����
SELECT D.DEPT_ID, D.DEPT_TITLE, L.LOCAL_CODE, L.LOCAL_NAME
FROM DEPARTMENT D JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- [3] ���ʽ��� �޴� ����� ���, �����, ���ʽ�, �μ��� ��ȸ
-- ORACLE ���� 
SELECT EMP_ID AS "���", EMP_NAME AS "�����", BONUS AS "���ʽ�", D.DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND BONUS IS NOT NULL;

-- ANSI ����
SELECT EMP_ID AS "���", EMP_NAME AS "�����", BONUS AS "���ʽ�", D.DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE BONUS IS NOT NULL;

-- [4] �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ
-- ORACLE ���� 
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND D.DEPT_TITLE != '�ѹ���';

-- ANSI ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE != '�ѹ���';

-- ==============================================================
/*
	���� ���� / �ܺ� ���� (OUTER JOIN)
	- �� ���̺� ���� JOIN �� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ�ϴ� ����
		��, ORACLE������ �ݵ�� LEFT / RIGHT �����ؾ���(������ �Ǵ� ���̺�)
	
	- LEFT JOIN : �� ���̺� �� ���ʿ� �ۼ��� ���̺��� �������� ����
	- RIGHT JOIN : �� ���̺� �� �����ʿ� �ۼ��� ���̺��� �������� ����
	
	- FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ�ϴ� ����(ORACLE �������� ����)
*/
-- ��� ����� �����, �μ���, �޿�, ���� ��ȸ
-- LEFT JOIN
-- ORACLE
SELECT EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", SALARY AS "�޿�", SALARY * 12 AS "����"
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID(+);

-- ANSI
SELECT EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", SALARY AS "�޿�", SALARY * 12 AS "����"
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- RIGHT JOIN
SELECT EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", SALARY AS "�޿�", SALARY * 12 AS "����"
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE(+) = DEPT_ID;

SELECT EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", SALARY AS "�޿�", SALARY * 12 AS "����"
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- FULL JOIN
SELECT EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", SALARY AS "�޿�", SALARY * 12 AS "����"
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ==============================================================
/*
	�� ����(NON EQUAL JOIN)
	- ������ �������� �� ��
	- ��Ī ��ų �÷��� ���� ���� �ۼ� �� '='�� ������� �ʴ� ����. ������ ���� ����
	
	ANSI ���������� JOIN ON�� ��� ����
*/
-- ����� ���� �����, �޿�, �޿���� ��ȸ
-- ORACLE ����
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", SAL_LEVEL AS "�޿����"
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", SAL_LEVEL AS "�޿����"
FROM EMPLOYEE JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;
-- ==============================================================
/*
	SELF JOIN
	- ���� �ٸ� ���̺��� �ƴ� ���� ���̺��� �����ϴ� ����
*/
-- ��ü ����� ���, �����, �μ��ڵ�, ����� ���, ����� �����, ����� �μ��ڵ� ��ȸ
SELECT E.EMP_ID AS "���", E.EMP_NAME AS "�����", E.DEPT_CODE AS "�μ��ڵ�",
			M.EMP_ID AS "����� ���", M.EMP_NAME AS "����� �����", M.DEPT_CODE AS "����� �μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID; -- � ����� �������� ����� ����� �������� ����!

SELECT E.EMP_ID AS "���", E.EMP_NAME AS "�����", E.DEPT_CODE AS "�μ��ڵ�",
			M.EMP_ID AS "����� ���", M.EMP_NAME AS "����� �����", M.DEPT_CODE AS "����� �μ��ڵ�"
FROM EMPLOYEE E JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- ����� ���� ����� ������ ��� �� ��� : LEFT JOIN
SELECT E.EMP_ID AS "���", E.EMP_NAME AS "�����", E.DEPT_CODE AS "�μ��ڵ�",
			M.EMP_ID AS "����� ���", M.EMP_NAME AS "����� �����", M.DEPT_CODE AS "����� �μ��ڵ�"
FROM EMPLOYEE E LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
-- ==============================================================
/*
	��������
	- 2�� �̻��� ���̺��� �����ϴ� ��
*/
-- ���, �����, �μ���, ���޸� ��ȸ
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
	JOIN JOB J USING(JOB_CODE);
	
-- ����� ���, �����, �μ���, ������ ��ȸ
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
	JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- ==============================================================
-- [1] ���, �����, �μ���, ������, ������ ��ȸ
-- ORACLE
SELECT EMP_ID AS "���", EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", LOCAL_NAME AS "������", NATIONAL_NAME AS "������"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- ANSI
SELECT EMP_ID AS "���", EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", LOCAL_NAME AS "������", NATIONAL_NAME AS "������"
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
	JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
	JOIN NATIONAL N USING (NATIONAL_CODE);

-- [2] ���, �����, �μ���, ���޸�, ������, ������, �޿���� ��ȸ
-- ORACLE
SELECT EMP_ID AS "���", EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", JOB_NAME AS "���޸�", LOCAL_NAME AS "������", NATIONAL_NAME AS "������", SAL_LEVEL AS "�޿����"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID 
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID = L.LOCAL_CODE 
AND L.NATIONAL_CODE = N.NATIONAL_CODE 
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;

-- ANSI
SELECT EMP_ID AS "���", EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", JOB_NAME AS "���޸�", LOCAL_NAME AS "������", NATIONAL_NAME AS "������", SAL_LEVEL AS "�޿����"
FROM EMPLOYEE E
	JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
	JOIN JOB J USING (JOB_CODE)
	JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
	JOIN NATIONAL N USING (NATIONAL_CODE)
	JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);








