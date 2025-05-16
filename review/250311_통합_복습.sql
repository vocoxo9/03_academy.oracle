/** �Ʒ� ���̺� �� �÷��� �����Ѵٰ� �����ϰ� �������� �ۼ��غ��� **/
/***
    DDL : ������ ���� ���
    --> ��ü�� ����(CREATE), ����(ALTER), ����(DROP)
***/

-- EMP ���̺� DEPT_ID �÷��� �߰��ϸ鼭 �⺻���� 100���� ����
-- ����, DEPARTMENT ���̺��� DEPT_ID �÷��� �����ϴ� �ܷ�Ű�� �����ϵ�
-- �θ� Ű�� ������ ��� �ش� ���� NULL�� ����
ALTER TABLE EMP
            ADD DEPT_ID NUMBER DEFAULT 100
            ADD CONSTRAINT FK_EMP_ID FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT (DEPT_ID) ON DELETE SET NULL;
            
-- EMP ���̺��� EMP_NAME �÷��� ������ Ÿ���� VARCHAR2(100)���� ����
ALTER TABLE EMP MODIFY EMP_NAME VARCHAR2(100);
            
/*** DML : ������ ���� ���
    --> �����͸� �߰�(INSERT), ����(UPDATE), ����(DELETE)        
***/

-- EMP ���̺��� DEPT_ID ���� 'D3'�� �������� SALARY �� 10% �λ�
UPDATE EMP
SET SALARY = SALARY * 1.1
WHERE DEPT_ID = 'D3';

-- EMP ���̺��� DEPT_ID ���� 'D99'�� �������� ����
DELETE FROM EMP
WHERE DEPT_ID = 'D99';

/*** DQL : ������ ���� ���
    --> �����͸� ��ȸ (SELECT)
***/

-- EMP ���̺��� SALARY ���� ���� ���� ������ ������ ��ȸ
SELECT *
FROM EMP
WHERE SALARY = (SELECT MAX(SALARY) FROM EMP);

-- EMP ���̺��� DEPT_ID �� ��� �޿�(SALARY)�� 4000000 �̻��� �μ��� �μ��� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY))
FROM (
SELECT DEPT_ID, ROUND(AVG(SALARY))
FROM EMP
GROUP BY DEPT_ID
HAVING AVG(SALARY) >= 4000000)
GROUP BY DEPT_ID;
-- WHERE : ��ü�� ���� ���� /  HAVING: �׷쿡 ���� ����

/*** DCL ***/
-- SAMPLE �������� EMP ���̺� ���� ��ȸ, ���� ������ �ο�
GRANT SELECT, UPDATE ON EMP TO SAMPLE;

-- SAMPLE �������� �ο��ߴ� EMP ���̺� ���� ���� ���� ȸ��
REVOKE UPDATE ON EMP FROM SAMPLE;

/*** TCL ***/
-- EMP ���̺��� SALARY�� 20% �λ��� �� �ش� ������ ����
UPDATE EMP
SET SALARY = SALARY*1.2;
SAVEPOINT SP;

-- ���� ���� �������� �ѹ�
ROLLBACK TO SP;

-- ��������� ��� ���� ������ ����
COMMIT;