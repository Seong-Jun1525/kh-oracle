/*
	Ʈ���� (TRIGGER)
	- ��ü
	- ������ ���̺� DML���� ���ؼ� ��������� ���� ��
	  �ڵ����� �Ź� ������ ������ �̸� �����صδ� ��
	  EX) ȸ�� Ż�� �� ���� ȸ�����̺� ������ �����ϰ� Ż��ȸ�� ���̺� ������ �߰��ؾ� �� �� �ڵ����� ����..
	  EX) �Ű� Ƚ���� Ư�� ���� �Ѿ�� �� ������Ʈ�� ó��
	  EX) ����� ���� �����͸� ������ �� �ش� ��ǰ�� ��� ������ �����ؾ� �� �� 
*/
-------
/*
	Ʈ������ ����
	- SQL���� ���� �ñ⿡ ���� �з�
		* BEFORE TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��ϱ� ���� Ʈ���� ����
		* AFTER TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
	- SQL���� ���� ������ �޴� �� �࿡ ���� �з�
		* ���� Ʈ���� : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
		* �� Ʈ���� : �ش� SQL���� ����� ������ �Ź� Ʈ���� ����
					- FOR EACH ROW �ɼ� �����ؾ� ��.
					
				:OLD  �� BEFORE UPDATE (���� �� ������), BEFORE DELETE(���� �� ������)
				:NEW �� AFTER INSERT (�߰��� ������), AFTER UPDATE(������ ������)
*/
-------
/*
	TRIGGER ����
	
	CREATE TRIGGER Ʈ���Ÿ�									-- Ʈ���� �⺻����
	BEFORE|AFTER INSERT|UPDATE|DELETE ON ���̺��			-- �̺�Ʈ ���� ����
	[FOR EACH ROW]											-- Ʈ���Ÿ� �Ź� �߻� ��ų ��� �ۼ�
	[DECLARE]													-- ���� / ��� ���� �� �ʱ�ȭ						
	BIGIN														-- �����(SQL��, ���, ...)
																	�̺�Ʈ �߻� �� �ڵ����� ó���ϰ��� �ϴ� ����
	[EXCEPTION]												-- ����ó����
	END;
*/
-- EMPLOYEE ���̺� �����Ͱ� �߰��� �� ���� '���Ի���� ȯ���մϴ�.' ���
CREATE TRIGGER TRG_EMP_WELCOME
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
	DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE) 
	VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '123456-1234567', 'J6', SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE) 
	VALUES(SEQ_EID.NEXTVAL, '��浿', '123456-1234567', 'J6', SYSDATE);

-------

-- ��ǰ �԰�, ��� ����
-- TB_PRODUCT ���̺� ����
CREATE TABLE TB_PRODUCT (
	PNO NUMBER PRIMARY KEY,			-- ��ǰ��ȣ
	PNAME VARCHAR2(30) NOT NULL,		-- ��ǰ��
	BRAND VARCHAR2(30) NOT NULL,		-- �귣��
	PRICE NUMBER DEFAULT 0,			-- ����
	STOCK NUMBER DEFAULT 0			-- ������
);

-- ������ ����
CREATE SEQUENCE SEQ_PNO
	START WITH 200
	INCREMENT BY 5
	NOCACHE;

-- ���� ������ �߰�
INSERT INTO TB_PRODUCT (PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '������', '�Ƶ鵵��');
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '�򸮴�', '���̽�', 350000, 50);
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '����', '����Ʈ', 150000, 50);
COMMIT;

-- TB_PDETAIL ���̺� ���� : ��ǰ ����� ������ �����ϱ� ���� ���̺�
CREATE TABLE TB_PDETAIL (
	DNO NUMBER PRIMARY KEY,						-- ����� ���� ��ȣ
	PNO NUMBER REFERENCES TB_PRODUCT,			-- ��ǰ��ȣ
	DDATE DATE DEFAULT SYSDATE,					-- �������
	AMOUNT NUMBER NOT NULL,					-- ��������
	DTYPE CHAR(10) CHECK(DTYPE IN ('�԰�', '���'))	-- ����� ����
);
CREATE SEQUENCE SEQ_DNO
	NOCACHE;
----------------
-- 205�� ��ǰ, ���� 5�� ���
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '���');
UPDATE TB_PRODUCT
	SET STOCK = STOCK - 5
WHERE PNO = 205;	
COMMIT;

-- 200�� ��ǰ�� 10�� �԰�
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '�԰�');
UPDATE TB_PRODUCT
	SET STOCK = STOCK + 10
WHERE PNO = 205; -- UPDATE�� �߸���!! �ѹ��ؾ���!!
ROLLBACK;
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '�԰�');
UPDATE TB_PRODUCT
	SET STOCK = STOCK + 10
WHERE PNO = 200;
-----------------------------------------------------------------------------------------------------
/*
	TB_PDETAIL ���̺� �����Ͱ� �߰��Ǿ��� ��
	TB_PRODUCT ���̺� �ش� �������� ��� ������ �����ؾ���
	
	UPDATE ����
		- ��ǰ�� �԰�� ��� : �ش� ��ǰ�� ã�Ƽ� ��� ������ ����
		UPDATE TB_PRODUCT
			SET STOCK = STOCK + �԰����(TB_PDETAIL.AMOUNT) �� :NEW.AMOUNT
		WHERE PNO = �԰�Ȼ�ǰ��ȣ(TB_PDETAIL.PNO) 	�� :NEW.PNO
		
		- ��ǰ�� ���� ��� : �ش� ��ǰ�� ã�Ƽ� ��� ������ ����
		UPDATE TB_PRODUCT
			SET STOCK = STOCK - ������(TB_PDETAIL.AMOUNT) �� :NEW.AMOUNT
		WHERE PNO = ���Ȼ�ǰ��ȣ(TB_PDETAIL.PNO) 	�� :NEW.PNO
*/
-- TRG_STOCK_IO
--DROP TRIGGER TRG_STOCK_IO;
CREATE TRIGGER TRG_STOCK_IO
	AFTER INSERT ON TB_PDETAIL
	FOR EACH ROW
	BEGIN
		-- :NEW : ���� �߰��� �����͸� �ǹ�
		IF :NEW.DTYPE = '�԰�'
			THEN 
				UPDATE TB_PRODUCT
					SET STOCK = STOCK + :NEW.AMOUNT
				WHERE PNO =  :NEW.PNO;
		ELSIF  :NEW.DTYPE = '���'
			THEN 
				UPDATE TB_PRODUCT
					SET STOCK = STOCK - :NEW.AMOUNT
				WHERE PNO =  :NEW.PNO;
		END IF;	
	END;
/
-- ������ �߰�
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PDETAIL;

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 210, SYSDATE, 7, '�԰�');

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 3, '���');



























