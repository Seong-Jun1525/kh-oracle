-- ȸ�� ������ ������ ���̺� (MEMBER)
DROP TABLE MEMBER; -- Ȥ�ö� ���̺��� ���� �� �ֱ� ������
CREATE TABLE MEMBER (
	MEMBERNO NUMBER PRIMARY KEY,					-- ȸ����ȣ
	MEMBERID VARCHAR2(20) NOT NULL UNIQUE,			-- ȸ��ID
	MEMBERPW VARCHAR2(20) NOT NULL,				-- ȸ��PW
	GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),			-- ����
	AGE NUMBER,										-- ����
	EMAIL VARCHAR2(30),								-- �̸���
	ADDRESS VARCHAR2(100),							-- �ּ�
	PHONE VARCHAR2(13),								-- ����ó
	HOBBY VARCHAR2(50),								-- ���
	ENROLLDATE DATE DEFAULT SYSDATE NOT NULL		-- ���Գ�¥
);

-- ȸ����ȣ�� ���� ������ ��ü ����
DROP SEQUENCE SEQ_MNO;
CREATE SEQUENCE SEQ_MNO NOCACHE;

-- ���õ�����
INSERT INTO MEMBER VALUES (SEQ_MNO.NEXTVAL, 'ADMIN', '1234', 'M', 26, 'admin@email.com', '��õ', '010-1234-1234', NULL, '2020/0312');
INSERT INTO MEMBER VALUES (SEQ_MNO.NEXTVAL, 'SJ', '4321', 'M', 26, 'sj@email.com', '��õ', '010-3214-3214', NULL, DEFAULT);
COMMIT;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �׽�Ʈ�� ���̺� TEST
DROP TABLE TEST;
CREATE TABLE TEST (
	TNO NUMBER,
	TNAME VARCHAR2(30),
	TDATE DATE
);

INSERT INTO TEST VALUES (1, 'ȫ�浿', SYSDATE);
COMMIT;

SELECT * FROM TEST;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--INSERT INTO MEMBER
--	VALUES (SEQ_MNO.NEXTVAL, 'ȸ�����̵�', 'ȸ����й�ȣ', '����', ����, '�̸���', '�ּ�', '����ó', '���', DEFAULT);

SELECT * FROM MEMBER;
SELECT * FROM MEMBER WHERE MEMBERID = 'ADMIN';

DELETE FROM MEMBER;