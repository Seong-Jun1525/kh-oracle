/*
��ĭ�� ������ �ܾ �ۼ��Ͻÿ�.
(DDL) :CREATE, ALTER, DROP

(DML): INSERT,DELETE,UPDATE

(DQL): SELECT

-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  TEST250305 / test0305
-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.
-- �� �÷��� ������ �߰����ּ���.
-- ���� �����͸� �߰��ϱ� ���� ���� �������� �ۼ����ּ���.
--  ex) ����: �ﱹ��, ����: ����, ������: 14/02/14, ISBN : 9780394502946

------------------------------------------------------------
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/
------------------------------------------------------------
DROP TABLE BOOK;
CREATE TABLE BOOK (
	BK_NO NUMBER PRIMARY KEY,
	BK_TITLE VARCHAR2(200) NOT NULL,
	BK_AUTHOR VARCHAR2(20) NOT NULL,
	BK_PUBLICATION_DATE DATE,
	BK_ISBN VARCHAR2(20) CONSTRAINT ISBN_UQ UNIQUE
);

COMMENT ON COLUMN BOOK.BK_NO IS '���� ��ȣ';
COMMENT ON COLUMN BOOK.BK_TITLE IS '����';
COMMENT ON COLUMN BOOK.BK_AUTHOR IS '����';
COMMENT ON COLUMN BOOK.BK_PUBLICATION_DATE IS '������';
COMMENT ON COLUMN BOOK.BK_ISBN IS 'ISBN ��ȣ';

INSERT INTO BOOK VALUES (1, '�ﱹ��', '����', '14/02/14', 9780394502946);

-- �⺻Ű NOT NULL üũ
INSERT INTO BOOK VALUES (NULL, '�ﱹ��', '����', '14/02/14', NULL);
-- �⺻Ű �ߺ� üũ
INSERT INTO BOOK VALUES (1, '�ﱹ��', '����', '14/02/14', 9780394502946);

-- NOT NULL üũ
INSERT INTO BOOK VALUES (2, '�ﱹ��', NULL, '14/02/14', 9780394502946);
INSERT INTO BOOK VALUES (3, NULL, '����', '14/02/14', 9780394502946);
COMMIT;

SELECT * FROM BOOK;