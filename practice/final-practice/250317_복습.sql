-- * �Ʒ� ������ �����Ͽ� ������ �� �Ʒ� �������� �������ּ���.
--   USERNAME / PWD : C##TEST250317 / TEST0317
SELECT * FROM DBA_USERS WHERE USERNAME LIKE 'C##%';

DROP USER C##TEST250317;
CREATE USER C##TEST250317 IDENTIFIED BY TEST250317;								-- IDENTIFIED BY ��й�ȣ�� ���� �ʾƵ� ������ �����ȴ�
GRANT CONNECT, RESOURCE TO C##TEST250317;										-- CONNECT : ����, RESOURCE : �ڿ�

--ALTER USER C##TEST250317 QUOTA UNLIMITED ON USERS;							-- �ּ����� ���̺����̽��� ����				
ALTER USER C##TEST250317 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;		-- �ּ����� ���̺����̽��� ����

DROP USER C##TEST250317;

--------------------------------------------------------------------------------------------------------
DROP TABLE DEPARTMENTS;
DROP TABLE EMPLOYEES;

-- DEPARTMENTS ���̺� ����
CREATE TABLE DEPARTMENTS (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50) NOT NULL
);

-- EMPLOYEES ���̺� ����
CREATE TABLE EMPLOYEES (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    SALARY NUMBER,
    HIRE_DATE DATE,
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID)
);

-- DEPARTMENTS ������ ����
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (1, '�λ��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (2, '�繫��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (3, 'IT�μ�');

-- EMPLOYEES ������ ����
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (101, 'ȫ�浿', 3500000, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (102, '��ö��', 3200000, TO_DATE('2019-03-22', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (103, '�̿���', 3800000, TO_DATE('2021-07-10', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (104, '������', 4500000, TO_DATE('2018-11-05', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (105, '�ֹ�ȣ', 4700000, TO_DATE('2022-02-18', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (106, '�ű��', 2900000, TO_DATE('2024-05-13', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (107, '����Ŭ', 3300000, TO_DATE('2024-07-23', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (108, '���ڹ�', 3900000, TO_DATE('2025-01-06', 'YYYY-MM-DD'), 3);
--------------------------------------------------------------------------------------------------------

-- ��� ������ �̸��� �޿��� ��ȸ
-- ����� ��� �� : 8
SELECT EMP_NAME, SALARY FROM EMPLOYEES;

-- '�繫��'�� ���� �������� �̸��� �μ����� ��ȸ (����Ŭ ���� ���� ���)
/*
    EMP_NAME    | DEPT_NAME
    -----------------------
    ��ö��       | �繫��
    ������       | �繫��
*/
-- ����Ŭ ����
SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPT_ID = D.DEPT_ID AND D.DEPT_NAME = '�繫��';

-- ANSI
SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEES
	JOIN DEPARTMENTS USING (DEPT_ID)
WHERE DEPT_NAME	= '�繫��';


-- ��� �޿��� ��� (�Ҽ��� 2�ڸ����� ǥ��)
/*
    ��� �޿�
    ----------
    3766666.67
*/
SELECT TO_CHAR(AVG(SALARY), '9999999990.99') AS "��� �޿�"
FROM EMPLOYEES;

-- �μ��� ���� ���� ����ϰ�, ���� ���� 3�� �̻��� �μ��� ��ȸ 
/*
    �μ���     | ���� ��
    -----------------------
    IT�μ�     | 4
*/
SELECT DEPT_NAME AS "�μ���", COUNT(*) AS "���� ��"
FROM EMPLOYEES
	JOIN DEPARTMENTS USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING COUNT(*) >= 3;

-- �޿��� ���� ���� ������ �̸��� �޿��� ��ȸ
/*
    ���� �̸�      | �޿�
    --------------------------
    �ֹ�ȣ	      | 4700000
*/
SELECT EMP_NAME AS "���� �̸�", SALARY AS "�޿�"
FROM EMPLOYEES
WHERE SALARY = (
	SELECT MAX(SALARY)
	-- EMP_NAME, MAX(SALARY)  �׷��Լ��� ������ �Լ��� ���̻�� �� �� ����.
	--	EMP_NAME�� ����� ���� ���ε� MAX(SALARY)�� ����� �ϳ��� �׷��� ���� ����� �� ����
	FROM EMPLOYEES	
);

-- ���ο� ���̺� PROJECTS�� ���� 
--  ( ���� ����: ������Ʈ��ȣ (PROJECT_ID:NUMBER (PK), ������Ʈ�� (PROJECT_NAME:VARCHAR2(100) NULL ���X)))
DROP TABLE PROJECTS;
CREATE TABLE PROJECTS (
	PROJECT_ID NUMBER CONSTRAINT PRJ_PK PRIMARY KEY,
	PROJECT_NAME VARCHAR2(100) NOT NULL -- VARCHAR2�� CHAR�� ���̿� �ѱ��� 3BYTE�̰� �������� 1BYTE��� �� �߿�
);

COMMENT ON COLUMN PROJECTS.PROJECT_ID IS '������Ʈ��ȣ';
COMMENT ON COLUMN PROJECTS.PROJECT_NAME IS '������Ʈ��';

-- ���ο� ���� '�����'�� EMPLOYEES ���̺� ���� ( ���� ����: �޿� 3500000, IT�μ�, ���� �Ի�)
-- * ���� ��ȣ�� ���, �������� �����Ͽ� Ȱ���غ���. 
DROP SEQUENCE SEQ_EMPID;
CREATE SEQUENCE SEQ_EMPID
	START WITH 109
	NOCYCLE
	NOCACHE;
INSERT INTO EMPLOYEES VALUES(SEQ_EMPID.NEXTVAL, '�����', 3500000, SYSDATE, 3);
SELECT * FROM EMPLOYEES;
COMMIT;

-- EMPLOYEES ���̺��� 'ȫ�浿'�� �޿��� 3800000���� ����
UPDATE EMPLOYEES
	SET SALARY = 3800000
WHERE EMP_NAME = 'ȫ�浿';	
SELECT * FROM EMPLOYEES;
COMMIT;

-- EMPLOYEES ���̺��� �޿��� 3000000 ������ �������� ���� -- 1�� �� ����
DELETE FROM EMPLOYEES WHERE SALARY <= 3000000;
SELECT * FROM EMPLOYEES;
COMMIT;

-- EMPLOYEES ���̺� ���ο� �÷� EMAIL�� �߰� (VARCHAR2(100), �⺻�� 'temp@kh.or.kr')
ALTER TABLE EMPLOYEES ADD EMAIL  VARCHAR2(100)  DEFAULT 'temp@kh.or.kr';

-- ��� ������ �̸��� �޿��� �����ϴ� �� VW_EMP�� ����
-- * VIEW ���� ���� �ο� (������ ����)
GRANT CREATE VIEW TO C##TEST250317;
CREATE VIEW VW_EMP -- OR REPLACE ���� �̸��� �䰡 ���� ��� �����!
AS (
	SELECT EMP_NAME AS "�̸�", SALARY AS "�޿�"
	FROM EMPLOYEES
);

-- ������ VIEW�� �������� �̸��� '��'�� ���Ե� ���� ��ȸ
/*
    �̸�   | �޿�
    �ֹ�ȣ	4700000
    �����	3500000
*/
SELECT �̸�, �޿�
FROM VW_EMP
WHERE �̸� LIKE '%��%';

-- �� VW_EMP�� ����
DROP VIEW VW_EMP;

-- EMPLOYEES ���̺��� ����
DROP TABLE EMPLOYEES;

----------------------------------------------------------------
-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; ����
	User C##TEST��(��) �����Ǿ����ϴ�.
	���� ������ �ϰ� ���� �� ���� (user C##TEST lacks CREATE SESSION privillege; logon denied ����)
*/

-- ���� ? ������ C##TEST ������ �����ͺ��̽� ���� ������ �ο����� �ʾ����Ƿ� ������ �߻��Ѵ� => ���� ���� �� ������ �ο����� �ʾҴ�
-- �ذ��� ? GRANT CREATE SESSION TO C##TEST ��ɾ ���� ������ �ο��ؾ� �Ѵ�

-- ���̺� ���� �� ���� ���� �߻� : GRANT RESOURCE TO ������; �Ǵ� GRANT CREATE TABLE TO ������;

-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
	JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	���� �� ���̺��� �����Ͽ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�ϰ��� �Ѵ�.
	�̶� ������ SQL���� �Ʒ��� ���ٰ� ���� ��,
*/
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB USING(JOBNO);
-- ������ ���� ������ �߻��ߴ�.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- ���� ? JOBNO��� �÷��� TB_JOB ���̺� �������� �ʾƼ� �߻��Ǵ� ������. => ����Ǿ�� �ϴ� �÷����� �ٸ��Ƿ� USING ������ ����� �� ����
-- �ذ��� ? 
--���̺��� JOIN�� ���� JOIN ���̺�� ON ���� Ȥ�� JOIN ���̺�� USING (����) �̷������� �ۼ��� �� �ִµ� �̶� USING�� ��쿡�� �� �÷�����
--������ ��쿡�� ����� �����ϴ�.
-- ������ �� ���̺��� ��쿡�� JOBNO��� �÷��� TB_EMP ���̺��� �����ϹǷ� FROM TB_EMP JOIN TB_JOB ON JOBNO = JOBCODE ������ �����ؾ��Ѵ�.

-- ���� �� ���� �ߴ� ��� �ٽ� �ѹ� �� ���캸��
