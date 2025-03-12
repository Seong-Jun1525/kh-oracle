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

-- ��� ���� �� �̸���, �̸����� '_'�� ù ��° ��ġ, �̸����� '@'�� ù ��° ��ġ, '_' ������ ����Ʈ ũ�� ��ȸ
SELECT EMAIL, INSTR(EMAIL, '_') AS " '_'�� ù ��° ��ġ", INSTR(EMAIL, '@') AS " '@'�� ù ��° ��ġ", INSTRB(EMAIL, '_') AS " '_' ������ ����Ʈ ũ��"
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
-- ==============================================================
/*
	LPAD / RPAD : ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
		
	[ǥ����]
		LPAD(���ڿ� �Ǵ� �÷�, �� ����[, '�����Ϲ���']) �� ���ʿ� ������ ���ڸ� ����Ͽ� ä��
		RPAD(���ڿ� �Ǵ� �÷�, �� ����[, '�����Ϲ���']) �� �����ʿ� ������ ���ڸ� ����Ͽ� ä��
		�� ������ ���ڸ� ������ ��� �������� ä����
*/

-- ��� ���� �� ������� ���ʿ� ������ ä���� 20���̷� ��ȸ
SELECT EMP_NAME AS "�����", LPAD(EMP_NAME, 20)
FROM EMPLOYEE;

-- ��� ���� �� ������� �����ʿ� ������ ä���� 20���̷� ��ȸ
SELECT EMP_NAME AS "�����", RPAD(EMP_NAME, 20)  AS "�����"
FROM EMPLOYEE;

-- ��� ���� �� �����, �̸��� ��ȸ(�̸��� ������ ����, �ѱ��� 20)
SELECT EMP_NAME AS "�����", LPAD(EMAIL, 20) AS "EMAIL"
FROM EMPLOYEE;

-- �������� '#'
SELECT EMP_NAME, LPAD(EMAIL, 20, '#')  AS "EMAIL"
FROM EMPLOYEE;

SELECT '000201-1', RPAD('000201-1', 14, '*') FROM DUAL;

-- ��� ���� �� �����, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� 'XXXXXX-X******'
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

-- ==============================================================
/*
	LTRIM / RTRIM : ���ڿ����� Ư�� ���ڸ� ������ �� �������� ��ȯ
	
	[ǥ����]
		LTRIM(���ڿ� �Ǵ� �÷�[, '�����ҹ��ڵ�'])
		RTRIM(���ڿ� �Ǵ� �÷�[, '�����ҹ��ڵ�'])
		�� ������ ���ڸ� �������� ���� ��� ������ ��������
*/

SELECT LTRIM('     H I') FROM DUAL; -- ���ʺ��� �ٸ����ڰ� ���ö����� ���� ����
SELECT RTRIM('H     I	  ') FROM DUAL; --  �����ʺ��� �ٸ� ���ڰ� ���ö����� ���� ����

SELECT LTRIM('123123H123', '123') FROM DUAL; -- '123'�̶�� �ؼ� �� 123�� �������°� �ƴ϶� '1', '2', '3' �̷��� ������ �� �� ������
SELECT RTRIM('123123H123', '123') FROM DUAL;

SELECT LTRIM('KKHHII', '123') FROM DUAL
/*
	TRIM : ���ڿ� �� / �� / ���ʿ� �ִ� ������ ���ڵ��� ������ �� ������ ���� ��ȯ
	
	[ǥ����]
		TRIM([LEADING | TRAILING | BOTH] [�����ҹ��� FROM] ���ڿ� �Ǵ� �÷�)
		ù ��° �ɼ� ���� �� �⺻���� BOTH
		������ ���� ���� �� ������ ����
*/;

SELECT TRIM('    H     I       ') FROM DUAL; -- TAB�� �������� �νĵ��� ����!

-- 'LLLLLHLLLLL'
SELECT TRIM('L' FROM 'LLLLLHLLLLL') FROM DUAL;
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLLLLL') FROM DUAL;
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLLLLL') FROM DUAL;

-- ==============================================================
/*
	LOWER / UPPER / INITCAP
	
	LOWER : ���ڿ��� ��� �ҹ��ڷ� �����Ͽ� ��� ��ȯ
	UPPER : ���ڿ��� ��� �빮�ڷ� �����Ͽ� ��� ��ȯ
	INITCAP : ���⸦ �������� ù ���ڸ��� �빮�ڷ� �����Ͽ� �����ȯ
*/
-- 'Oh My God'
SELECT LOWER('Oh My God') FROM DUAL;
SELECT UPPER('Oh My God') FROM DUAL;
SELECT INITCAP('Oh My God') FROM DUAL;

/*
	CONCAT : ���ڿ� �� ���� �ϳ��� ���ڿ��� ��ģ �� ��ȯ
	
	[ǥ����]
		CONCAT(���ڿ�1, ���ڿ�2)
*/
SELECT 'KH' || ' A������' FROM DUAL;
SELECT CONCAT('KH', ' A������') FROM DUAL;

SELECT CONCAT(EMP_NAME, '��') AS "�����" FROM EMPLOYEE;

SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '��')) AS "�����" FROM EMPLOYEE;

/*
	REPLACE : ���ڿ����� Ư�� �κ��� ������ ���ڿ��� ��ü�Ͽ� ��ȯ
	
	[ǥ����]
		REPLACE(���ڿ�, ã�����ڿ�, �����ҹ��ڿ�)
*/

SELECT REPLACE('����� ������', '����', '����') AS "����" FROM DUAL;

-- ��� ���� �� �̸��� �������� '@kh.or.kr' �κ��� '@gmail.com'���� �����Ͽ� ��ȸ
SELECT EMAIL, REPLACE(EMAIL,  '@kh.or.kr',  '@gmail.com') AS "�̸���" FROM EMPLOYEE;
-- ==============================================================
/*
	NUMBER Ÿ��
	ABS : ������ ���밪�� �����ִ� �Լ�
*/
SELECT ABS(-100) FROM DUAL;
SELECT ABS(-12.34) FROM DUAL;
-- ==============================================================
/*
	MOD: �� ���� ������ ���� �����ִ� �Լ�
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
-- ==============================================================
/*
	ROUND : �ݿø��� ���� �����ִ� �Լ�
	
	[ǥ����]
	ROUND(����[, �Ҽ��� ��ġ]) : �Ҽ��� ��ġ���� �ݿø��� ���� ������. ���� �� ù��° ��ġ���� �ݿø�
	
	�� �Ҽ����� ��ġ�� ����� ��� �Ҽ��� �ڷ� �� ĭ �� �̵�
	�� �Ҽ����� ��ġ�� ������ ��� �Ҽ��� ������ �� ĭ �� �̵�
*/

SELECT ROUND(3.141592, 3) FROM DUAL;
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
-- ==============================================================
/*
	CEIL : �ø�ó��
	FLOOR : ����ó��
*/

SELECT CEIL(123.456) FROM DUAL;
SELECT FLOOR(123.456) FROM DUAL;

/*
	TRUNC : ����ó�� �� ����� ��ȯ���ִ� �Լ�. (��ġ ���� ����)
	
	�� ��ġ���� ����� ��� �Ҽ��� ���ʿ��� ����
	�� ��ġ���� ������ ��� �Ҽ��� ���ʿ��� ����
*/
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -2) FROM DUAL;
-- ==============================================================
/*
	[��¥ Ÿ�� ���� �Լ�]
	SYSDATE : �ý����� ���� ��¥ �� �ð��� ��ȯ
	
	MONTHS BETWEEN : �� ��¥ ������ ������
	
	[ǥ����]
		MONTHS_BETWEEN(��¥A, ��¥B) : ��¥A - ��¥B
*/
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/31') || '������' FROM DUAL; -- ������ �Ҽ������� ��µǹǷ� �ø�ó�� ������Ѵ�
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/12/31')) FROM DUAL;

SELECT FLOOR(MONTHS_BETWEEN('25/6/18', SYSDATE)) FROM DUAL;

-- ��� ���� �� �����, �Ի���, �ټӰ����� ��ȸ
SELECT EMP_NAME AS "�����", HIRE_DATE AS "�Ի���", CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "�ټӰ�����"
FROM EMPLOYEE
--WHERE ENT_DATE IS NULL;
WHERE ENT_YN = 'N'
ORDER BY �ټӰ����� DESC;

/*
	ADD_MONTHS : Ư�� ��¥�� N���� ���� ���ؼ� ��ȯ
	[ǥ����]
		ADD_MONTHS(��¥, ���Ұ�����)
*/
SELECT SYSDATE AS "���糯¥", ADD_MONTHS(SYSDATE, 3) AS "3���� ��" FROM DUAL;

-- ��� ���� �� �����, �Ի���, ���������� ��ȸ
-- �����Ⱓ : �Ի��� + 3
SELECT EMP_NAME AS "�����", HIRE_DATE AS "�Ի���", ADD_MONTHS(HIRE_DATE, 3) AS "����������"
FROM EMPLOYEE;

/*
	NEXT_DAY :  Ư�� ��¥ ���� ������ ������ ���� ����� ��¥�� ��ȯ
	
	[ǥ����]
		NEXT_DAT(��¥, ����)
		- ���� �� ���� �Ǵ� ����
		1: ��, 2: ��, ... 7: ��

*/

SELECT NEXT_DAY(SYSDATE, 1) AS "���糯¥�� ���� ����� �Ͽ���" FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') AS "���糯¥�� ���� ����� �Ͽ���" FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') AS "���糯¥�� ���� ����� �Ͽ���" FROM DUAL;
--SELECT NEXT_DAT(SYSDATE, 'SUNDAY') AS "���糯¥�� ���� ����� �Ͽ���" FROM DUAL; 
-- ���� Ÿ���� ���� �� ��� ������ ���� ����� �� ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUN') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

/*
	LAST_DAY : �ش� ���� ������ ��¥�� ��ȯ���ִ� �Լ�
*/

SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT 
EMP_NAME AS "�����", 
HIRE_DATE AS "�Ի���", 
LAST_DAY(HIRE_DATE) AS "�Ի��� ���� ������ ��¥", 
LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 AS "�Ի��� ���� �ٹ��� �� ��ȸ"
FROM EMPLOYEE;

/*
	EXTRACT : Ư�� ��¥�κ��� ����/��/�� ���� �����Ͽ� ��ȯ���ִ� �Լ�

	[ǥ����]
	EXTRACT((YEAR | MONTH | DAY) FROM ��¥) : �ش� ��¥�� ������ ����
*/

-- ���糯¥�� ����/��/���� ���� �����Ͽ� ��ȸ
SELECT SYSDATE,
		EXTRACT(YEAR FROM SYSDATE) AS "����", 
		EXTRACT(MONTH FROM SYSDATE) AS "��",
		EXTRACT(DAY FROM SYSDATE) AS "��"
FROM DUAL;

-- ������� �� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT 
	EMP_NAME AS "�����", 
	EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵", 
	EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��",  
	EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY �Ի�⵵ ASC, �Ի�� ASC, �Ի��� ASC;
-- ==============================================================
/*
	����ȯ �Լ� : ������ Ÿ���� �������ִ� �Լ�
*/

/*
	TO_CHAR : ���� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ �������ִ� �Լ�
	
	[ǥ����]
	TO_CHAR(���� �Ǵ� ��¥[, ����])
*/

-- ����Ÿ���� ����Ÿ������ ����
SELECT 1234 AS "����Ÿ���� ������", TO_CHAR(1234) AS "����Ÿ������ ����ȯ" FROM DUAL;

SELECT TO_CHAR(1234) AS "Ÿ�� ���游 �� ������", TO_CHAR(1234, '999999') AS "��������������" FROM DUAL;
-- �� 9 : ������ŭ �ڸ����� Ȯ���ؼ� ���ڸ��� �������� ä���. ������ ���ĵȰ� ó�� ���̰� ��

SELECT TO_CHAR(1234) AS "Ÿ�� ���游 �� ������", TO_CHAR(1234, '000000') AS "��������������" FROM DUAL;
-- �� 0 : ������ŭ �ڸ����� Ȯ���ؼ� ���ڸ��� 0���� ä���. ������ ���ĵȰ� ó�� ���̰� ��

SELECT TO_CHAR(1234, 'L999999')  AS "���˵�����" FROM DUAL;
-- �� L : ���� ������ ������ ���� ȭ������� ǥ��.

SELECT TO_CHAR(1234, '$999999') AS "���˵�����" FROM DUAL;

SELECT 1000000, TO_CHAR(1000000, 'L9,999,999') AS "���˵�����" FROM DUAL;

-- ������� �����, ����, ������ ��ȸ(���ް� ������ ȭ������� ǥ�����ְ� 3�ڸ��� �������� ǥ���ϱ�)
SELECT EMP_NAME AS "�����", TO_CHAR(SALARY, 'L999,999,999') AS "����", TO_CHAR(SALARY * 12, 'L999,999,999') AS "����"
FROM EMPLOYEE;
-- ==============================================================
-- ��¥ Ÿ�� �� ����Ÿ��
SELECT SYSDATE, TO_CHAR(SYSDATE) AS "���ڷ� ��ȯ" FROM DUAL;
/*
	�ð� ���� ����
	
	- HH : �� ����(HOUR) �� 12�ð���
	- HH24 �� 24�ð���
	
	- MI : �� ����(MINUTE)
	- SS : �� ����(SECOND)
*/
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; -- 12�ð���
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 12�ð���

SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
-- �� AM / PM �� ���� ���ĸ� ǥ��

/*
	���� ���� ����
	
	- DAY : X���� �� ������, ȭ����, ...
	
	- DY : ��, ȭ, ��, ...
	
	- D : ���Ͽ� ���ؼ� ����Ÿ������ ǥ��(1 : �Ͽ���, 2: ������, ...7: �����)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY D') FROM DUAL;

/*
	�� ���� ����
	- MON, MONTH: X�� �� 1��, 2��, 3��, ...
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH') FROM DUAL;

/*
	�� ���� ����
	
	- DD : �� ������ 2�ڸ��� ǥ��
	- DDD : �ش� ��¥�� �ش�⵵ ���� �� ��° �ϼ�
*/
SELECT TO_CHAR(SYSDATE, 'DD') AS "2�ڸ� ǥ��", TO_CHAR(SYSDATE, 'DDD') AS "�� ��° ��"
FROM DUAL;

/*
	�⵵ ���� ����
	- YYYY : �⵵�� 4�ڸ��� ǥ��
	- YY: �⵵�� 2�ڸ��� ǥ��
	
	- RRRR: �⵵�� 4�ڸ��� ǥ��
	- RR: �⵵�� 2�ڸ��� ǥ��
	�� �Էµ� ������ 00 ~ 49�� ��
			�� ���� ������ �� ���ڸ��� 00 ~ 49
				�� ��ȯ�� ������ �� �θ��� ���� ������ ����
			�� ���� ������ �� ���ڸ��� 50 ~ 99
				�� ��ȯ�� ������ �� ���ڸ��� ���� ������ �� ���ڸ��� + 1
				
	�� �Էµ� ������ 50 ~ 99�� ��
			�� ���翬���� �� ���ڸ��� 00 ~ 49
				�� ��ȯ�� ������ �� ���ڸ��� ���� ������ �� �� �ڸ� - 1
			�� ���� ������ �� ���ڸ��� 50 ~ 99
				�� ��ȯ�� ������ �� ���ڸ��� ���� ������ ����	
*/
SELECT TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY') AS "RR ���(50�̸�)",
			TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY') AS "RR ���(50�̻�)",
			TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY') AS "YY ���(50�̻�)",
			TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY') AS "YY ���(50�̻�)"
FROM DUAL;
-- EX) ȸ������ �� 1900 ��� ���� ��� ���� ó�� �����͸� �ҷ����� 85����� 2085���� �ҷ������Ƿ� �̷� ��쿡�� RR�� ����ؾ���

-- ��� ���� �� �����, �Ի糯¥ ��ȸ
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') AS "�Ի糯¥"
FROM EMPLOYEE;
-- ǥ���� ����(����) �κ��� ū ����ǥ("")�� ��� ���Ͽ� �ݿ��ؾ� ��

/*
	TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �������ִ� �Լ�
	
	[ǥ����]
		TO_DATE(���� �Ǵ� ����[, ����])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL; -- �� 50�� �̸��� �ڵ����� 20XX���� �����
SELECT TO_DATE(550304) FROM DUAL; -- �� 50�� �̻��� �ڵ����� 19XX���� �����

SELECT TO_DATE(020222) FROM DUAL; -- �� ���ڴ� 0���� �����ϸ� �ȵ�. �̷� ���� ����Ÿ������ �����ؾ���
SELECT TO_DATE('020222') FROM DUAL;

SELECT TO_DATE('20250304 104230') FROM DUAL; -- �� �ð��� �����ϴ� ��쿡�� ������ �����ؾ���
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS') FROM DUAL;

-- ==============================================================
/*
	TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ����
	
	[ǥ����]
		TO_NUMBER(����[, ����])
		�� ��ȣ�� ȭ������� �����ϴ� ��� ������ ����
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;
SELECT '10000' + '500' FROM DUAL; -- ORACLE�� ���� �� ���� ��ȯ�Ǿ� ��������� �����
SELECT '10,000' + '500' FROM DUAL; -- �����߻�

SELECT TO_NUMBER('10,000', '999,999') + TO_NUMBER('500', '999,999') FROM DUAL;
-- ==============================================================
/*
	NULL ó�� �Լ�
*/
/*
	NVL : �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� �������ִ� �Լ�
	
	[ǥ����]
		NVL(�÷���, �ش��÷��� ���� NULL�� ��� ����� ��)
*/

-- ��� ���� �� �����, ���ʽ� ������ ��ȸ
-- (��, ���ʽ� ���� NULL�� ��� 0���� ǥ��)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ��� ���� �� �����, ���ʽ�, ����, ���ʽ� ���� ������ ��ȸ
SELECT EMP_NAME, NVL(BONUS, 0), SALARY * 12 AS "����", (SALARY + (SALARY * NVL(BONUS, 0))) * 12 AS "���ʽ� ���� ����"
FROM EMPLOYEE;

/*
	NVL2 : �ش� �÷��� ���� NULL�� ��� ǥ���� ���� �����ϰ�, NULL�� �ƴ� ��� ǥ���� ���� ������ �� �ִ� �Լ�

	[ǥ����]
		NVL2(�÷���, �����Ͱ� �����ϴ� ��� ����� ��, NULL�� ��� ����� ��)
*/
-- ��� ���� �� �����, ���ʽ� ���� ��ȸ(���ʽ��� ���� ��� 'O' ���� ��� 'X' ǥ��)
SELECT EMP_NAME AS "�����", NVL2(BONUS, 'O', 'X') AS "���ʽ� ����"
FROM EMPLOYEE;

-- ��� ���� �� �����, �μ��ڵ�, �μ���ġ���� ��ȸ (��ġ�� �� ��� '�����Ϸ�', ��ġ���� ���� ��� '�̹���' ǥ��)
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') AS "�μ���ġ����"
FROM EMPLOYEE;

/*
	NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ� �ٸ� �񱳴��1 ��ȯ

	[ǥ����]
		NULLIF(�񱳴��1, �񱳴��2)
*/
SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '555') FROM DUAL;

-- ==============================================================
/*
	�����Լ�
		DECODE(�񱳴��, �񱳰�1, �����1, �񱳰�2, �����2, ...)
		
	�� switch���� ������
*/
-- ==============================================================
-- ������� �� ���, �����, �ֹι�ȣ, ���� ��ȸ
-- ��, ������ 1�� ��� ��, 2�� ��� ��, �׿� �˼�����
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', 2, '��', '�˼�����') AS "����"
FROM EMPLOYEE;

-- ��� ���� �� �����, �����޿�, �λ�� �޿� ��ȸ
/*
	���� = 'J7'�� ��� 10% �λ�
	���� = 'J6'�� ��� 15% �λ�
	���� = 'J5'�� ��� 20% �λ�
	�׿� 5%�λ�
*/
SELECT EMP_NAME, SALARY AS "���� �޿�", DECODE(JOB_CODE, 'J7', SALARY * 1.1, 'J6', SALARY * 1.15, 'J5', SALARY * 1.2, SALARY * 1.05) AS "�λ�� �޿�"
FROM EMPLOYEE;

/*
	CASE WHEN THEN : ���ǽĿ� ���� ������� ��ȯ���ִ� �Լ�
	
	[ǥ����]
		CASE 
			WHEN ���ǽ�1 THEN �����1
			WHEN ���ǽ�2 THEN �����2
			...
			ELSE �����
		END
	�� if-else���� ����
*/
-- ������� �� �����, �޿�, �޿��� ���� ��� ��ȸ
/*
	500���� �̻��� ��� '���'
	350���� �̻��� ��� '�߱�'
	�׿� �ʱ�
*/
SELECT EMP_NAME, SALARY, 
		CASE
			WHEN SALARY >= 5000000 THEN '���'
			WHEN SALARY BETWEEN 3500000 AND 4999999 THEN '�߱�'
			ELSE '�ʱ�'
		END AS "�޿� ���"
FROM EMPLOYEE;		

-- ==============================================================
/* �׷��Լ�
	SUM : �ش� �÷��� �� ���� ��ȯ���ִ� �Լ�
	
	[ǥ����]
		SUM(����Ÿ���÷�)
*/
-- ��ü ������� �� �޿� ��ȸ
SELECT SUM(SALARY) AS "�� �޿�"
FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "�� �޿�" -- �����ؼ� ���� ����� ���� ������ �̷������� ��� ����
FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "���� ����� �� �޿�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- �μ��ڵ尡 'D5'�� ������� �� ����
SELECT TO_CHAR(SUM(SALARY * 12), 'L999,999,999') AS "D5 �� ����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
-- ==============================================================
/*
	AVG : �ش� �÷��� ����� ��ȯ���ִ� �Լ�
	
	[ǥ����]
	AVG(����Ÿ���÷�)
*/
-- ��ü������� ��� �޿� ��ȸ( �ݿø� ����)
SELECT TO_CHAR(ROUND(AVG(SALARY)), 'L999,999,999') AS "��ձ޿�"
FROM EMPLOYEE;
-- ==============================================================
/*
	MIN : �ش� �÷��� ���� �� ���� ���� ���� ��ȯ
	MAX : �ش� �÷��� ���� �� ���� ū ���� ��ȯ
	
	[ǥ����]
	MIN(���Ÿ���÷�)
	MAX(���Ÿ���÷�)
*/
SELECT MIN(EMP_NAME) AS "����Ÿ���� �ּڰ�", MIN(SALARY) AS "����Ÿ���� �ּڰ�", MIN(HIRE_DATE) AS "��¥Ÿ���� �ּڰ�"
FROM EMPLOYEE;

SELECT MAX(EMP_NAME) AS "����Ÿ���� �ּڰ�", MAX(SALARY) AS "����Ÿ���� �ּڰ�", MAX(HIRE_DATE) AS "��¥Ÿ���� �ּڰ�"
FROM EMPLOYEE;

-- ==============================================================
/*
	COUNT(*) : ��ȸ�� ����� ��� ���� ������ ��ȯ
	COUNT(�÷�) : �ش��÷��� ���� NULL�� �ƴ� �͸� ���� ������ ���� ��ȯ
	COUNT(DISTINCT �÷�) : �ش� �÷��� ������ �ߺ� ���� �� ������ ���� ��ȯ
		�� �ߺ� ���Ž� NULL�� �������� �ʰ� ������ ������
*/
SELECT COUNT(*) AS "��ü ��� ��"
FROM EMPLOYEE;

SELECT COUNT(*) AS "��ü ��� ��"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

SELECT COUNT(*) AS "��ü ��� ��"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(*) AS "���ʽ��� �޴� ��� ��"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS) AS "���ʽ��� �޴� ��� ��"
FROM EMPLOYEE;

SELECT COUNT(DEPT_CODE) AS "�μ���ġ�� ���� ��� ��"
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) AS "�Ҽӻ���� �ִ� �μ� ��"
FROM EMPLOYEE;