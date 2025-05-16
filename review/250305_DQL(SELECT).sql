--====== 250305_DQL(SELECT)_���������(TEST250305).sql ���� �� �Ʒ� ��ȸ ======--
-- ����� ������ �������ּ���. (����ڸ�: C##TEST250305 / ��й�ȣ: test0305)
-- ��� ����� ���� ��ȸ
SELECT *
FROM CUSTOMER;

-- �̸�, �������, ���� ���� ��ȸ
SELECT NAME �̸�, BIRTHDATE �������, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 ����
FROM CUSTOMER;

-- ���̰� 40���� ������� ���� ��ȸ
SELECT *
FROM CUSTOMER
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 BETWEEN 40 AND 49;

-- �����ÿ� ���� ���� ������� ���� ��ȸ
SELECT *
FROM CUSTOMER
WHERE ADDRESS LIKE '%������%';

-- �̸��� 2���� ������� ���� ��ȸ
SELECT *
FROM CUSTOMER
WHERE NAME LIKE'__';
--WHERE LENGTH(NAME) = 2;

--===========================================================================
-- '250305' ����Ÿ�� �����͸� '2025�� 03�� 05��'�� ǥ��
SELECT TO_CHAR(TO_DATE(250305), 'YYYY"��" MM"��" DD"��"') "����->��¥" FROM DUAL;

-- ������ �¾�� ��ĥ °���� Ȯ��
SELECT CEIL(SYSDATE - TO_DATE(980927)) FROM DUAL;

--===========================================================================
-- ����� ������ �������ּ���. (����ڸ�: C##KH / ��й�ȣ: KH)
--  �ش� ������ ���� ��� �߰� �� kh.sql ��ũ��Ʈ �����Ͽ� �Ʒ� ������ �������ּ���.

-- ������� ���� ����� �޿� �� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- �Ի���� ��� �� ��ȸ (* �Ի�� �������� ����)
SELECT EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��" , COUNT(*) "��� ��"   -- 3
FROM EMPLOYEE                                                      -- 1
GROUP BY EXTRACT(MONTH FROM HIRE_DATE)                             -- 2
ORDER BY 1;                                                        -- 4