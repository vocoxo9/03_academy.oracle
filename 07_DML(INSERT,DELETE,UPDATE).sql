/*
    D : DATE, L : LANGUAGE
    
    - DQL(Query, ������ ��ȸ) : SELECT (��ȸ)
    - DML(Manipulation, ������ ����) : INSERT(�߰�/����), UPDATE(����), DELETE(����)
    - DDL(Definition, ������ ����) : CREATE(����), ALTER(����), DROP(����)
    - DCL(Control, ������ ����) : GRANT, REVOKE
    - TCL(Transaction Control, Ʈ����� ����) : COMMIT(����), ROLLBACK(���)
*/

--------------------------------------------------------------------------------
/*
    * DML (������ ���� ���)
        : ���̺� ������(��)�� �߰��ϰų� (INSERT),
                            �����ϰų� (UPDATE),
                            �����ϱ����� (DELETE) ����ϴ� ����̴�.
*/

/* 
    INSERT : ���̺� ���ο� ���� �߰��ϴ� ����
    
    [ǥ����]
        1) INSERT INTO ���̺�� VALUES (��, ��, ��, ...);
            => ���̺��� ��� �÷��� ���� ���� ���� �����Ͽ� �� ���� �߰��ϰ��� �� �� ����ϴ� ���
                �÷� ������ �°� VALUES�� ���� �������־�� ��
                * �ش� �÷��� �´� ������ Ÿ������ �����ؾ� ��
                * ���� �����ϰ� �������� ��� => NOT ENOUGH VALUE ���� �߻�
                * ���� �� ���� �������� ��� => TOO MANY VALUES ���� �߻�
*/

SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE 
    VALUES(900, '����', '980307-2000000', 'HY@gmail.COM','010-1234-123','D4','J4',3000000, 0.3, NULL, SYSDATE, NULL, 'N');
    
INSERT INTO EMPLOYEE 
    VALUES(900, '����', '980307-2000000', 'HY@gmail.COM','010-1234-1234','D4','J4',3000000, 0.3, NULL, SYSDATE, NULL, 'N', 2020);
    --> TOO MANY VALUES

--------------------------------------------------------------------------------
/*
        (2) INSERT INTO ���̺�� (�÷���1, �÷���2, �÷���3)
                    VALUES (��1, ��2, ��3);
        -> �÷��� ���� �����Ͽ� �ش� �÷����� ���� �߰�
        
        ���õ��� ���� �÷��� ���� ���� �⺻������ NULL���� ����ǰ�,
        NULL���� �ƴ� �ٸ� ������ �����ϰ��� �� ���� �⺻�� �ɼ��� �����ϸ� �ȴ�
        
        --> ���õ��� ���� �÷��� NOT NULL ���������� �ִٸ�, �ݵ�� ���� ���� �����ؾ� ��
            �Ǵ� �⺻�� �ɼ��� �߰��ؾ� ��
*/
-- EMPLOYEE ���̺� ���, �����, �ֹι�ȣ, �̸���, �����ڵ� �����͸� ������ ������� �߰�
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
            VALUES (901, '����Ŭ', '880707-1000000', 'oracle00@kh.or.kr', 'J7');

select * from employee;
    
--------------------------------------------------------------------------------
/*
        (3) INSERT INTO ���̺�� (��������);
        
        -> VALUES�� ���� ���� ����ϴ� ���
           ���������� ��ȸ�� ������� ��ä�� INSERT �ϴ� ��� (���� �� �߰��ϴ� ���)
*/

-- EMP01 �̶�� ���̺� ���, �����, �μ����� ������ ���̺�
-- * EMP01 �̶�� ���̺� ���(EMP_ID), �����(EMP_NAME), �μ���(DEPT_TITLE)�� ������ ���̺�
CREATE TABLE EMP01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP01;

-- ��ü ����� ���, �����, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ���� ������ ����� ������ EMP01 ���̺� ������ �߰�
INSERT INTO EMP01
( SELECT EMP_ID, EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID );
    
--------------------------------------------------------------------------------
/*
    4) INSERT ALL
        : �� �� �̻��� ���̺� ���� �����͸� �߰��� �� ���Ǵ� ���������� ������ ��� ����ϴ� ���
        
    [ǥ����]
        INSERT ALL
            INTO ���̺��1 VALUES(�÷���, �÷���, ...)
            INTO ���̺��2 VALUES(�÷���, �÷���, ...)
            ��������;
*/

-- EMP_DEPT ���̺� : ���, �����, �μ��ڵ�, �Ի���
CREATE TABLE EMP_DEPT
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0    -- 1=0 => FALSE / �ǹ̾���. ������ ���� �÷� ������ �����ϱ� ���� ����
    );
    
SELECT * FROM EMP_DEPT;

-- EMP_MANAGER ���̺� : ���, �����, ������
CREATE TABLE EMP_MANAGER
AS (SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0
    );
    
SELECT * FROM EMP_MANAGER;

-- �μ��ڵ尡 D1�� ����� ���, �����, �μ��ڵ�, ������, �Ի��� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    (
        SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
        FROM EMPLOYEE
        WHERE DEPT_CODE = 'D1'
    );
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

--------------------------------------------------------------------------------
/*
    * UPDATE *
     : ���̺� ����Ǿ� �ִ� ������ ������ ���� �����ϴ� ����
     
    [ǥ����]
        UPDATE ���̺��
            SET �÷��� = �����Ұ�,
                �÷��� = �����Ұ�, ...
        [WHERE ���ǽ�]
    -> SET������ ���� ���� �÷� ���� ���ÿ� ���� ������ (, �� ����)
    -> WHERE���� ������ ��� ��� ���� �����Ͱ� ����ȴ�. *�����ʿ�
    
    * �����͸� ������ ��(������Ʈ) ���������� �� Ȯ���ؾ� �Ѵ� *
*/

-- DEPT_TABLE �̶�� ���̺� DEPARTMENT ���̺��� ���� (������ ����)
CREATE TABLE DEPT_TABLE
AS(SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;

-- �μ��ڵ尡 D1�� �μ��� �μ����� '�λ���'���� ����
UPDATE DEPT_TABLE
    SET DEPT_TITLE = '�λ���'
WHERE DEPT_ID = 'D1';

-- �μ��ڵ尡 D9�� �μ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_TABLE SET DEPT_TITLE = '������ȹ��' WHERE DEPT_ID = 'D9';

-- EMPLOYEE ���̺��� EMP_TABLE���̺�� ���� (���, �̸�, �μ��ڵ�, �޿�, ���ʽ� ������ ����)
CREATE TABLE EMP_TABLE
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE);

SELECT * FROM EMP_TABLE;

-- ����� 900�� ����� �޿��� 400�������� �λ�(����)
UPDATE EMP_TABLE SET SALARY = 4000000 WHERE EMP_ID = 900;
SELECT * FROM EMP_TABLE WHERE EMP_ID = 900; -- Ȯ��

-- ���ȥ ����� �޿��� 500����, ���ʽ��� 0.2�� ����
UPDATE EMP_TABLE 
    SET SALARY = 5000000, BONUS = 0.2
WHERE EMP_NAME = '���ȥ';
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '���ȥ';  -- Ȯ��

-- ��ü ����� �޿��� ���� �޿��� 10���� �λ�
UPDATE EMP_TABLE SET SALARY = SALARY*1.1;

--------------------------------------------------------------------------------
/*
    * UPDATE ���� �������� ��� *
    
    [ǥ����]
        UPDATE ���̺��
            SET �÷��� = (��������)
        [WHERE ���ǽ�]
*/

-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ� ���� �����ϰ� ����
SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����';

UPDATE EMP_TABLE
    SET SALARY = (SELECT SALARY FROM EMP_TABLE WHERE EMP_NAME = '�����'),
        BONUS = (SELECT BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '����'; -- Ȯ��

-- ���߿� ���������� �ۼ��Ѵٸ�
UPDATE EMP_TABLE
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '������';
SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '������'; -- Ȯ��

-- ASIA �������� �ٹ� ���� ������� ���ʽ��� 0.3���� ����
-- 1] ASIA ���� ���� ��ȸ
SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE 'ASIA%';

-- 2] ASIA ������ �μ� ���� ��ȸ
SELECT * 
FROM DEPARTMENT
WHERE LOCAL_NAME LIKE 'ASIA%';

-- 3] AISA ������ �μ��� ���� ��� ���� ��ȸ (���)
SELECT EMP_ID
FROM EMP_TABLE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';
--> ������ ��������(N�� 1��)
--> �ش� ������� ���ʽ��� 0.3���� ����

UPDATE EMP_TABLE
    SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                FROM EMP_TABLE
                    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
                WHERE LOCAL_NAME LIKE 'ASIA%');
                
SELECT * FROM EMP_TABLE;

COMMIT; -- ���� ���� ����

--------------------------------------------------------------------------------
/*
    * DELETE *
        : ���̺� ����Ǿ� �ִ� �����͸� ������ �� ����ϴ� ����
        
    [ǥ����]
        DELETE FROM ���̺��
         [WHERE ���ǽ�];
        -> WHERE�� ���� �� ���̺��� ��� ������(��)�� �����Ѵ�
*/

-- EMPLOYEE ���̺��� ��� ������ ����
DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
ROLLBACK;   -- ������� ���. ������ Ŀ�� �������� ���ư�

-- 901�� ����� �����͸� ����
DELETE FROM EMPLOYEE WHERE EMP_ID = 901;

-- 900�� ����� �̸����� �����͸� ����
DELETE FROM EMPLOYEE WHERE EMP_NAME = '����';

COMMIT;

-- �μ� ���̺��� �μ��ڵ尡 D1�� �μ� ����
DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';
SELECT * FROM DEPARTMENT;
ROLLBACK;
--> �ܷ�Ű�� �����Ǿ� �ִ� ���(������� �����Ͱ� ���� ��) ���� �Ұ�����

/*
    * TRUNCATE *
     : ���̺��� ��ü ���� ������ �� ���Ǵ� ����
        DELETE���� ����ӵ��� �� ����
        !!! ������ ������ ������ �� ����, ROLLBACK �Ұ�(�ǵ��� �� ����) 
        
    [ǥ����]
        TRUNCATE TABLE ���̺��;
*/