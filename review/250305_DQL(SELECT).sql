--====== 250305_DQL(SELECT)_���������(TEST250305).sql ���� �� �Ʒ� ��ȸ ======--
-- ����� ������ �������ּ���. (����ڸ�: C##TEST250305 / ��й�ȣ: test0305)

-- ������ �������� �����ؾ���
-- ����� ����
-- CREATE USER C##TEST250305 IDENTIFIED BY test0305;

-- ���� �ο�
-- GRANT RESOURCE, CONNECT TO C##TEST250305;

-- ���̺� �����̽� ���� ����
-- ALTER USER C##TEST250305 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- ��� ����� ���� ��ȸ
SELECT * FROM CUSTOMER;

-- �̸�, �������, ���� ���� ��ȸ
SELECT NAME AS "�̸�", BIRTHDATE AS "�������", EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 AS "����"
FROM CUSTOMER;

-- ���̰� 40���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 BETWEEN 40 AND 49;

-- �����ÿ� ���� ���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER
WHERE ADDRESS LIKE '%������%';

-- �̸��� 2���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER
WHERE LENGTH(NAME) = 2;
--WHERE NAME LIKE '__';
-- LENGTHB(NAME) = 6 -- �ѱ��� �� ���ڴ� 3����Ʈ��!

--===========================================================================
-- '250305' ����Ÿ�� �����͸� '2025�� 03�� 05��'�� ǥ��
SELECT TO_CHAR(TO_DATE('250305'), 'YYYY"��" MM"��" DD"��"') FROM DUAL;

-- ������ �¾�� ��ĥ °���� Ȯ��
SELECT CEIL(SYSDATE - TO_DATE('000429')) || '�� °' FROM DUAL;

--===========================================================================
-- ����� ������ �������ּ���. (����ڸ�: C##KH / ��й�ȣ: KH)
--  �ش� ������ ���� ��� �߰� �� kh.sql ��ũ��Ʈ �����Ͽ� �Ʒ� ������ �������ּ���.

-- ������� ���� ����� �޿� �� ��ȸ
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') AS "�޿� ��"
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- �Ի���� ��� �� ��ȸ (* �Ի�� �������� ����)
SELECT EXTRACT(MONTH FROM HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY EXTRACT(MONTH FROM HIRE_DATE)
ORDER BY EXTRACT(MONTH FROM HIRE_DATE);