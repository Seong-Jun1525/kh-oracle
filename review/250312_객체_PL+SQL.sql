/*
	����Ŭ(DB)���� �پ��� ��ü���� �ִ�.
	������ � ��ü�� ���� �����ΰ�? �ش� ��ü�� ������ �ۼ��غ���.
	
	* VIEW : ���̺�� �ٸ��� ���������� �����͸� �������� ������,
						   ���� ���̺��� Ư�� �÷��̳� ������ �����Ͽ� �����͸� �� �� �ִ�.
	
	CREATE VIEW ��� AS (��������);			 
	CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ��� AS (��������);
						   
	* SEQUENCE : �ڵ� ���� ���� �����ϴ� ��ü. �ַ� �⺻ Ű ���� �� ���.
	CREATE SEQUENCE ��������
		START WITH
		INCREMENT BY
		MAXVALUE
		MINVALUE
		CYCLE | NOCYCLE
		CACHE | NOCACHE
	
	* TRIGGER : Ư�� �̺�Ʈ �߻� �� �ڵ����� ����ǵ��� ������ ��ü.
	CREATE TRIGGER Ʈ���Ÿ�
		BEFORE | AFTER INSERT|UPDATE|DELETE ON ���̺��
		[FOR EACH ROW]
		[DECLARE]
		BEGIN
		[EXCEPTINO]
		END
	
	* USER : ���̺�, ��, ������ ���� ��ü�� ������ �� �ִ� ��ü. Ư�� ������ �ο� �޾� �ٸ� ��ü�� ������ �� ����.
	CREATE USER ����ڸ�
*/
-- * ---------------------------------------------------------------------- * --
/*
    * ����� ����� �Է¹޾� �ش� ����� ���, �̸��� ���
      - ��� : XXX
      - �̸� : XXX
      
      ��, ��ȸ�� ����� ���� ��� '�Է��� ��� ����� ���� ����� �����ϴ�.' ���
      ��ȸ�� ����� ���� ��� '�ش� ����� ���� ����� �����ϴ�.' ���
      �� ���� ���� �߻� �� '������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���.' ���
*/

SET SERVEROUTPUT ON;
-- �����ϱ� �� �� ó���� �ѹ� ��������� �Ѵ�

--SELECT E.EMP_ID, E.EMP_NAME, E.MANAGER_ID
--	FROM EMPLOYEE E
--		JOIN EMPLOYEE EE ON E.MANAGER_ID = EE.EMP_ID;

DECLARE
	EID EMPLOYEE.EMP_ID%TYPE;
	ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME
		INTO EID, ENAME
		FROM EMPLOYEE 
	WHERE MANAGER_ID = &������;
	
	DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
	DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
	
EXCEPTION	
	WHEN NO_DATA_FOUND
		THEN DBMS_OUTPUT.PUT_LINE('�Է��� ��� ����� ���� ����� �����ϴ�.');
	WHEN TOO_MANY_ROWS
		THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�.');
	WHEN OTHERS
		THEN DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���.');
	
END;
/