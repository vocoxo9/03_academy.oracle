----------------------------------- 20250227 -----------------------------------
/*
    SELECT : ������ ��ȸ(����)
    [ǥ����]
    
        SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��;
        
        SELECT �÷���1, �÷���2, ... �Ǵ� * FROM ���̺��;
*/

-- ��� ����� ������ ��ȸ
SELECT * FROM EMPLOYEE;

-- ��� ����� �̸�, �ֹι�ȣ, ����ó�� ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE;                  -- FROM������ ��ȸ��

SELECT EMP_NAME AS "�̸�", EMP_NO AS "�ֹι�ȣ", PHONE AS "����ó" FROM EMPLOYEE;

-- ��� ������ ������ ��ȸ
SELECT * FROM JOB;

-- ���� ���� �� ���޸� ��ȸ
SELECT JOB_NAME FROM JOB;

-- ��� ���̺��� �����, �̸���, ����ó, �Ի���, �޿�
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;



/*
    �÷��� ��� ���� �߰��ϱ�
    => SELECT���� �÷��� �ۼ��κп� ��� ������ �� �� ����
*/
-- �����, ���� ���� ��ȸ
SELECT EMP_NAME, SALARY*12 AS "����" FROM EMPLOYEE;

-- �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ����
SELECT EMP_NAME, SALARY, BONUS, SALARY*12,(SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;


/*
    �÷��� ��Ī �ο��ϱ�
    : ������� ����� ��� �ǹ̸� �ľ��ϱ� ��Ʊ� ������
      ��Ī�� �ο��Ͽ� ��Ȯ�ϰ� ����ϰ� ��ȸ�� �� ����
      
      1) �÷��� ��Ī
      2) �÷��� AS ��Ī
      3) �÷��� "��Ī"
      4) �÷��� AS "��Ī"
*/

SELECT EMP_NAME �����, SALARY AS �޿�, BONUS "���ʽ�", (SALARY*12) AS "����", (SALARY+(SALARY*BONUS))*12 AS "���ʽ� ���� ����"
FROM EMPLOYEE;

-- ���� ���νð� ���� : SYSDATE
-- ���� ���̺�(�ӽ� ���̺�) : DUAL
-- �⺻������ ������ ��
SELECT SYSDATE FROM DUAL;   --YY/MM/DD �������� ��ȸ

-- ��� ����� �����, �Ի���, �ٹ��ϼ� ��ȸ
-- �ٹ��ϼ� = ���糯¥ - �Ի��� +1
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE+1 "�ٹ��ϼ�"
FROM EMPLOYEE;
-- DATEŸ�� - DATEŸ�� => �� ������ ǥ�õ�


/*
    ���ͷ�(�� ��ü) : ���Ƿ� ������ ���� '���ڿ�' �Ǵ� ���ڷ� ǥ��
    -> SELECT ���� ����ϴ� ��� ��ȸ�� ���(Result Set)�� �ݺ������� ǥ�õ�
*/

-- �����, �޿�, '��' ��ȸ
SELECT EMP_NAME �����, SALARY �޿�, '��' ��
FROM EMPLOYEE;

/*
    ���� ������ : ||
    �� ���� �÷� �Ǵ� ���� �÷��� �������ִ� ������
*/

-- XXX�� �������� �޿� ���� ��ȸ
SELECT EMP_NAME �����, SALARY || '��' �޿�
FROM EMPLOYEE;

-- ���, �̸�, �޿��� �� ���� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY "��� ����"
FROM EMPLOYEE;

-- XXX�� �޿��� XXX���Դϴ�. �������� ��ȸ
SELECT EMP_NAME || '�� �޿��� ' || SALARY || '���Դϴ�.' "�޿� ����" 
FROM EMPLOYEE;


/*
    �ߺ� ���� : DISTINCT
    �ߺ��� ������� ���� ��� ��ȸ ����� �ϳ��� ǥ���� ��
*/
-- ������̺��� �����ڵ� ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

-- ������̺��� �ߺ� �����Ͽ� �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- ������̺��� �μ��ڵ� ��ȸ(�ߺ� ����)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- *SELECT������ DISTINCT�� �� ���� ��� ������
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;
-- => �� ������ ���� �ߺ� ��������
------------------------------------------------------------------------------

/*
    WHERE�� : ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����ϰ��� �� �� ���
    
    [ǥ����]
        SELECT �÷���, �÷� �Ǵ� ������ ���� �����
        FROM ���̺��
        WHERE ����;
        
    - �� ������
        ��� �� : > < >= <=
        ���� ��
            - ���� �� �� : =
            - �ٸ� �� �� : != <> ^=
*/

-- ������̺��� �μ��ڵ尡 'D9'�� ������� ������ ��ȸ
SELECT *                    -- 3) ��ü �÷��� �����͸� ��ȸ
FROM EMPLOYEE               -- 1) EMPLOYEE ���̺���
WHERE DEPT_CODE = 'D9';     -- 2) DEPT_CODE �÷��� ���� D9��

-- ��� ���� �� �μ��ڵ尡 D1�� ������� �����, �޿�, �μ��ڵ带 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- ��� ���� �� �μ��ڵ尡 'D1'�� �ƴ� ������� �����, �޿�, �μ��ڵ带 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';
-- WHRER DEPT_CODE <> 'D1';
-- WHERE DEPT_CODE ^= 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ������ ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- �޿��� 400���� �̸��� ������� �����, �μ��ڵ� �޿� ������ ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < 4000000;

--------------------------------------------------------------------------------
-- �ǽ�����
-- [1]�޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ
SELECT EMP_NAME �����, SALARY �޿�, HIRE_DATE �Ի���, SALARY*12 ����
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- [2]������ 5õ���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME �����, SALARY �޿�, SALARY*12 ����, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;

-- [3]���� �ڵ尡 'J5'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, JOB_CODE �����ڵ�, ENT_yn ��翩��
FROM EMPLOYEE
WHERE JOB_CODE <> 'J5';
-- != ^=

-- [4]�޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000;

/*
    BETWEEN AND : ���ǽĿ��� ���Ǵ� ����
    ~�̻� ~������ ������ ���� ������ �����ϴ� ����
    
    �÷��� BETWEEN A AND B
    �ش� �÷��� ���� A�̻� B������ ���
*/

-- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿�
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

-- -- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� (NOT ���)
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY (NOT) BETWEEN 3500000 AND 6000000;�� ���������� ���� �ڵ� ��õ

/*
    IN : ������ ���� �߿� ��ġ�ϴ� ���� �ִ� ��츦 ��ȸ�ϴ� ����
    
    [ǥ����]
        �÷��� IN (��1, ��2, ��3, ...)
        
        �Ʒ��� ������
        �÷��� = ��1 OR �÷��� = ��2 OR �÷��� = ��3 ...
*/

-- �μ��ڵ尡 D6�̰ų� D8�̰ų� D5�� ������� �����, �μ��ڵ�, �޿��� ��ȸ
-- IN ��� �� �� �ڵ�
SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- IN ����� �ڵ�
SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');


----------------------------------- 20250228 -----------------------------------
/*
    [LIKE] : ���ϰ��� �ϴ� �÷��� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
            ==> Ư�� ���� : %, _ �� ���ϵ�ī��� ���
            
            [ǥ����] �񱳴���÷� LIKE '����'
            
            % : 0���� �̻�
             ex) �񱳴���÷� LIKE '����%' => �񱳴���÷��� ���� ���ڷ� ���۵Ǵ� ���� ��ȸ
                 �񱳴���÷� LIKE '%����' => �񱳴���÷��� ���� ���ڷ� ������ ���� ��ȸ
                 �񱳴���÷� LIKE '%����%' => �񱳴���÷��� ���� ���ڰ� ���ԵǴ� ���� ��ȸ
                 
            _ : 1����
             ex) �񱳴���÷� LIKE '_����' => �񱳴���÷��� ������ ���� �տ� ������ �ѱ��ڰ� ���� ��츦 ��ȸ
                 �񱳴���÷� LIKE '__����' => �񱳴���÷��� ������ ���� �տ� ������ �α��ڰ� ���� ��츦 ��ȸ
                 �񱳴���÷� LIKE '_����_' => �񱳴���÷��� ������ ���� ��, �ڷ� ������ �ѱ��ھ� ���� ��츦 ��ȸ
*/

-- ����� �� "��"�� ���� ���� ����� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME �����, SALARY �޿�, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ����� "��"�� ���Ե� ����� �����, �ֹι�ȣ, ����ó�� ��ȸ
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, PHONE ����ó
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ������� ��� ���ڰ� "��"�� �����, ����ó ��ȸ (������� 3������ ��� ��)
SELECT EMP_NAME �����, PHONE ����ó
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ����� �� ����ó�� 3��° �ڸ��� 1�� ����� ���, �����, ����ó, �̸��� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, PHONE ����ó, EMAIL �̸���
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ����� �� �̸����� 4��°�ڸ��� _�� ����� ���, �̸�, �̸����� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, EMAIL �̸���
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE'#';
-- WHERE EMAIL LIKE '____%';
-- > ���ϵ�ī��� ���Ǵ� ���ڿ� �÷��� ��� ���ڰ� �����ϱ� ������ ��� ���ϵ�ī��� �ν� ��
--   ����, ������ �ʿ��ϴ�. => ESCAPE �ɼ� �߰�
-- [ǥ����] �񱳴���÷� LIKE '����' ESCAPE'��ȣ';
-- ���ϵ�ī�带 ���ڷ� �ν��ϰԲ� ��. �Ϲ� ���ڿ��� ��� �Ұ�. ���ϵ�ī�� �տ� �ۼ�



/*
    [IS NULL / IS NOT NULL]
    : �÷����� NULL�� �ִ� ��� NULL���� ���� �� ���Ǵ� ������
    
    - IS NULL : �÷� ���� NULL ������ ��
    - IS NOT NULL : �÷� ���� NULL���� �ƴ��� ��
*/

-- ���ʽ��� ���� �ʴ� ������� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, SALARY �޿�, BONUS ���ʽ�
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ������� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, SALARY �޿�, BONUS ���ʽ�
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; �� ���� => BONUS IS NULL ��ü�� ����

-- ����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME �����, MANAGER_ID ������, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- �μ���ġ�� ���� �ʾ�����, ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME �����, BONUS ���ʽ�, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- �����ڵ尡 'J7'�̰ų� 'J2'�� ����� �߿� �޿��� 200���� �̻��� ����� ��� ������ ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;
WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >= 2000000;
-- ������ �켱���� OR ���� AND�� �� ���� ������ OR �� �Ұ�ȣ�� ������

/*
    [������ �켱����]
        (0) ()
        (1) ��������� : * / + -
        (2) ���Ῥ���� : ||
        (3) �񱳿����� : > < >= <= = != <> ^=
        (4) IS NULL / LIKE '����' / IN
        (5) BETWEEN AND
        (6) NOT
        (7) AND
        (8) OR
*/

/*
    [����] : ORDER BY
            => SELECT������ ���� ������ �ٿ� �ۼ�
            => ���� ���� ���� ������
    [ǥ����]
        SELECT ��ȸ�� �÷�, ...
        FROM ���̺��
        WHERE ���ǽ�
        ORDER BY ���ı����� �Ǵ� �÷�|��Ī|�÷����� [ASC|DESC] [NULLS FIRST|NULLS LAST]
        
        * ASC : �������� ���� (�⺻��)
        * DESC : �������� ����
        * NULLS FIRST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �տ� ��ġ (DESC�� ��� �⺻��)
        * NULLS LAST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �ڿ� ��ġ (ASC�� ��� �⺻��)
            --> NULL ���� ū ������ �з��Ͽ� ����
*/

-- ��� ����� �����, ���� ��ȸ (������ �������� ����)
SELECT EMP_NAME, SALARY*12 ����
FROM EMPLOYEE
ORDER BY ���� DESC;
-- ORDER BY 2 DESC; >>> �÷� ���� ��� (����Ŭ������ ������ 1���� ����)
-- ORDER BY SALARY*12 DESC; >>> ���ı����� �Ǵ� �÷�

-- ���ʽ� �������� ����
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;     -- �⺻�� (ASC, NULLS LAST)
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS LAST;
--ORDER BY BONUS DESC;    -- (DESC�� �� NULLS FIRST �⺻ ��)

ORDER BY BONUS DESC, SALARY ASC;
-- => ���ʽ� ���� �������� �����ϴµ�, ���ʽ� ���� ���� ��� �޿��� ���� �������� ����