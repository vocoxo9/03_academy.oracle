SELECT COUNT(*) FROM USER_MOCK_DATA;
---------------------------------------

/*
    * �ε���(INDEX) *
        : ��ɹ��� ó�� �ӵ��� ����Ű�� ���� Ư�� �÷��� ���� �����ϴ� ��ü
        
        - ���� : �˻� �ӵ��� �������� �ý��� ������ ��������
        - ���� : �ε����� ���� ������ ��������� �ʿ���
                ������ ���� �۾�(DML) �� �ε����� �Բ� ������Ʈ �Ǿ� ������ ������ ���ϵ� �� �ִ�
*/

-- USER_INDEX_DATA ���̺� ���� (=> USER_MOCK_DATA ���̺� ����)
CREATE TABLE USER_INDEX_DATA
AS (SELECT * FROM USER_MOCK_DATA);

SELECT COUNT(*) FROM USER_INDEX_DATA;

-- USER_INDEX_DATA ���̺� �⺻Ű�� �߰�(ID �÷�)
ALTER TABLE USER_INDEX_DATA
    ADD CONSTRAINT PK_IDX_ID PRIMARY KEY (ID);
    
-- USER_INDEX_DATA ���̺� UNIQUE �������� �߰�(EMAIL �÷�)
ALTER TABLE USER_INDEX_DATA
    ADD CONSTRAINT UQ_IDX_EMAIL UNIQUE(EMAIL);
    
-- �ε��� ���� ��ȸ
SELECT * FROM USER_IND_COLUMNS;

-------------------------------------------

-- �ε����� �������� ���� ���̺� (USER_MOCK_DATA)�� ���� ��ȹ ��ȸ
EXPLAIN PLAN FOR
SELECT * FROM USER_MOCK_DATA WHERE ID = 30000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/*
------------------------------------------------------------------------------------
| Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |                |     5 |   665 |   137   (1)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| USER_MOCK_DATA |     5 |   665 |   137   (1)| 00:00:01 |
------------------------------------------------------------------------------------

- Cost : ���� ���� ���(�ڿ��� �󸶸�ŭ �Һ��ϴ°�) --> ���� �������� ���� ������� �˻��� ����
- Rows : ���� ��ȹ���� Access�� row ��
- Bytes : ���� ��ȹ���� Access�� Bytes ��

* TABLE ACCESS FULL (full ��ĵ) : ��ü ���̺��� Ž���Ͽ� ����� �����ϰ� �� ������ �ǹ�

*/

-- �ε����� ������ ���̺� (USER_INDE_DATA)
EXPLAIN PLAN FOR
SELECT * FROM USER_INDEX_DATA WHERE ID = 30000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/*
-----------------------------------------------------------------------------------------------
| Id  | Operation                   | Name            | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                 |     1 |    63 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| USER_INDEX_DATA |     1 |    63 |     2   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_IDX_ID       |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------

* TABLE ACCESS BY INDEX ROWID : �ε��� ��ü�� ������ INDEX ROWID�� Ž���Ͽ� ����� �����ϰ� �� ������ �ǹ�
* INDEX UNIQUE SCAN : �ε��� ��ü�� �����Ͽ� Ž�� �� ����� �����ϰ� �� ������ �ǹ�
*/

-- * �ε��� �߰� *
/*
    CREATE INDEX �ε����� ON ���̺��(������);
    
    => ������ : �÷�, �Լ���, ����� ��
*/

-- USER_INDEX_DATA ���̺��� FIRST_NAME �÷��� �ε��� ����
CREATE INDEX INDEX_FIRST_NAME ON USER_INDEX_DATA(FIRST_NAME);

-- ID, FIRST_NAME���� ��ȸ
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

--- ���� ��ȹ ��ȸ
EXPLAIN PLAN FOR
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/*
-----------------------------------------------------------------------------------------------
| Id  | Operation                   | Name            | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                 |     1 |    63 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| USER_INDEX_DATA |     1 |    63 |     2   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_IDX_ID       |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------

*/
-- ��ȸ ������ �ΰ��� �÷����� ���� ����ϰ� �� ��� => ���� �ε��� ����
CREATE INDEX INDEX_FIRST_NAME_ID ON USER_INDEX_DATA(ID, FIRST_NAME);

EXPLAIN PLAN FOR
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/*
-----------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name                | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                     |     1 |    63 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| USER_INDEX_DATA     |     1 |    63 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | INDEX_FIRST_NAME_ID |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------------------
    INDEX RANGE SCAN : ���� �ε����� ����� ��ȹ�� ��Ÿ��
*/