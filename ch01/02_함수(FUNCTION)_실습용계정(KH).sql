/*
	�Լ�(FUNCTION)
	- ���޵� �÷� ���� �о �Լ��� ������ ����� ��ȯ
	
	- ������ �Լ�
		�� ���� ���� ���� �о ���� ���� ��� ���� ���� (�� ���� �Լ��� ������ ����� ��ȯ)
	- �׷��Լ�
		�� ���� ���� ���� �о 1���� ��� ���� ����(�׷��� ���� �׷� ���� �Լ��� ������ ����� ��ȯ)
		
	SELECT ���� ������ �Լ��� �׷��Լ��� ��� ���� ������ �޶� ���ÿ� ����� �� ����.
	
	�Լ����� ����ϴ� ��ġ : FROM ���� ������ ��� ������ ��� ����
*/

-- ==============================================================
/* ������ �Լ�

	���� Ÿ���� ������ ó�� �Լ�
	VARCHAR2(n), CHAR(n)
	
	LENGTH(�÷��� �Ǵ� '���ڿ�') : �ش� ���ڿ��� ���� ���� ��ȯ
	LENGTHB(�÷��� �Ǵ� '���ڿ�') : �ش� ���ڿ��� ����Ʈ �� ��ȯ
	
	�� ������, ����, Ư������ : ���ڴ� 1byte
		�ѱ� : ���ڴ� 3byte
*/

-- '����Ŭ' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ��
SELECT LENGTH('����Ŭ') AS "���ڼ�", LENGTHB('����Ŭ') AS "����Ʈ��"
FROM DUAL;

-- 'ORACLE' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ��
SELECT LENGTH('ORACLE') AS "���ڼ�", LENGTHB('ORACLE') AS "����Ʈ��"
FROM DUAL;

-- ����������� �����, ������� ���ڼ�, ������� ����Ʈ��, �̸���, �̸����� ���ڼ�, �̸����� ����Ʈ�� Ȯ��
SELECT EMP_NAME AS "�����", LENGTH(EMP_NAME) AS "������� ���ڼ�", LENGTHB(EMP_NAME) AS "������� ����Ʈ ��",
			EMAIL AS "�̸���", LENGTH(EMAIL) AS "�̸����� ���ڼ�", LENGTHB(EMAIL) AS "�̸����� ����Ʈ��"
FROM EMPLOYEE;

-- ==============================================================
/*
	INSTR
	- ���ڿ��κ��� Ư�� ������ ������ġ�� ��ȯ
	
	[ǥ����]
		INSTR(�÷� �Ǵ� '���ڿ�', 'ã�����ϴ� ����'[, ã�� ��ġ�� ���۰�, ����])
		�� �Լ� ���� ������� NUMBER Ÿ��
		
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- ���� ���� �ָ� �ڿ������� ã�� ������� �տ������� �������� ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;

-- ��� ���� �� �̸���, �̸����� '_'�� ù ��° ��ġ, �̸����� '@'�� ù ��° ��ġ ��ȸ
SELECT EMAIL, INSTR(EMAIL, '_') AS " '_'�� ù ��° ��ġ", INSTR(EMAIL, '@') AS " '@'�� ù ��° ��ġ"
FROM EMPLOYEE;

-- ==============================================================
/*
	SUBSTR : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
	
	[ǥ����]
		SUBSTR('���ڿ�' �Ǵ� �÷�, ������ġ[, ����(����)])
		�� ���̸� �����ϸ� ������ġ���� ������ ����!
	
*/

SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER', 12) FROM DUAL;

-- SQL�� ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL;

SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL; -- �ڿ������� 3��°

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL;

-- ����� �� ��������� �̸�, �ֹι�ȣ ��ȸ
SELECT EMP_NAME AS "�����", EMP_NO AS "�ֹι�ȣ"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4'); -- ���ڷ� �ϸ� ���ڷ� �ڵ����� �ٲ���. ������ ��Ȯ�ϰ� �ϱ����ؼ� ����Ÿ������ ���ִ°��� ����

SELECT EMP_NAME AS "�����", EMP_NO AS "�ֹι�ȣ"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('1', '3')
ORDER BY ����� ASC;

-- �Լ��� ��ø ��� ����!!
-- ��� ���� �� �����, �̸���, ���̵� ��ȸ (���⼭ ���̵�� �̸����� '@' �տ�����)
SELECT EMP_NAME AS "�����", EMAIL AS "�̸���", SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS "���̵�"
FROM EMPLOYEE;