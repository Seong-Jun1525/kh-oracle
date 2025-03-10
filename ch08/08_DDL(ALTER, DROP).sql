/*
	DDL ������ ���� ���
	
	��ü���� ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ���
*/
------------------------------------------------------------------------------------------------------
/*
	ALTER : ��ü �����ϴ� ����
	
	- ���̺� ���� ����
	
	[ǥ����]
		ALTER TABLE ���̺�� �����ҳ���
		
	����Ǵ� ����
		- �÷� �߰� / ���� / ����
		- �������� �߰� / ����				�� ���� �Ұ� (������ �ʿ��� ��� �����ϰ� �ٽ� ������ ��)
		- �÷��� / �������Ǹ� / ���̺�� ����
*/

/*
	�÷� �߰� 

	ADD �÷��� ������Ÿ�� [DEFAULT �⺻��] [��������];
*/
-- DEPT_TABLE ���̺� CNAME VARCHAR2(20) �÷��߰�
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);

-- �� ���ο� �÷��� �߰��ǰ�, �⺻������ NULL ������ ä����

-- DEPT_TABLE ���̺� LNAME VARCHAR2(20) �÷� �߰�, �⺻���� ���� : '�ѱ�'
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

------------------------------------------------------------------------------------------------------

/*
	�÷� ����(MODIFY)
		- ������ Ÿ�� ���� : MODIFY �÷��� ������ ������Ÿ��;
		- �⺻�� ����		 : MODIFY �÷��� DEFAULT ������ �⺻��;
*/

-- DEPT_TABLE ���̺��� DEPT_ID �÷��� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);

-- ������ Ÿ�� : ���� Ÿ������ ���� CHAR(5) �� NUMBER
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;
/*
	ORA-01439: ������ ������ ������ ���� ��� �־�� �մϴ�
	01439. 00000 -  "column to be modified must be empty to change datatype"
	
	���� ���� �߻�! (���� ����Ÿ�Կ��� ����Ÿ������ ���� X)
	������ ������ ���ٸ� �����
*/
-- DEPT_TABLE ���̺��� DEPT_TITLE �÷� ����
-- ������Ÿ�� VARCHAR2(35) �� VARCHAR2(10)
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10);
/*
	ORA-01441: �Ϻ� ���� �ʹ� Ŀ�� �� ���̸� ���� �� ����
	01441. 00000 -  "cannot decrease column length because some value is too big"
	
	�̹� ����� ������ ���� �� ũ�⸦ �������� ����Ǿ� �����Ƿ�
	������ �ս��� �� �� ���� ������ ������ �ȵȴ�
*/
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(50); -- �� ū ũ��δ� ������ �����ϴ�

-- EMP_TABLE�� SALARY �÷��� ����
-- NUMBER  �� VARCHAR2(50)
ALTER TABLE EMP_TABLE MODIFY SALARY VARCHAR2(50);
/*
	ORA-01439: ������ ������ ������ ���� ��� �־�� �մϴ�
	01439. 00000 -  "column to be modified must be empty to change datatype"
	
	��ȯ�� ������ ������Ÿ���̴��� �����Ͱ� �ִٸ� ������ �� ����
*/

-- ���� ���� �÷� ���� ����!!
-- DEPT_TABLE ���̺��� DEPT_TITLE �÷��� VARCHAR2(55),
-- 						LNAME �÷��� �⺻���� '�ڸ���'�� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(55)
							MODIFY LNAME DEFAULT '�ڸ���';
						
------------------------------------------------------------------------------------------------------	
/*
	�÷� ����
	
	DROP COLUMN ����
*/
--DEPT_TABLE ���̺��� DEPT_COPY ���̺�� ���� 
CREATE TABLE DEPT_COPY
AS (SELECT * FROM DEPT_TABLE);

-- DEPT_COPY ���̺��� LNAME �÷� ����
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
-- ���̺��� �ּ��� �� ���� �÷��� �����ؾ��� 


/*
	�������� �߰� / ����
	
	-- �������� �߰�
	-- �⺻Ű (PRIMARY KEY) : ADD PRIMARY KEY (�÷���);
	-- �ܷ�Ű (FOREIGN KEY) : ADD FOREIGN KEY (�÷���) REFERENCES ������ ���̺�� ([������ �÷���]);
	-- UNIQUE 				: ADD UNIQUE(�÷���)
	-- CHECK 				: ADD CHECK (�÷��� ���� ���ǽ�) Ư�� ���鸸 �����ϰ��� �� �� ���! NULL ���� ���� ����
	-- NOT NULL				: MODIFY �÷��� NOT NULL |NULL ���� ������� ������ ���� ��������
	
	�������Ǹ��� �����ϰ��� �Ѵٸ� CONSTRAINT �������Ǹ� �߰�	
*/

-- DEPT_TABLE ���̺�
-- DEPT_ID �÷��� �⺻Ű �߰�
-- DEPT_TITLE �÷��� UNIQUE �߰�
-- LNAME �÷��� NOT NULL �߰�

ALTER TABLE DEPT_TABLE ADD CONSTRAINT DT_PK PRIMARY KEY (DEPT_ID)
							ADD CONSTRAINT DT_UQ UNIQUE (DEPT_TITLE)
							MODIFY LNAME NOT NULL;

/*
	�������� ����
	DROP CONSTRAINT �������Ǹ�
	MODIFY �÷��� NULL(NOT NULL ������ NULL�� ����)

*/
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_UQ
								MODIFY LNAME NULL;

/*
	�÷���, �������Ǹ�, ���̺�� ����(RENAME)
*/
-- 1) �÷��� : RENAME COLUMN ���� �÷��� TO ������ �÷���
--DEPT_TABLE ���̺��� DEPT_TITLE �÷��� �̸��� DEPT_NAME���� ����
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 2) �������Ǹ� ���� : RENAME CONSTRAINT ���� �������Ǹ� TO �������������Ǹ�
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008469 TO DT_DEPTID_NN;

-- 3) ���̺�� ���� : RENAME TO ������ ���̺� ��
ALTER TABLE DEPT_TABLE RENAME TO DEPT_END;

/*
	DROP : ��ü�� �����ϰ��� �� �� ����ϴ� ����
	
	- ���̺� ����
		DROP TABLE ���̺��
*/
--DROP TABLE DEPT_END;
-- ��򰡿� �����ǰ� �ִ� �θ����̺��� ������ ���� ����
-- ������� �� ���, 1) �ڽ����̺� ���� �� �θ����̺� ����
-- 					2) �θ����̺� ������ �� �������� ���� ���� DROP TABLE ���̺�� CASCADE CONSTRAINT
