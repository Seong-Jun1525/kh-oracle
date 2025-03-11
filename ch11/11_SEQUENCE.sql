/*
	������(SEQUENCE)
	- �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
	- ������ ���������� ������ ������ ������Ű�鼭 ����
*/

/*
	������ ����
	[ǥ����]
		CREATE SEQUENCE ��������
		[START WITH ����]			�� ó�� �߻���ų ���۰� ���� (���� �� �⺻���� 1)
		[INCREMENT BY ����]		�� �󸶸�ŭ�� ������ų �������� ���� �� ���� (���� �� �⺻���� 1)
		[MAXVALUE ����]			�� �ִ밪 (���� �� �⺻���� ��ûũ��)
		[MINVALUE ����]			�� �ּڰ� (���� �� �⺻���� 1)
		[CYCLE | NOCYCLE]			�� MAX Ȥ�� MINVALUE�� ��������. ���� ��ȯ���� (�⺻���� NOCYCLE)
											* CYCLE : ������ ���� �ִ밪�� �����ϸ� �ּҰ����� �ٽ� ��ȯ�ϵ��� ����
											* NOCYCLE : ������ ���� �ִ밪�� �����ϸ� �ּҰ����� �ٽ� ��ȯ�ϵ��� ����
		 [NOCACHE | CACHE ����]		�� ĳ�ø޸� �Ҵ� ���� (�⺻�� CACHE 20)
											* ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ����
															�Ź� ȣ��� ������ ���� ��ȣ�� �����ϴ� ���� �ƴ϶�
															ĳ�ø޸𸮶�� ������ �̸� �����ص� ���� �����ٰ� ��� (�ӵ��� ����)
															
		* ����
			- ���̺� : TB_
			- ��		: VW_
			- ������ : SEQ_
			- Ʈ���� : TRG_ 
		
*/

CREATE SEQUENCE SEQ_TEST;

-- ���� ������ ������ ������ ��ȸ
SELECT * FROM USER_SEQUENCES;

-- SEQ_EMPNO ������ ����
CREATE SEQUENCE SEQ_EMPNO
	START WITH 300
	INCREMENT BY 5
	MAXVALUE 310
	NOCYCLE -- �⺻���̶� ��������
	NOCACHE;
	
/*
	������ ���
	
	- ��������.CURRAL : ���� ������ ��. ���������� ������ NEXTVAL�� ������ ��.
	- ��������.NEXTVAL : ������ ���� ���� ���� �������� �߻��� �����
							���� ������ ������ INCREMENT BY�� ������ ����ŭ ������ ��	
*/	

-- SEQ_EMPNO �������� ���� ������ �� ��ȸ
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- ���� �߻�! NEXTVAL�� �ѹ��� ������� ���� �������� CURRVAL�� ����� �� ����

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- ó�� ���� �� ���� ���� Ȯ���� �� ����.
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- ������ �� Ȯ��!
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- ������ �� Ȯ��!
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- �����߻�!! �ִ밪�� �ѱ���� ��

/*
	* ������ ����
	ALTER SEQUENCE ��������
	[INCREMENT BY ����]
	[MAXVALUE ����]
	[MINVALUE ����]
	[CYCLE | NOCYCLE]
	[NOCACHE | CACHE ����]
	
	�� ���� ���� ���� �Ұ�!
*/

-- SEQ_EMPNO �������� �������� 10, �ִ밪�� 400���� ����
ALTER SEQUENCE SEQ_EMPNO
	INCREMENT BY 10
	MAXVALUE 400;
	
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310	

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320

/*
	������ ����
	DROP SEQUENCE ��������;
*/
DROP SEQUENCE SEQ_EMPNO;

SELECT * FROM USER_SEQUENCES;
------------------------------------------------------------------------------------------
/*
	������ ���
*/

SELECT * FROM EMPLOYEE;

-- ������ ���� (SEQ_EID) 300�� ���� ����, ĳ�ø޸� ���X, �������� 1
CREATE SEQUENCE SEQ_EID
	START WITH 300
	NOCACHE;
	
-- ������ ��� : EMPLOYEE ���̺� �����Ͱ� �߰��� ��
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
	VALUES (SEQ_EID.NEXTVAL, '�Ӽ���', '250311-1231233', 'J1', SYSDATE);
ROLLBACK;