/*
	PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL
	
	����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
	SQL ���� ������ ���� ����, ���ǹ�, �ݺ��� ���� ���� �� SQL ���� ����
	
	�ټ��� SQL���� �ѹ��� ���� ����
	
	* ���� *
	[�����]		: DECLARE�� ����. ������ ����� �ʱ�ȭ�ϴ� �κ�
	�����		: BEGIN���� ����. SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ������ �ۼ��ϴ� �κ�
	[����ó����]	: EXCEPTION���� ����. ���� �߻� �� �ذ��ϱ� ���� �κ�
*/

-- * ȭ�鿡 ǥ���ϱ� ���� ����
SET SERVEROUTPUT ON;

-- "HELLO ORACLE" ���

BEGIN
	DBMS_OUTPUT.PUT_LINE('HELLO ORACLE'); -- "" X
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	�����(DECLARE)
	- ���� �Ǵ� ����� ���� �� �ʱ�ȭ �ϴ� �κ�
	
	������Ÿ�� ���� ����
	- �Ϲ�Ÿ��
	- ���۷��� Ÿ��
	- ROW Ÿ��
*/
/*
	�Ϲ� Ÿ�� ����
	
	������ [CONSTANT] �ڷ��� [:= ��]
	
	-- ��� ���� �� CONSTANT�� �߰�
	-- �ʱ�ȭ �� := ��ȣ�� ���
*/

-- EID ��� �̸��� NUMBER Ÿ�� ����
-- ENAME ��� �̸��� VARCHAR2(20) Ÿ�� ����
-- PI ��� �̸��� NUBMER Ÿ�� ��� ���� �� 3.14 ��� ������ �ʱ�ȭ
DECLARE
	EID NUMBER;
	ENAME VARCHAR2(20);
	PI CONSTANT NUMBER := 3.14;

BEGIN
	-- ������ ���� ����
	EID := 100;
	ENAME := '�Ӽ���';
	
	-- || : ���� ������
	DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/ -- PL/SQL�� / �� �����Ѵ�!
-- ���� �Է� �޾� ������ ����
DECLARE
	EID NUMBER;
	ENAME VARCHAR2(20);
	PI CONSTANT NUMBER := 3.14;

BEGIN	
	ENAME := '�Ӽ���';
	EID := &�����ȣ; -- ����ڷκ��� �Է¹ޱ� �� &��ü������
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
/*
	���۷��� Ÿ�� ����
	- � ���̺��� � �÷��� ������Ÿ���� �����Ͽ� �ش� Ÿ������ ������ ����
	
	[ǥ����]
	������ ���̺��.�÷���%TYPE
*/

-- EID ��� ������ EMPLOYEE ���̺��� EMP_ID �÷��� Ÿ���� ����
-- ENAME ��� ������ EMPLOYEE ���̺��� EMP_NAME �÷��� Ÿ���� ����
-- SAL ��� ������ EMPLOYEE ���̺��� SALARY �÷��� Ÿ���� ����
DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	SAL EMPLOYEE.SALARY%TYPE;
BEGIN
	-- EMPLOYEE ���̺��� �Է¹��� ����� ���� ���� ������ ��ȸ
	
	SELECT EMP_ID, EMP_NAME, SALARY
	INTO EID, ENAME, SAL -- �� �÷��� ���� ���� ������ ����
	FROM EMPLOYEE
	WHERE EMP_ID = &�����ȣ;
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�

	�� �ڷ����� EMPLOYEE ���̺��� EMP_ID, EMP_NAME, JOB_CODE, SALARY �÷���
	DEPARTMENT ���̺��� DEPT_TITLE �÷��� �����ϵ��� �� ��
	����ڰ� �Է��� ����� ��� ������ ��ȸ�Ͽ� ������ ��� ���
	
	��� ����
	���, �̸�, �����ڵ�, �޿�, �μ���
*/

-- SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
-- FROM EMPLOYEE
--	JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	SAL EMPLOYEE.SALARY%TYPE;
	JCODE EMPLOYEE.JOB_CODE%TYPE;
	DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
	INTO EID, ENAME, JCODE, SAL, DTITLE
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
	WHERE EMP_ID = &�����ȣ;	
	
	DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	ROW Ÿ�� ����
		- ���̺��� �� �࿡ ���� ��� �÷� ���� �ѹ��� ���� �� �ִ� ����
		
	[ǥ����]
		������ ���̺��%ROWTYPE;
*/
-- E ��� ������ EMPLOYEE ���̺��� ROW Ÿ�� ���� ����
DECLARE
	E EMPLOYEE%ROWTYPE;
BEGIN
	SELECT * 
	INTO E
	FROM EMPLOYEE
	WHERE EMP_ID = &���;
	DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
	DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
--	DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS, '���ʽ� ����')); -- ORA-06502: PL/SQL: ��ġ �Ǵ� �� ����: ���ڸ� ���ڷ� ��ȯ�ϴµ� �����Դϴ�
	DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || TO_CHAR(NVL(E.BONUS, 0), '0.0'));
	DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || '����');
	
END;
/

-------------------------------------------------------------------------------------------------------------------------------------
/*
	�����(BEGIN)
	
	���ǹ�
		- ���� IF��		 : IF ���ǽ� THEN ���೻�� END IF;
		- IF/ELSE��		 : IF ���ǽ� THEN ���೻�� 
							ELSE ���೻��;
							END IF;
							
		- IF/ELSIF/ELSE��  :IF ���ǽ� THEN ���೻��
							ELSIF ���ǽ� THEN ���೻��
							ELSE ���೻��;
							END IF; 
							
		- CASE / WHEN / THEN
			CASE �񱳴�� 
				WHEN �񱳰�1 THEN �����1
				WHEN �񱳰�2 THEN �����2
				...
				ELSE �����N
			END;	
			
*/
/*
	����ڿ��� ����� �Է¹޾� �ش� ����� ���, �̸�, �޿�, ���ʽ� ������ ��ȸ�Ͽ� ���
	�� �����Ϳ� ���� ���� : ���(EID), �̸�(ENAME), �޿�(SAL), ���ʽ�(BONUS)
	��, ���ʽ� ���� 0(NULL)�� ����� ��� "���ʽ��� ���� �ʴ� ����Դϴ�." ���
*/
DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	SAL EMPLOYEE.SALARY%TYPE;
	BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
	INTO EID, ENAME, SAL, BONUS
	FROM EMPLOYEE
	WHERE EMP_ID = &�����ȣ;
	
	IF BONUS = 0 THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�.');
	ELSE DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
	END IF;
END;
/

/*
	����ڷκ��� ����� �Է¹޾� ��� ������ ��ȸ�Ͽ� ȭ�鿡 ǥ�� (���, �̸�, �μ���, ������)
	�������� : 'KO'�� ��� '������' ǥ��, �׷��� ���� ���� '�ؿ���'
*/

--SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
--	FROM EMPLOYEE
--		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
--		JOIN NATIONAL USING (NATIONAL_CODE);

DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
	DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
	NCODE LOCATION.NATIONAL_CODE%TYPE;
	
	TEAM VARCHAR2(10);
BEGIN
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
	INTO EID, ENAME, DTITLE, NCODE
	FROM EMPLOYEE
		JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
		JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
	WHERE EMP_ID = '&�����ȣ';
	
	IF NCODE = 'KO' 
		THEN TEAM := '������';
	ELSE TEAM := '�ؿ���';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
	DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
	DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
	DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
DECLARE
	SCORE NUMBER;
	GRADE CHAR(1);
BEGIN
	SCORE := &����;
	
	IF SCORE >= 90 THEN GRADE := 'A';
	ELSIF SCORE >= 80 THEN GRADE := 'B';
	ELSIF SCORE >= 70 THEN GRADE := 'C';
	ELSIF SCORE >= 60 THEN GRADE := 'D';
	ELSE GRADE := 'F';
	END IF;	
	
	IF GRADE = 'F' THEN DBMS_OUTPUT.PUT_LINE('���� ����Դϴ�.');
	ELSE DBMS_OUTPUT.PUT_LINE('������ ' || SCORE || '�̰�, ����� ' || GRADE || '�Դϴ�.');
	END IF;
END;
/

-- ����� �Է¹޾� �ش� ����� �μ��ڵ带 �������� �μ����� ���
DECLARE
	EMP EMPLOYEE%ROWTYPE;
	DTITLE VARCHAR2(20);
BEGIN
	SELECT *
	INTO EMP
	FROM EMPLOYEE
	WHERE EMP_ID = '&���';

	DTITLE := CASE EMP.DEPT_CODE
		WHEN 'D1' THEN  '�λ������'
		WHEN 'D2' THEN 'ȸ�������'
		WHEN 'D3' THEN '�����ú�'
		WHEN 'D4' THEN  '����������'
		WHEN 'D5' THEN '�ؿܿ���1��'
		WHEN 'D6' THEN '�ؿܿ���2��'
		WHEN 'D7' THEN '�ؿܿ���3��'
		WHEN 'D8' THEN '���������'
		WHEN 'D9' THEN '�ѹ���'
	END;
	
	DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || ' ����� �ҼӺμ��� ' || DTITLE || '�Դϴ�.');
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
/*
	�ݺ���
	- �⺻����
		LOOP
			�ݺ��� ����
			�ݺ����� ������ ����
		END LOOP;
		
		- �ݺ����� ������ ����
		1) IF ���ǽ� THEN EXIT; END IF;
		2) EXIT WHEN ���ǽ�;
		
	- FOR LOOP��
		FOR ������ IN [REVERSE] �ʱⰪ..������
		LOOP
			�ݺ��� ����
			[�ݺ����� ������ ����]
		END LOOP;	
		
		* REVERSE : ���������� �ʱⰪ���� �ݺ�
	
	- WHILE LOOP��
		WHILE ���ǽ�
		LOOP
			�ݺ��� ����
			[�ݺ����� ������ ����]
		END LOOP;	
*/
-- �⺻������ ����Ͽ� 'HELLO ORACLE' 5�����
DECLARE
	N NUMBER := 1;
	
BEGIN
--	LOOP
--	DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
--	N := N + 1;
--	IF N > 5 THEN EXIT; END IF;
--	END LOOP;

--	FOR I IN 1..5
--	LOOP
--		DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
--	IF I > 5 THEN EXIT; END IF;
--	END LOOP;
	
	FOR I IN REVERSE 1..5
	LOOP
		DBMS_OUTPUT.PUT_LINE('HELLO ORACLE' || I);
	IF I > 5 THEN EXIT; END IF;
	END LOOP;
END;
/
-------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE TEST;

CREATE TABLE TEST (
	TNO NUMBER PRIMARY KEY,
	TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
	INCREMENT BY 2
	MAXVALUE 1000
	NOCACHE;
	
-- TEST ���̺� �����͸� 100�� �߰� TDATE�� ���� ���� ��¥�� �߰�

DECLARE
	
BEGIN
	FOR I IN 1..100
	LOOP
		INSERT INTO TEST (TNO, TDATE) VALUES (SEQ_TNO.NEXTVAL, SYSDATE);
	END LOOP;	
END;
/
SELECT COUNT(*) FROM TEST;
-------------------------------------------------------------------------------------------------------------------------------------
/*
	����ó����(EXCEPTION)
	- ���� �� �߻��ϴ� ����
	
	[ǥ����]
		EXCEPTION
			WHEN ���ܸ� THEN ����ó������;
			WHEN ���ܸ� THEN ����ó������;
			...
			WHEN OTHERS THEN ����ó������;
		
		* ����Ŭ���� �̸� ������ ���� �� �ý��� ����
			- NO_DATA_FOUND : ��ȸ�� ����� ���� �� �߻�
			- TOO_MANY_ROWS : ��ȸ�� ����� ���� ���� �� (�� ������ ����)
			- ZERO_DIVIDE : ���� 0���� �������� �� ��
			- DUP_VAL_ON_INDEX : UNIQUE ���ǿ� ����� �� (�ߺ��� �ִ� ���)
			...
		* OTHERS : � ���ܵ� �߻��Ǿ��� ��	
*/
-- ����ڿ��� ���ڸ� �Է¹޾Ƽ� 10�� ���� ����� ���
DECLARE
	NUM NUMBER;
BEGIN
	NUM := &����;
	DBMS_OUTPUT.PUT_LINE(TO_CHAR(10 / NUM, '0.0'));
	
EXCEPTION
--	WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�.');
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�.');
END;
/
-- EMPLOYEE ���̺� EMP_ID �÷��� �⺻Ű�� ����
-- ����ڿ��� ����� �Է¹޾� ���ö ����� ����� ����
DECLARE

BEGIN
	UPDATE EMPLOYEE
		SET EMP_ID = &�����һ��
	WHERE EMP_NAME = '���ö';	
	
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�ߺ��� �����ȣ�Դϴ�.');
END;
/