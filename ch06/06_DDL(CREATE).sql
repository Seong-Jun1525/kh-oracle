/*
	DDL : ������ ���� ���
	
	����Ŭ���� �����ϴ� ��ü�� ���� ����� (CREATE)
									�����ϰ�(ALTER)
									�����ϴ�(DROP) ����̴�.
	
	�� ���������Ͱ� �ƴ� ��Ģ/������ �����ϴ� ���
	
	* ����Ŭ������ ��ü(����) : ���̺�, ��, ������, �ε���, ��Ű��, Ʈ����, ���ν���, �Լ�, ���Ǿ�, �����, ...
*/

/*
	* CREATE : ��ü�� ���� �����ϴ� ����
	
	[���̺��� ����]
	- ���̺� : ��� ���� �����Ǵ� ���� �⺻���� ��ü. ��� �����͵��� ���̺��� ���� �����
	CREATE TABLE ���̺�� (
		�÷��� ������Ÿ��(ũ��), 
		�÷��� ������Ÿ��,
		�÷��� ������Ÿ��(ũ��),
	);
	
	�ڷ���(������Ÿ��)
		- ���� �� �ݵ�� ũ�⸦ ��������� ��
			+ CHAR(����Ʈũ��)			: ���� ����(������ ������ �����͸� ���� ���)
												�� ������ ���̺��� ���� ������ ���� ����� ��� �������� ä���� ����
												�� �ִ� 2000 BYTE ���� ���� ����
			+ VARCHAR2(����Ʈũ��)		: ���� ����(�������� ���̰� ������ ���� ���� ���)
												�� ����Ǵ� ������ ���̸�ŭ�� ������ ���ȴ�.
												�� �ִ� 4000 BYTE ���� ���� ����
		- ����	: NUMBER
		- ��¥	: DATE, DATETIME, TIMESTAMP
*/
-- ȸ�� ������ ������ ���̺� ����
-- ���̺� �� : MEMBER
/*
	�÷� ����
	- ȸ�� ��ȣ			: NUMBER 
	- ȸ�� ���̵�			: VARCHAR2(20)
	- ȸ�� ��й�ȣ		: VARCHAR2(20)
	- ȸ�� �̸�			: VARCHAR2(20)
	- ȸ�� ����			: CHAR(3) -- �ѱ��� 3����Ʈ
	- ȸ�� �̸���			: VARCHAR2(20)
	- ȸ�� ����ó			: CHAR(13) -- �� �� 1����Ʈ
	- ������				: DATE
*/
CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	MEM_EMAIL VARCHAR2(20) NOT NULL,
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
);

-- �÷��� COMMNET �߰��ϱ�
/*
	COMMNET ON COLUMN ���̺��.�÷��� IS '����';
	
	�� �߸� �ۼ����� ��� �ٽ� �ۼ� �� ���� (���)
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ�� ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN MEMBER.MEM_PW IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ�� �̸�';
COMMENT ON COLUMN MEMBER.MEM_GENDER IS 'ȸ�� ����';
COMMENT ON COLUMN MEMBER.MEM_EMAIL IS 'ȸ�� �̸���';
COMMENT ON COLUMN MEMBER.MEM_PHONE IS 'ȸ�� ����ó';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '���� ��¥';

-- ���̺� ����
--DROP TABLE MEMBER;

-- ���̺� ������ �߰��ϱ�
INSERT INTO MEMBER VALUES(1, 'SEONG JUN', '1234', '�Ӽ���', '��', 'SJ@emil.com', '010-1234-5678', SYSDATE);

INSERT INTO MEMBER VALUES(2, 'HONG KI', '4321', '��ȫ��', '��', 'HK@emil.com', NULL, SYSDATE);
COMMIT; -- ������� ����
-- ������ ��ü ����
--DELETE FROM MEMBER;

/*
	* ��������
	- ���ϴ� ������ ���� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
	- ������ ���Ἲ�� �����ϱ� ���� ����
	
	- ���� ��� : �÷�������� / ���̺������
	
	- ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FORIGN KEY
*/
/*
	NOT NULL
	- �ش� �÷��� �ݵ�� ���� �����ؾ� �ϴ� ���
		�� ���� NULL ���� ����Ǹ� �ȵǴ� ���
		
	- ������ �߰�(����) / ���� �� NULL ���� ������� ����
	
	- �÷� ���� ������θ� ���� ����!!!
*/

-- ���̺�� : MEMBER_NOTNULL
-- ȸ����ȣ, ���̵�, ��й�ȣ, �̸��� ���� �����ʹ� NULL���� ������� �ʴ´�
CREATE TABLE MEMBER_NOTNULL (
	MEM_NO NUMBER NOT NULL,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
);

INSERT INTO MEMBER_NOTNULL VALUES(1, 'HONG123', '1234', 'ȫ�浿', '��', 'hong123@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_NOTNULL VALUES(2, 'MYU1234', '4321', '������', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_NOTNULL VALUES(3, NULL, '5621', '������', NULL, NULL, NULL, NULL);

INSERT INTO MEMBER_NOTNULL VALUES(1, 'HONG123', '1234', 'ȫ�浿', '��', 'hong123@emil.com', '010-1234-5678', SYSDATE);
-- �ߺ��Ǵ� �����Ͱ� �������� �߰��ǹǷ� ���ƾ��Ѵ�

/*
	* UNIQUE *
	- �ش� �÷��� �ߺ��� ���� ���� ��� �����ϴ� ��������
	
	�� ������ �߰�(����) / ���� �� ������ �ִ� ������ �� �� �ߺ��Ǵ� ���� ���� ��� ���� �߻�
*/
-- UNIQUE ���� ������ �߰��Ͽ� ���̺� ����
-- ���̺�� : MEMBER_UNIQUE
-- ȸ�� ���̵� �ߺ����� �ʵ��� ����
CREATE TABLE MEMBER_UNIQUE (
	MEM_NO NUMBER NOT NULL,
	MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
--	, UNIQUE (MEM_ID) -- ���̺���������� �ۼ�
);

INSERT INTO MEMBER_UNIQUE VALUES(1, 'HONG123', '1234', 'ȫ�浿', '��', 'hong123@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(2, 'MYU1234', '4321', '������', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_UNIQUE VALUES(3, NULL, '5621', '������', NULL, NULL, NULL, NULL);

INSERT INTO MEMBER_UNIQUE VALUES(1, 'HONG123', '1234', 'ȫ�浿', '��', 'hong123@emil.com', '010-1234-5678', SYSDATE);
-- ORA-00001: ���Ἲ ���� ����(C##KH.SYS_C008380)�� ����˴ϴ�
-- (C##KH.SYS_C008380) �� ������.�������Ǹ�
-- ���� ���� ���� �� �������Ǹ��� �������� ������ �ý��ۿ��� �ڵ����� �������!!!

/*
	* �������Ǹ� �����ϱ�
	[1] �÷� ���� ���
		CREATE TABLE ���̺��(
			�÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
		);
		
	[2] ���̺� ���� ���
		CREATE TABLE ���̺��(
			�÷��� �ڷ���,
			�÷��� �ڷ���,
			�÷��� �ڷ���,
			...,
			
			[CONSTRAINT �������Ǹ�] �������� �÷���
		);
*/
--DROP TABLE MEMBER_UNIQUE;
CREATE TABLE MEMBER_UNIQUE (
	MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
	MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,
	MEM_PW VARCHAR2(20) CONSTRAINT MEMPW_NT NOT NULL,
	MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
	, CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO MEMBER_UNIQUE VALUES(1, 'QQQQ', '1234', '�׽�Ʈ', '��', 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(2, 'TEST2', '4321', '�׽�Ʈ2', NULL, NULL, NULL, NULL);
SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE VALUES(3, 'QQQQ', '2222', '�׽�Ʈ3', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_UNIQUE VALUES(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- CHECK
/*
	CHECK(���ǽ�)
	- �ش� �÷��� ������ �� �ִ� ���� ���� ������ ����
	- ���ǿ� �����ϴ� ������ ������ �� ����
	�� ������ ������ �����ϰ��� �� �� ���
*/
-- CHECK ���� ������ �߰��� ���̺� ����
-- ���̺�� : MEMBER_CHECK
-- ���� �÷��� '��' �Ǵ� '��' �����͸� ����� �� �ֵ��� ����
CREATE TABLE MEMBER_CHECK (
	MEM_NO NUMBER NOT NULL,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3) CHECK(MEM_GENDER IN ('��', '��')),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
--	, CHECK(MEM_GENDER IN ('��', '��'))
);

INSERT INTO MEMBER_CHECK VALUES(1, 'TEST2', '4321', '�׽�Ʈ2', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_CHECK VALUES(2, 'QQQQ', '1234', '�׽�Ʈ', NULL, 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_CHECK VALUES(3, 'TEST23', '4321', '�׽�Ʈ2', '��', NULL, NULL, NULL);

/*
	PRIMARY KEY(�⺻Ű)
	- ���̺��� �� ���� �ĺ��ϱ� ���� ���Ǵ� �÷��� �ο��ϴ� ��������
	
	- NOT NULL + UNIQUE
*/
CREATE TABLE MEMBER_PRI (
	MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
	, CHECK(MEM_GENDER IN ('��', '��'))
);

INSERT INTO MEMBER_PRI VALUES(1, 'TEST2', '4321', '�׽�Ʈ2', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_PRI VALUES(2, 'QQQQ', '1234', '�׽�Ʈ', NULL, 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_PRI VALUES(2, 'TEST23', '4321', '�׽�Ʈ2', '��', NULL, NULL, NULL);
INSERT INTO MEMBER_PRI VALUES(NULL, 'TEST23', '4321', '�׽�Ʈ2', '��', NULL, NULL, NULL);

-- �� ���� �÷����� �⺻Ű�� �����Ͽ� ���̺� ����
-- ���̺�� : MEMBER_PRI2
-- ȸ����ȣ, ȸ�����̵� �⺻Ű�� ���� (����Ű)
CREATE TABLE MEMBER_PRI2 (
	MEM_NO NUMBER,
	MEM_ID VARCHAR2(20),
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) NOT NULL,
	MEM_GENDER CHAR(3),
	MEM_EMAIL VARCHAR2(20),
	MEM_PHONE CHAR(13),
	ENROLLDATE DATE
	
	,  CONSTRAINT MEMPRI2_PK PRIMARY KEY (MEM_NO, MEM_ID)
	, CHECK(MEM_GENDER IN ('��', '��'))
);

INSERT INTO MEMBER_PRI2 VALUES(1, 'TEST2', '4321', '�׽�Ʈ2', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_PRI2 VALUES(2, 'QQQQ', '1234', '�׽�Ʈ', NULL, 'test@emil.com', '010-1234-5678', SYSDATE);
INSERT INTO MEMBER_PRI2 VALUES(2, 'TEST23', '4321', '�׽�Ʈ2', '��', NULL, NULL, NULL);
INSERT INTO MEMBER_PRI2 VALUES(NULL, 'TEST23', '4321', '�׽�Ʈ2', '��', NULL, NULL, NULL);

-- � ȸ���� ��ǰ�� ��ٱ��Ͽ� ��� ������ �����ϴ� ���̺�
-- ȸ����ȣ, ��ǰ��, ���峯¥

CREATE TABLE MEMBER_LIKE (
	MEM_NO NUMBER,
	PRODUCT_NAME VARCHAR2(50),
	LIKE_DATE DATE,
	
	PRIMARY KEY (MEM_NO, PRODUCT_NAME)
);

INSERT INTO MEMBER_LIKE VALUES(1, 'Ű����', SYSDATE);
INSERT INTO MEMBER_LIKE VALUES(1, '���콺', SYSDATE);
INSERT INTO MEMBER_LIKE VALUES(2, 'Ű����', SYSDATE);

/*
	FOREIGN KEY (�ܷ�Ű)
	- �ٸ� ���̺��� �����ϴ� ���� �����ϰ��� �� �� ���Ǵ� ��������
		�� �ٸ� ���̺��� ����
		�� �ַ� �ܷ�Ű�� ���ؼ� ���̺� ���� ���踦 ����
		
	- �÷��������
		�÷��� [�ڷ���] REFERENCES ���������̺�� [(�������÷���)]
		
	- ���̺������
		FOREIGN KEY (�÷���) REFERENCES ���������̺�� [(�������÷���)]
	
	
	�� �������÷��� ���� �� �����ϴ� ���̺��� �⺻Ű �÷��� ��Ī��
*/
-- ȸ�� ��� ���� ���̺�
DROP TABLE MEMBER_GRADE;
CREATE TABLE MEMBER_GRADE (
	GRADE_NO NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '�Ϲ�ȸ��');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIPȸ��');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIPȸ��');

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	ENROLLDATE DATE,
	GRADE_ID REFERENCES MEMBER_GRADE -- NUMBER ���� ����
	
	, CHECK(MEM_GENDER IN ('��', '��'))
	
	-- ���̺� ���� ���
--	, FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER VALUES (1, 'qwer', 1234, '�Ӽ���', '��', SYSDATE, 300);
INSERT INTO MEMBER VALUES (2, 'asdf', '4321', 'ȫ�浿', '��', SYSDATE, 200);
INSERT INTO MEMBER VALUES (3, 'zxcv', '2222', '�ּ���', '��', SYSDATE, NULL);
-- �ܷ�Ű�� ������ �÷����� �⺻������ NULL ���� ���� ����
INSERT INTO MEMBER VALUES (4, 'zasd', '1111', '�ڼ���', '��', SYSDATE, 400);
-- ORA-02291: ���Ἲ ��������(C##KH.SYS_C008425)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
-- �� �����ϴ� ���̺� ������� ���� ���� ����� ��� ���� �߻�
-- MEMBER_GRADE (�θ����̺�) -|--------------------<- MEMBER (�ڽ����̺�)

INSERT INTO MEMBER VALUES (4, 'zasd', '1111', '�ڼ���', '��', SYSDATE, 100);
DELETE FROM MEMBER WHERE MEM_NO = 4;

-- �θ����̺�(MEMBER_GRADE)���� "�Ϲ�ȸ��" ����� �����Ѵٸ�?
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 300;
-- ORA-02292: ���Ἲ ��������(C##KH.SYS_C008425)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;

-- �ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ���
	-- �θ����̺�κ��� ������ ������ ���� �ʴ� "�����ɼ�"�� ����!
ROLLBACK;
/*
	�ܷ�Ű �������� - �����ɼ�
	- �θ����̺��� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� ��� �� �������� ���� �ɼ�
	
	- ON DELETE RESTRICTED (�⺻��) : �ڽ� ���̺�κ��� ������� ���� ���� ���
										�θ� ���̺��� �����͸� ���� �Ұ�
	- ON DELETE SET NULL : �θ� ���̺� �ִ� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ� ���̺� ���� NULL�� ����
	
	- ON DELETE CASCADE : �θ� ���̺� �ִ� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ� ���̺� ���� ����
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	ENROLLDATE DATE,
	GRADE_ID -- NUMBER ���� ����
	
	, CHECK(MEM_GENDER IN ('��', '��'))
	
	-- ���̺� ���� ���
	, FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
);

INSERT INTO MEMBER VALUES (1, 'qwer', 1234, '�Ӽ���', '��', SYSDATE, 100);
INSERT INTO MEMBER VALUES (2, 'asdf', '4321', 'ȫ�浿', '��', SYSDATE, 200);
INSERT INTO MEMBER VALUES (3, 'zxcv', '2222', '�ּ���', '��', SYSDATE, NULL);

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
SELECT * FROM MEMBER;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
	MEM_PW VARCHAR2(20) NOT NULL,
	MEM_NAME VARCHAR2(20) DEFAULT 'UNKNOWN',
	MEM_GENDER CHAR(3) NOT NULL,
	ENROLLDATE DATE,
	GRADE_ID -- NUMBER ���� ����
	
	, CHECK(MEM_GENDER IN ('��', '��'))
	
	-- ���̺� ���� ���
	, FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
);

INSERT INTO MEMBER VALUES (1, 'qwer', 1234, '�Ӽ���', '��', SYSDATE, 100);
INSERT INTO MEMBER VALUES (2, 'asdf', '4321', 'ȫ�浿', '��', SYSDATE, 200);
INSERT INTO MEMBER VALUES (3, 'zxcv', '2222', '�ּ���', '��', SYSDATE, NULL);

SELECT * FROM MEMBER;

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;

/*
	�⺻��(DEFAULT)
	- ���������� �ƴ�!
	- �÷��� �������� �ʰ� ������ �߰� �� NULL ���� �߰��Ǵµ� �̶�, NULL���� �ƴ� �ٸ� ������ �����ϰ��� �� ��
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	MEM_NO NUMBER PRIMARY KEY,
	MEM_NAME VARCHAR2(20) NOT NULL,
	AGE NUMBER,
	HOBBY VARCHAR2(30) DEFAULT '��̾���',
	ENROLLDATE DATE
);

INSERT INTO MEMBER VALUES (1, '�ο�', 24, '���ǰ���', SYSDATE);
INSERT INTO MEMBER VALUES (2, '����', 23, '����', NULL);
INSERT INTO MEMBER VALUES (3, '����', 26, NULL, SYSDATE);
INSERT INTO MEMBER (MEM_NO, MEM_NAME) VALUES (4, '����');
-- �������� ���� �÷��� ���� ���� �⺻������ NULL���� �����
-- ��, �ش� �÷��� �⺻���� �����Ǿ� ���� ��� NULL ���� �ƴ� �⺻������ �����
-- =====================================================================
-- ���̺� ����
/*
	CREATE TABLE AS ��������;
	
	���������� ����� ���̺� ����
	- ������ �� �� ���������� �߰����� ����
*/

-- MEMBER ���̺���
CREATE TABLE MEMBER_COPY AS (
	SELECT * FROM MEMBER
);

/*
	���̺��� ��������� �����ϰ��� �� �� �� ALTER TABLE
	
		ALTER TABLE ���̺�� ������ ����
		
	[������ ����]�� �ۼ�	
	- UNIQUE : ADD UNIQUE(�÷���);
	- CHECK : ADD CHECK(���ǽ�);
	- PRIMARY KEY : ADD PRIMARY KEY (�÷���);
	- FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ���������̺�� [(�������÷���)];
	
	- NOT NULL : MODIFY �÷��� NOT NULL;
	- DEFAULT �ɼ� : MODIFY �÷��� DEAFULT �⺻��;
*/
-- MEMBER_COPY ���̺� ȸ����ȣ �÷��� �⺻Ű ����
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY (MEM_NO);

-- MEMBER_COPY ���̺� HOBBY �÷��� �⺻�� ����
ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '����';