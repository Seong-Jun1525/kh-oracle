-- =================== ������ ���� ���� �� �Ʒ� ���� ��ȸ =================== --
-- ���þƿ��� �ٹ����� ����� ���, �����, �μ���, ������, �������� ��ȸ
/*
        211	������	���������	EU	���þ�
        212	������	���������	EU	���þ�
        222	���¸�	���������	EU	���þ�
*/
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
	JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
	JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
	JOIN NATIONAL USING (NATIONAL_CODE)
WHERE 	NATIONAL_NAME = '���þ�';

-- �μ� �� ���ʽ����� ���� ���� ����� �μ���, ���޸�, �̸�, ���ʽ� ��ȸ 
/*
        �λ������	�븮	������	0.3
        �ؿܿ���1��	����	�ɺ���	0.15
        �ؿܿ���2��	����	�����	0.2
        ���������	�븮	���¸�	0.35
        �ѹ���	    ��ǥ	������	0.3
*/
SELECT DEPT_TITLE, JOB_NAME, EMP_NAME, BONUS
FROM EMPLOYEE
	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	JOIN JOB USING (JOB_CODE)
WHERE (DEPT_TITLE, BONUS) IN (
	SELECT DEPT_TITLE, MAX(BONUS)
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
		JOIN JOB USING (JOB_CODE)
	GROUP BY DEPT_TITLE
);

--SELECT DEPT_TITLE, MAX(BONUS)
--	FROM EMPLOYEE
--		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--		JOIN JOB USING (JOB_CODE)
--	GROUP BY DEPT_TITLE

-- ���̰� 5�� ���̳��� ������� ���� ��ȸ 
-- ( ���A�� ���, ���A�� �̸�, ���A�� �������, ���B�� ���, ���B�� �̸�, ���B�� ������� )
/*
        209	�ɺ���	750206	221	������	800808
        212	������	780923	211	������	830807
        221	������	800808	214	����	856795
        211	������	830807	215	���ȥ	881130
*/
-- ORACLE
SELECT E.EMP_ID, E.EMP_NAME, SUBSTR(E.EMP_NO, 1, 6), EE.EMP_ID, EE.EMP_NAME, SUBSTR(EE.EMP_NO, 1, 6)
FROM EMPLOYEE E, EMPLOYEE EE
WHERE ABS(TO_NUMBER('19' || SUBSTR(E.EMP_NO, 1, 2)) 
            - TO_NUMBER('19' || SUBSTR(EE.EMP_NO, 1, 2))) = 5	
	    AND TO_NUMBER('19' || SUBSTR(E.EMP_NO, 1, 2)) < TO_NUMBER('19' || SUBSTR(EE.EMP_NO, 1, 2));

-- ANSI ����	    
SELECT E.EMP_ID, E.EMP_NAME, SUBSTR(E.EMP_NO, 1, 6), EE.EMP_ID, EE.EMP_NAME, SUBSTR(EE.EMP_NO, 1, 6)
FROM EMPLOYEE E
	JOIN EMPLOYEE EE ON ABS(TO_NUMBER('19' || SUBSTR(E.EMP_NO, 1, 2)) - TO_NUMBER('19' || SUBSTR(EE.EMP_NO, 1, 2))) = 5
-- � ������ ��쿡�� ����Ǵ� �÷����� ���� �񱳸� ������ ���� �ڵ�ó�� ������ �������� �ټ��� �ִ�
-- �� ������ �ƴϿ��� �ȴ�
WHERE TO_NUMBER('19' || SUBSTR(E.EMP_NO, 1, 2)) < TO_NUMBER('19' || SUBSTR(EE.EMP_NO, 1, 2));
