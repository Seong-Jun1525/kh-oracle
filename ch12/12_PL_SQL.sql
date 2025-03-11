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
/
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






