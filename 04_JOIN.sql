/*
    * JOIN
      : �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� ����
        ��ȸ ����� �ϳ��� �����(Result Set)�� ����
        
        => ������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺� ����
            ---> �ߺ� ������ �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� ������
            
        => ������ �����ͺ��̽����� �������� ����Ͽ� ���̺� ���� "����"�� �δ� ����̴�
            (�� ���̺� ���� �����(�ܷ�Ű)�� ���ؼ� �����͸� ��Ī���� ��ȸ�ϰ� �ȴ�)
            
        JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����"�� �ִ�.
   ===========================================================================    
            ����Ŭ ���� ����           |                 ANSI ����
   ===========================================================================
      � ����(EQUAL JOIN)           |   ���� ����(INNER JOIN) -> JOIN ON/USING
   --------------------------------------------------------------------------
      ���� ����(LEFT/RIGHT JOIN)      |   ����/������ �ܺ� ���� (LEFT/RIGHT OUTER JOIN)
                                    |   ��ü �ܺ� ���� (FULL OUTER JOIN)
   --------------------------------------------------------------------------
        ��ü ���� (SELF JOIN)         |                 JOIN ON 
        �� ���� (NON EQUAL JOIN)  |
   ===========================================================================
*/
-- ��ü ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- �μ� �������� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

-- ���� �������� �����ڵ�, ���޸� ��ȸ
SELECT JOB_CODE, JOB_NAME
FROM JOB;

-------------------------------------------------------------------------------
/*
    * � ����(EQUAL JOIN) / ���� ���� (INNER JOIN)
    : �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ (=> ��ġ���� �ʴ� ���� ������� ����)
    
    [����Ŭ ���� ����]
    - FROM���� ��ȸ�ϰ��� �ϴ� ���̺��� ����(,�� ����)
    - WHERE���� ��Ī��ų �÷��� ���� ������ �ۼ�
*/
-- ����� ���, �̸�, �μ��� ��ȸ
--> �μ��ڵ� �÷����� ���� (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_TITLE �μ���
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- => ��ġ���� �ʴ� ������ ������� ���ܵ�
--          EMPLOYEE ���̺����� DEPT_CODE���� NULL�� ���
--          DEPARTMENT ���̺����� EMPLOYEE ���̺� �������� �ʴ� ������ (D3, D4, D7)
--          >>> �� ���̺����� �����ϴ� �����͵��� ���ܰ� ��


-- ����� ���, �̸�, ���޸��� ��ȸ
--> �����ڵ� �÷����� ���� (EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
SELECT EMP_ID, EMP_NAME, JOB_NAME, J.JOB_CODE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- �÷����� ������ ��� ���̺� ��Ī�� �༭ �����ϱ�
--> WHERE E.JOB_CODE = J.JOB_CODE;
-- WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE; �� ������ ��


-- [ANSI ����]
/*
    - FROM���� ������ �Ǵ� ���̺��� �ϳ� �ۼ�
    - JOIN���� �����ϰ��� �ϴ� ���̺��� ��� + ��Ī��Ű���� �ϴ� ������ �ۼ�
    * JOIN ON : �÷����� ���ų� �ٸ� ��쿡 ���
        FROM ���̺�1
            JOIN ���̺�2 ON (���ǽ�)
            
    * JOIN USING : �÷����� ���� ��쿡�� ���
        FROM ���̺�1
            JOIN ���̺�2 USING (�÷���)
    
*/
-- ���, �����, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ���, �����, ���޸� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;


-- �븮 ������ ����� ���, �����, ���޸�, �޿�
-- * ����Ŭ ���� *
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE       -- �� ���̺� ������ ���� ����
        AND JOB_NAME = '�븮';       -- �븮 ������ ����� ���� ����

-- * ANSI ���� *
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮';

-------------------------------------------------------------------------------
-- [TODO]

-- 1] �μ��� �λ�������� ������� ���, �����, ���ʽ� ��ȸ
-- *����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '�λ������';

-- *ANSI
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID  -- USING ��� �Ұ� => ����� ������ �ϴ� �÷����� �ٸ�
WHERE DEPT_TITLE = '�λ������';

-- 2] �μ��� ���� ������ �����Ͽ�, ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-- *����Ŭ
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

-- *ANSI
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

-- 3] ���ʽ��� �޴� ����� ���, �����, ���ʽ�, �μ��� ��ȸ
-- *����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL;

-- *ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE BONUS IS NOT NULL;

-- 4] �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ
-- *����Ŭ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE <> '�ѹ���';

-- *ANSI
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE ^= '�ѹ���';


-- =============================================================================

/*
    ���� ���� / �ܺ� ����(OUTER JOIN)
    : �� ���̺� ���� JOIN �� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ�ϴ� ����
        ��, �ݵ�� LEFT/RIGHT�� �����ؾ� ��(������ �Ǵ� ���̺�)
    
    * LEFT JOIN : �� ���̺� �� ���ʿ� �ۼ��� ���̺��� �������� ����
    * RIGHT JOIN : �� ���̺� �� �����ʿ� �ۼ��� ���̺��� �������� ����
    
    * FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ�ϴ� ���� (����Ŭ �������� X)
*/
-- ��� ����� �����, �μ���, �޿�, ���� ��ȸ
-- LEFT JOIN *����Ŭ*
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- LEFT JOIN *ANSI*
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- RIGHT JOIN *����Ŭ*
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- RIGHT JOIN *ANSI*
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


---------------- FULL JOIN ----------------
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- =============================================================================
/*
    �� ���� (NON EQUAL JOIN)
    : ��Ī ��ų �÷��� ���� ���� �ۼ� �� '='�� ������� �ʴ� ����. ���� ������ ���� ����
    
    * ANSI ���������� JOIN ON�� ��� ������
*/
-- ����� ���� �����, �޿�, �޿���� ��ȸ
-- ��� : EMPLOYEE, ���: SAL_GRADE
-- NON EQUAL JOIN *����Ŭ*
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
-- WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- NON EQUAL JOIN *ANSI*
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;


-- =============================================================================
/*
    ��ü ���� (SELF JOIN)
    : ���� �ٸ� ���̺��� �ƴ� ���� ���̺��� �����ϴ� ����
*/
-- ��ü ����� ���, �����, �μ��ڵ�,
--             ������, ��� �����, ��� �μ��ڵ� ��ȸ
-- ��� (EMPLOYEE), ��� (EMPLOYEE) --> ���̺��� ���� ������ ���� �̸��� �÷����� ���� ��
--                                     ==> ��Ī ���
-- * ����Ŭ ���� *
SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�
        , M.EMP_ID ������, M.EMP_NAME "��� �����", M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;  -- � ����� �������� ����� ����� �������� ����

-- *ANSI ���� *
SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�
        , M.EMP_ID ������, M.EMP_NAME "��� �����", M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E 
        JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
        -- LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
        -- > ����� ���� ������� ������ ��ȸ�ϰ��� �� ��
-- =============================================================================
/*
    ���� ����
    : 2�� �̻��� ���̺��� �����ϴ� ��
*/
-- ���, �����, �μ���, ���޸� ��ȸ
-- ��� (EMPLOYEE), �μ� (DEPARTMENT), ���� (JOB)
-- ** ����Ŭ ���� ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID           -- EMPLOYEE ���̺�� DEPARTMENT ���̺� ����
    AND E.JOB_CODE = J.JOB_CODE;    -- EMPLOYEE ���̺�� JOB ���̺� ����

-- ** ANSI ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE);
    
-- ���, �����, �μ���, ������ ��ȸ
-- ���(EMPLOYEE), �μ�(DEPARTMENT), ����(LOCATION)

-- ** ����Ŭ ���� ���� **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID           -- EMPLOYEE , DEPARTMENT ����
    AND LOCATION_ID = LOCAL_CODE;   -- DEPARTMENT, LOCATION ����

-- ** ANSI ���� **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

------------------------------------ [TODO] ------------------------------------
-- 1] ���, �����, �μ���, ������, ������ ��ȸ
-- ����(NATIONAL)
-- ����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE);

-- 2] ���, �����, �μ���, ���޸�, ������, ������, �޿���� ��ȸ
-- ����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT, JOB J, LOCATION L, NATIONAL N, SAL_GRADE
WHERE DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;



