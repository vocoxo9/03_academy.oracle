-- * �Ʒ� ������ �����Ͽ� ������ �� �Ʒ� �������� �������ּ���.
--   USERNAME / PWD : C##TEST250317 / TEST0317
--SELECT * FROM DBA_USER WHERE LIKE 'C##%';

CREATE USER C##TEST250317 IDENTIFIED BY TEST0317;
GRANT CONNECT, RESOURCE TO C##TEST250317;
ALTER USER C##TEST250317 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
--------------------------------------------------------------------------------------------------------
DROP TABLE DEPARTMENTS;
DROP TABLE EMPLOYEES;

-- DEPARTMENTS ���̺� ����
CREATE TABLE DEPARTMENTS (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50) NOT NULL
);

-- EMPLOYEES ���̺� ����
CREATE TABLE EMPLOYEES (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    SALARY NUMBER,
    HIRE_DATE DATE,
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID)
);

-- DEPARTMENTS ������ ����
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (1, '�λ��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (2, '�繫��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (3, 'IT�μ�');

-- EMPLOYEES ������ ����
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (101, 'ȫ�浿', 3500000, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (102, '��ö��', 3200000, TO_DATE('2019-03-22', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (103, '�̿���', 3800000, TO_DATE('2021-07-10', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (104, '������', 4500000, TO_DATE('2018-11-05', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (105, '�ֹ�ȣ', 4700000, TO_DATE('2022-02-18', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (106, '�ű��', 2900000, TO_DATE('2024-05-13', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (107, '����Ŭ', 3300000, TO_DATE('2024-07-23', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (108, '���ڹ�', 3900000, TO_DATE('2025-01-06', 'YYYY-MM-DD'), 3);
--------------------------------------------------------------------------------------------------------

-- ��� ������ �̸��� �޿��� ��ȸ
-- ����� ��� �� : 8
SELECT EMP_NAME, SALARY FROM EMPLOYEES;

-- '�繫��'�� ���� �������� �̸��� �μ����� ��ȸ (����Ŭ ���� ���� ���)
/*
    EMP_NAME    | DEPT_NAME
    -----------------------
    ��ö��       | �繫��
    ������       | �繫��
*/
SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEES
JOIN DEPARTMENTS USING (DEPT_ID)
WHERE DEPT_NAME = '�繫��';

-- ��� �޿��� ��� (�Ҽ��� 2�ڸ����� ǥ��)
/*
    ��� �޿�
    ----------
    3766666.67
*/
-- ROUND(AVG(SALARY), 2)
SELECT AVG(SALARY)
FROM EMPLOYEES;

-- �μ��� ���� ���� ����ϰ�, ���� ���� 3�� �̻��� �μ��� ��ȸ 
/*
    �μ���     | ���� ��
    -----------------------
    IT�μ�     | 4
*/
SELECT DEPT_NAME �μ���, COUNT(*) "���� ��"
FROM EMPLOYEES
JOIN DEPARTMENTS USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING COUNT(*) >= 3;

-- �޿��� ���� ���� ������ �̸��� �޿��� ��ȸ
/*
    ���� �̸�      | �޿�
    --------------------------
    �ֹ�ȣ	      | 4700000
*/
SELECT EMP_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY)
                FROM EMPLOYEES);
                
-- ���ο� ���̺� PROJECTS�� ���� 
--  ( ���� ����: ������Ʈ��ȣ (PROJECT_ID:NUMBER (PK), ������Ʈ�� (PROJECT_NAME:VARCHAR2(100) NULL ���X)))
CREATE TABLE PROJECTS(
    PROJECT_ID NUMBER PRIMARY KEY,
    PROJECT_NAME VARCHAR2(100) NOT NULL
);

-- ���ο� ���� '�����'�� EMPLOYEES ���̺� ���� ( ���� ����: �޿� 3500000, IT�μ�, ���� �Ի�)
-- * ���� ��ȣ�� ���, �������� �����Ͽ� Ȱ���غ���. 
CREATE SEQUENCE SEQ_EMP START WITH 109;
INSERT INTO EMPLOYEES VALUES(SEQ_EMP.NEXTVAL, '�����', 3500000, SYSDATE, 3);

-- EMPLOYEES ���̺��� 'ȫ�浿'�� �޿��� 3800000���� ����
UPDATE EMPLOYEES
SET SALARY = 3800000
WHERE EMP_NAME = 'ȫ�浿';

-- EMPLOYEES ���̺��� �޿��� 3000000 ������ �������� ���� -- 1�� �� ����
DELETE FROM EMPLOYEES
WHERE SALARY <= 3000000;

-- EMPLOYEES ���̺� ���ο� �÷� EMAIL�� �߰� (VARCHAR2(100), �⺻�� 'temp@kh.or.kr')
ALTER TABLE EMPLOYEES ADD EMAIL VARCHAR2(100) DEFAULT 'temp@kh.or.kr';

-- ��� ������ �̸��� �޿��� �����ϴ� �� VW_EMP�� ����
-- * VIEW ���� ���� �ο� (������ ����)
GRANT CREATE VIEW TO C##TEST250317;
CREATE VIEW VW_EMP
AS (SELECT EMP_NAME, SALARY FROM EMPLOYEES);

-- ������ VIEW�� �������� �̸��� '��'�� ���Ե� ���� ��ȸ
/*
    �̸�   | �޿�
    �ֹ�ȣ	4700000
    �����	3500000
*/
SELECT * FROM VW_EMP
WHERE EMP_NAME LIKE '%��%';

-- �� VW_EMP�� ����
DROP VIEW VW_EMP;

-- EMPLOYEES ���̺��� ����
DROP TABLE EMPLOYEES;
----------------------------------------------------------------
-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; ����
	User C##TEST��(��) �����Ǿ����ϴ�.
	���� ������ �ϰ� ���� �� ���� (user C##TEST lacks CREATE SESSION privillege; logon denied ����)
*/

-- ���� ? ���� ���� �� �ּ� ���� �ο��ϱ�
-- �ذ��� ? GRANT CONNECT TO C##TEST; --OR CREATE SESSION

-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
	JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	���� �� ���̺��� �����Ͽ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�ϰ��� �Ѵ�.
	�̶� ������ SQL���� �Ʒ��� ���ٰ� ���� ��,
*/
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
--	JOIN TB_JOB USING(JOBNO);
    JOIN TB_JOB ON JOBNO = JOBCODE;
-- ������ ���� ������ �߻��ߴ�.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- ���� ? TB_EMP ���̺�� TB_JOB ���̺��� ����Ű�� �ִ� �÷����� �ٸ�
-- �ذ��� ? �����ϰ��� �ϴ� �÷����� �ٸ� ������ JOIN USING�� �ƴ� JOIN ON�� ����Ѵ�
--              JOIN TB_JOB ON JOBNO = JOBCODE;

COMMIT;