/*
    GROUP BY��
    : �׷� ������ ������ �� �ִ� ����
    : ���� ���� ������ �ϳ��� �׷����� ��� ó���ϴ� �������� ���
*/
-- ��ü ��� �� �޿� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- �μ��� �� �޿�
SELECT DEPT_CODE, SUM(SALARY) -- 3
FROM EMPLOYEE                 -- 1
GROUP BY DEPT_CODE;           -- 2

-- �μ� �� ��� ��
SELECT DEPT_CODE, COUNT(*)      -- 3
FROM EMPLOYEE                   -- 1
GROUP BY DEPT_CODE;             -- 2

-- D6, D1, D9 �� �޿�
SELECT DEPT_CODE, SUM(SALARY), COUNT(*) -- 4
FROM EMPLOYEE                           -- 1
WHERE DEPT_CODE IN ('D1', 'D6', 'D9')   -- 2
GROUP BY DEPT_CODE                      -- 3
ORDER BY DEPT_CODE;                     -- 5

-- �� ���޺� �� �����, ���ʽ��� �޴� �����, �޿���, ��ձ޿�, ���� �޿�, �ְ� �޿�
-- ��, �����ڵ� ������������ ����
SELECT JOB_CODE, COUNT(*), COUNT(BONUS)"���ʽ� �޴� ��� ��", 
        SUM(SALARY) "�޿� ��", ROUND(AVG(SALARY)) "��� �޿�", 
        MIN(SALARY) "���� �޿�", MAX(SALARY) "�ְ� �޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- ���� �����, ���� ����� ��ȸ -> �ֹι�ȣ �÷�
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ���� , COUNT(*) "��� ��"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- �μ� ���� ���޺� �����, �޿� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*) "��� ��", SUM(SALARY) "�޿� ����"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE    -- �μ� �ڵ� �������� �׷�ȭ�� �ϰ�, �׷� ������ �����ڵ� �������� ���α׷�ȭ ��
ORDER BY DEPT_CODE;

-------------------------------------------------------------------------------
/*
    HAVING�� : �׷쿡 ���� ������ ������ �� ����ϴ� ����
    (����, �׷��Լ����� ����Ͽ� ������ �ۼ���)
*/
-- �μ��� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY)) "��� �޿�"
FROM EMPLOYEE
GROUP BY DPET_CODE;

-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY)) "��� �޿�"    -- 4
FROM EMPLOYEE                       -- 1
WHERE SALARY >= 3000000             -- 2 => ����� �޿��� 300���� �̻�
GROUP BY DEPT_CODE;                 -- 3

SELECT DEPT_CODE, ROUND(AVG(SALARY)) "��� �޿�"    -- 4
FROM EMPLOYEE                       -- 1
GROUP BY DEPT_CODE                  -- 2
HAVING AVG(SALARY) >= 3000000;      -- 3 => �μ��� ��� �޿��� 300���� �̻�r

-- �μ��� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

SELECT BONUS FROM EMPLOYEE WHERE DEPT_CODE = 'D2';


---------------------------------- [ 250305 ] ----------------------------------

/*
    ROLLUP, CUBE : �׷� �� ���� ��� ���� ���� ��� �Լ�
    
    - ROLLUP  : ���� ���� �׷� �� ���� ���� ������ �׷� ���� �߰��� ���� ��� ��ȯ
    - CUBE : ���� ���� �׷��� ������ ��� ���� �� ���� ��� ��ȯ
*/

-- �μ��� �μ���, ���� �� ���޺� �޿���, �μ��� �޿� ��, ��ü ���� �޿� �� ��
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

--------------------------------------------------------------------------------

/*
    ���� ����
    SELECT ��ȸ�ϰ����ϴ�_�÷���, *, �Լ�, �����                                     -- 5
    FROM ��ȸ�ϰ����ϴ�_���̺�� �Ǵ� DUAL(�ӽ����̺�)                                  -- 1
    WHERE ���ǽ�(������ Ȱ���Ͽ� �ۼ�)                                               -- 2
    GROUP BY �׷�ȭ�����̵Ǵ��÷� �Ǵ� �Լ���                                         -- 3
    HAVING ���ǽ�(�׷��Լ��� Ȱ���Ͽ� �ۼ�)                                           -- 4
    ORDER BY �÷� �Ǵ� ��Ī �Ǵ� �÷����� [ASC | DESC] [NULLS LAST | NULLS FIRST]    -- 6
*/

--------------------------------------------------------------------------------
/*
    ���� ������ : ���� ���� ��ɹ�(SQL��/ ������)�� �ϳ��� ��ɹ����� ������ִ� ������
    
    - UNION : ������(�� ��ɹ��� ������ ������� ������) --> OR�� ����
    - INTERSECT : ������(�� ��ɹ��� ������ ������� �ߺ��� �κ��� ����) --> AND�� ����
    - UNION ALL : ������+������ (�ߺ��Ǵ� �κ��� �ι� ��ȸ�� �� ����)
    - MINUS : ������ (���� ������� ���� ����� �� ������)
*/
-- * UNION
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300������ �ʰ��ϴ� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- �μ��ڵ尡 D5�� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- �޿��� 300������ �ʰ��ϴ� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- UNION �����ڷ� 2���� �������� ��ġ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- * INTERSECT
-- �μ��ڵ尡 D5�̰� �޿��� 300���� �ʰ��� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- * UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
--> 14 : UNION(12) + INTERSECT(2)


-- * MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
--> ������(6) - INTERSECT(2)


/*
    * ���� ������ ��� �� ���ǻ��� *
    
    1) ��ɹ����� �÷� ������ �����ؾ� ��
    2) �÷� �ڸ����� ������ ������ Ÿ������ �ۼ��ؾ� ��
    3) ������ �ϰ��� �� ��� ORDER BY���� ��ġ�� �� �������� �ۼ��ؾ� ��
*/









