------------------------------------ 250307 ------------------------------------

/*
    DDL : ������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü�� ���� ����� (CREATE)
                            �����ϰ�    (ALTER)
                            �����ϴ�    (DROP) ���
    => ���� �����Ͱ� �ƴ� ��Ģ/������ �����ϴ� ���
    
    * ����Ŭ������ ��ü(����) : ���̺�, ��, ������, �ε���, ��Ű��, Ʈ����,
                            ���ν���, �Լ�, ���Ǿ�, �����, ...
*/

/*
    CREATE : ��ü�� ���� �����ϴ� ����
    
    [���̺� ����]
    - ���̺� : ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü   
              ��� �����͵��� ���̺��� ���� ����ȴ�
              
    - ǥ����
    CREATE TABLE ���̺�� (
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ...    
    );
    
    * �ڷ���
    - ���� => �ݵ�� ũ�� �����ؾ� ��
        CHAR(����Ʈũ��)         : ���� ����(������ ������ �����͸� ���� ���)
                                -> ������ ���̺��� ���� ������ ���� ����� ��� �������� ä���� ������
                                * �ִ� 2000����Ʈ���� ���� ����
        VARCHAR2(����Ʈũ��)     : ���� ����(�������� ���̰� ���������� ���� ���)
                                -> ����Ǵ� ������ ���̸�ŭ�� ������ ����
                                * �ִ� 4000����Ʈ���� ���� ����
    - ���� : NUMBER
    - ��¥ : DATE
*/

-- [1] ȸ�� ������ ������ ���̺� ����
-- ���̺�� : MEMBER
/*
    [�÷� ����]
    - ȸ�� ��ȣ     : ���� (NUMBER)
    - ȸ�� ���̵�    : ���� (VARCHAR2(20))
    - ȸ�� ��й�ȣ   : ���� (VARCHAR2(20))
    - ȸ�� �̸�     : ���� (VARCHAR2(20))
    - ����        : ���� (CHAR(3))
    - ����ó       : ���� (CHAR(13))
    - �̸���       : ���� (VARCHAR2(50))
    - ������       : ��¥ (DATE)
*/
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

/*
    [2] �÷��� ���� �߰��ϱ�
    COMMENT ON COLUMN ���̺��.�÷��� IS '����';
    
    #�߸� �ۼ����� ��� �ٽ� �ۼ� �� ���� --> �������
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ�� �̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '������';

-- ���̺� �����ϱ� : DROP TABLE ���̺��;
-- DROP TABLE MEMBER;

-- [3] ���̺� ������ �߰��ϱ� : INSERT INTO ���̺�� VALUES (��, ��, ��, ...);
INSERT INTO MEMBER VALUES (1, 'jhy123', '1212jhy12', '������', '��', '010-1234-1234', 'jhy1234@gmail.com', SYSDATE);

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES (2, 'iu123', '4321', '������', '��', NULL, NULL, SYSDATE);
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT; --> ������� ����
--------------------------------------------------------------------------------
/*
    [��������] : ���ϴ� ������ ���� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
                ������ ���Ἲ�� �����ϱ� ���� ������ ����
                
        - ���� ��� : �÷�������� / ���̺������
        - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY(�⺻Ű), FOREIGN KEY(�ܷ�Ű)
*/

/*
    * NOT NULL *
        : �ش� �÷��� �ݵ�� ���� �����ؾ� �ϴ� ���
          => ���� NULL���� ����Ǹ� �� �Ǵ� ���
          
    * �����͸� �߰�(����)/���� �� NULL���� ������� ����
    * �÷� ���� ������θ� ���� �����ϴ�
*/

-- NOT NULL ���� ������ �߰��� ȸ�� ���̺�
-- ���̺�� : MEMBER_NOTNULL
-- ��, ȸ����ȣ/���̵�/��й�ȣ/�̸��� ���� �����ʹ� NULL���� ������� �ʴ´�
CREATE TABLE MEMBER_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

SELECT * FROM MEMBER_NOTNULL;

INSERT INTO MEMBER_NOTNULL 
    VALUES(1, 'JHY', '1234', '������', '��', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);
INSERT INTO MEMBER_NOTNULL 
    VALUES(2, 'HKD', '2345' , 'ȫ�浿', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_NOTNULL 
    VALUES(3, NULL, '3456', '�̸�', NULL, NULL, NULL, NULL);
--> ! ���� �������� ���� ȸ�� ���̵� ���� NULL�̶� ���� �߻� (�������ǿ� �����)

INSERT INTO MEMBER_NOTNULL 
    VALUES(1, 'JHY', '1234', '������', '��', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);
--> ! �ߺ��Ǵ� �����Ͱ� �������� �߰��� �ǰ� ����


/*
    * UNIQUE *
    : �ش� �÷��� �ߺ��� ���� ���� ��� �����ϴ� ��������
    => ������ �߰�(����)/ ���� �� ������ �ִ� ������ �� �� �ߺ��Ǵ� ���� ���� ��� ���� �߻�
*/

-- UNIQUE ���� ������ �߰��Ͽ� ���̺� ����
-- ���̺�� : MEMBER_UNIQUE, ȸ�� ���̵� �ߺ����� �ʵ��� ����

CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,    -- �÷��������/ NOT NULL, UNIQUE ������ �����Ǿ� ����
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    -- , UNIQUE (MEM_ID)    --> ���̺������/ �������� ��������(������ �÷�) ���·� �ۼ�
);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE 
    VALUES(1, 'JHY', '1234', '������', '��', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES(1, 'JHY', '12345', '������', '��', '010-1255-1255', 'JHY1@GMAIL.COM', SYSDATE);
-- ! UNIQUE ���� ���ǿ� ����Ǿ� ������ �߰� ���� (���� �߻�)
    -- "unique constraint (C##KH.SYS_C008370) violated"
    -- SYS_C008370 = �������Ǹ�/ ���� �޼��� �����δ� �ľ��ϱⰡ �����
    --> �������� ���� �� �������Ǹ��� ������ �� ����. �������� ������ �ý��ۿ��� �ڵ����� ����� ��
    
/*
    * �������Ǹ� �����ϱ�
    name already used by an existing constraint -> ���� ���Ǹ��� �ߺ��� �� ����
    [1] �÷� ���� ���
        CREATE TABLE ���̺��(
            �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
        );
        
    [2] ���̺� ���� ���
        CREATE TABLE ���̺��(
            �÷��� �ڷ���,
            �÷��� �ڷ���,
            ...
            
            [CONSTRAINT �������Ǹ�] �������� �÷���
        );
*/

-- MEMBER_UNIQUE ���̺� ����
DROP TABLE MEMBER_UNIQUE;

-- �������Ǹ��� �����Ͽ� �� ����
CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,    -- �÷��������/ NOT NULL, UNIQUE ������ �����Ǿ� ����
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
     , CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)    --> ���̺������. �������� ��������(������ �÷�) ���·� �ۼ�
);

INSERT INTO MEMBER_UNIQUE 
    VALUES(1, 'JHY', '1234', '������', '��', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES(2, 'JHY1', '1234', '������', '��', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);
    
SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE 
    VALUES(3, 'JHY', '123', '������', '��', '010-1235-1235', 'JHY1@GMAIL.COM', SYSDATE);
    -- unique constraint (C##KH.MEMID_UQ) violated/ ������ �������Ǹ����� ǥ�õ�

INSERT INTO MEMBER_UNIQUE
    VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    -- �������Ǹ��� ���� ǥ�õ����� ����
    
    
--------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) *
     : �ش� �÷��� ������ �� �ִ� ���� ���� ������ ������
        ���ǿ� �����ϴ� ������ ������ �� ����
        => ������ ������ �����ϰ��� �� �� �����
*/

INSERT INTO MEMBER_UNIQUE 
    VALUES(3, 'JHY2', '123', '������', '��', '010-1235-1235', 'JHY1@GMAIL.COM', SYSDATE);
    
-- CHECK ���� ������ �߰��� ���̺� ����
-- ���̺�� : MEMBER_CHECK
-- ���� �÷��� '��' �Ǵ� '��' �����͸� ����� �� �ֵ��� ����

CREATE TABLE MEMBER_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE

    , UNIQUE (MEM_ID)
--     , CHECK(GENDER IN ('��', '��'))    --> ���̺���������� �ۼ�
);

SELECT * FROM MEMBER_CHECK;

INSERT INTO MEMBER_CHECK 
    VALUES (1, 'JEONG', '123', '������', '��', NULL, NULL, NULL);
    
INSERT INTO MEMBER_CHECK 
    VALUES (1, 'HEONG', '123', '������', '��', NULL, NULL, NULL);
    -- ! ���� �÷��� ����Ʈ���� �°� �����͸� �߰� => üũ �������ǿ� ����(�����߻�)
    --> CHECK ���ǿ� �´� ���� ���� ����
    
INSERT INTO MEMBER_CHECK 
    VALUES (1, 'REONG', '123', '������', NULL, NULL, NULL, NULL);
    -- ���� �÷��� NULL���� ����
    -- ! NULL�� ���� ���ٴ� �ǹ��̱� ������ ������ ������
    --> ������� �ʰ��� �Ѵٸ� NOT NULL ���������� �߰��ϸ� ��
    
--------------------------------------------------------------------------------

/*
    * PRIMARY KEY(�⺻Ű) *
        : ���̺��� �� ���� �ĺ��ϱ� ���� ���Ǵ� �÷��� �ο��ϴ� ��������
        
    ex) ȸ����ȣ, �й�, ��ǰ�ڵ�, �ֹ���ȣ, �����ȣ, ...
    
    - PRIMARY KEY => NOT NULL + UNIQUE
    - ���̺� �� ���� �� ���� ���� ������
*/

-- �⺻Ű ���� ������ �߰��Ͽ� ���̺� ����
-- ���̺�� : MEMBER_PRI
-- ȸ����ȣ�� �⺻Ű�� ����

CREATE TABLE MEMBER_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,  -- �⺻Ű�� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE

    , UNIQUE (MEM_ID)
);

SELECT * FROM MEMBER_PRI;

INSERT INTO MEMBER_PRI VALUES (1, 'JHY', '1234', '������', NULL, NULL, NULL, NULL);

INSERT INTO MEMBER_PRI VALUES (1, 'JHY1', '1234', '������', NULL, NULL, NULL, NULL);
--> �⺻Ű �÷�(ȸ����ȣ)�� �ߺ��� ���� ����Ƿ��� �Ͽ� ������ �߻� (UNIQUE �������ǿ� �����)

INSERT INTO MEMBER_PRI VALUES (NULL, 'JHY1', '1234', '������', NULL, NULL, NULL, NULL);
--> �⺻Ű �÷�(ȸ����ȣ)�� NULL���� �����Ϸ��� �Ͽ� ������ �߻� (NOT NULL �������ǿ� �����)

INSERT INTO MEMBER_PRI VALUES (2, 'JHY2', '1234', '������', NULL, NULL, NULL, NULL);

--------------------------------------------------------------------------------
-- �� ���� �÷����� �⺻Ű�� �����Ͽ� ���̺� ����
-- ���̺�� : MEMBER_PRI2
-- ȸ����ȣ, ȸ�����̵� �⺻Ű�� ���� (=> ����Ű)

CREATE TABLE MEMBER_PRI2 (
    MEM_NO NUMBER,  -- �⺻Ű�� ����
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE

    , UNIQUE (MEM_ID)
    , CONSTRAINT MEMPRI2_PK PRIMARY KEY(MEM_NO, MEM_ID)   -- �⺻Ű�� 2�� �̻��� �� ���̺��� ������� �ۼ�
);

SELECT * FROM MEMBER_PRI2;

INSERT INTO MEMBER_PRI2 VALUES(1, 'JHY', '1234', '������', NULL, NULL, NULL, SYSDATE);
INSERT INTO MEMBER_PRI2 VALUES(1, 'JHI', '1234', '������', NULL, NULL, NULL, SYSDATE);
--> ����Ű : �� ���� �÷��� ���ÿ� �ϳ��� �⺻Ű�� �����ϴ� ��
-- ! ȸ�� ��ȣ�� �����ϳ� ȸ�� ���̵� �ٸ��� ������ �����Ͱ� �߰��� ��

-- � ȸ���� ��ǰ�� ��ٱ��Ͽ� ��� ������ �����ϴ� ���̺�
-- ȸ����ȣ, ��ǰ��, ���峯¥
CREATE TABLE MEMBER_LIKE (
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(50),
    LIKE_DATE DATE,
    
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

--DROP TABLE MEMBER_LIKE;

SELECT * FROM MEMBER_LIKE;
INSERT INTO MEMBER_LIKE VALUES (1, '��Ǯ���ű�', '25/03/01');
INSERT INTO MEMBER_LIKE VALUES (1, 'Ű����', '25/03/03');

INSERT INTO MEMBER_LIKE VALUES (2, 'Ű����', '25/03/05');

SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2
    JOIN MEMBER_LIKE USING (MEM_NO);
    
--------------------------------------------------------------------------------
/*
    * FOREIGN KEY (�ܷ�Ű) *
      : �ٸ� ���̺��� �����ϴ� ���� �����ϰ��� �� �� ���Ǵ� ��������
        -> �ٸ� ���̺��� �����Ѵٰ� ǥ����
        -> �ַ� �ܷ�Ű�� ���ؼ� ���̺� ���� ���踦 ����
        
    - �÷��������
        �÷��� �ڷ��� REFERENCES ���������̺�� (�������÷���)
    - ���̺������
        FOREIGN KEY (�÷���) REFERENCES ���������̺�� (�������÷���)
     
    ===> ������ �÷��� ���� �� �����ϴ� ���̺��� �⺻Ű �÷��� ��Ī��
*/

-- ȸ�� ��� ������ ������ ���̺� ����
-- ���̺�� : MEMBER_GRADE
-- ��޹�ȣ(PK), ��޸�(NOT NULL),
CREATE TABLE MEMBER_GRADE(
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '�Ϲ�ȸ��');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP');

SELECT * FROM MEMBER_GRADE;

-- MEMBER ���̺� ����
-- MEMBER ���̺� ���� : ȸ�� ��ȣ, ȸ�� ���̵�, ȸ�� ��й�ȣ, ȸ�� �̸�, ����, ������, ȸ����޹�ȣ(GRADE_NO)
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    ENROLLDATE DATE,
    -- �÷� ���� ������� �ܷ�Ű ����
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)
    
    -- ���̺� ���� ���
    -- , FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO)
);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'JHY', '1234', '������', '��', SYSDATE, 100);
INSERT INTO MEMBER VALUES(2, 'HHY', '2345', 'ȫ', '��', SYSDATE, 200);
INSERT INTO MEMBER VALUES(3, 'GHY', '3456', '��', '��', SYSDATE, NULL);
--> �ܷ�Ű�� ������ �÷����� �⺻������ NULL�� ���� ����
INSERT INTO MEMBER VALUES (4, 'kong44', '1234', '��', '��', sysdate, 400);
--> ���� �߻� "���Ἲ �������� ���� - �θ�Ű�� �����ϴ�" => ȸ����� ���̺� ������� ���� ���� ������� ���
-- MEMBER_GRADE (�θ����̺�) -|--------------<- MEMBER (�ڽ����̺�)
-- 1 : N ����, 1(�θ����̺�) N(�ڽ����̺�)

--> �θ����̺�(MEMBER_GRADE)���� "�Ϲ�ȸ��" ����� �����Ѵٸ�?
-- ������ ���� : DELETE FROM ���̺�� WHERE ����;
-- ȸ�� ��� ���̺��� ��޹�ȣ�� 100�� �����͸� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> ! �ڽ����̺�(MEMBER)���� 100�̶�� ���� ����ϰ� �ֱ� ������ ���� �Ұ�����

-- ȸ�� ��� ���̺��� ��޹�ȣ�� 300�� �����͸� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 300;
--> �ڽ����̺�(MEMBER)���� 300�̶�� ���� ������ �ʾұ� ������ ���� ������

-- * �ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ��� 
--   �θ����̺�κ��� ������ ������ ���� �ʴ� "�����ɼ�"�� ����

ROLLBACK;   -- ��������� ����ϴ� ��

SELECT * FROM MEMBER_GRADE;

--------------------------------------------------------------------------------
/*
    * �ܷ�Ű ���� ���� - ���� �ɼ�
        : �θ����̺��� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ����̺��� ����
          ��� �� �������� ���� �ɼ�
          
    - ON DELETE RESTRICTED (�⺻��) : �ڽ����̺�κ��� ��� ���� ���� ���� ���
                                     �θ����̺��� �����͸� ������ �� ����
    - ON DELETE SET NULL : �θ����̺� �ִ� �����͸� �������� ��
                            �ش� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� NULL������ ����
    - ON DELETE CASCADE : �θ����̺� �ִ� �����͸� �������� ��
                            �ش� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� ����
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    ENROLLDATE DATE,
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'JHY', '1234', '������', '��', SYSDATE, 100);
INSERT INTO MEMBER VALUES(2, 'HHY', '2345', 'ȫ', '��', SYSDATE, 200);
INSERT INTO MEMBER VALUES(3, 'GHY', '3456', '��', '��', SYSDATE, NULL);

-- ȸ�� ��� ���� �� 100�� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> ���� �ɼǿ� ���� �ڽ����̺��� MEMBER���̺��� 100���� ����ߴ� �����Ͱ� NULL�� ���� ��
--> �θ����̺�(MEMBER_GRADE)���� 100���� ���� ������ ���� ��

ROLLBACK;
------------------------

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    ENROLLDATE DATE,
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
);

INSERT INTO MEMBER VALUES(1, 'JHY', '1234', '������', '��', SYSDATE, 100);
INSERT INTO MEMBER VALUES(2, 'HHY', '2345', 'ȫ', '��', SYSDATE, 200);
INSERT INTO MEMBER VALUES(3, 'GHY', '3456', '��', '��', SYSDATE, NULL);

SELECT * FROM MEMBER;

-- ȸ�� ��� �� 100�� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> ���� �ɼǿ� ���� �ڽ����̺�(MEMBER)���� 100���� ����ϰ� �ִ� ������(��)�� ���� ��

--------------------------------------------------------------------------------
/*
    * �⺻�� (DEFAULT)
     : ���������� �ƴ�
       �÷��� �������� �ʰ� ������ �߰� �� NULL���� �߰��Ǵµ�
       �� ��, NULL���� �ƴ� �ٸ� ������ �����ϰ��� �� �� ������
       
       DEFAULT �����ұ⺻�� -> ���·� �ۼ�
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER,
    HOBBY VARCHAR2(30) DEFAULT '����',
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'JHY', '28', '���ǰ���', SYSDATE);
INSERT INTO MEMBER VALUES(2, 'DHY', '25', '����', SYSDATE);
INSERT INTO MEMBER VALUES(3, 'GHY', '26', NULL, SYSDATE);

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES (4, '��');
--> �������� ���� �÷��� ���� ���� �⺻������ NULL���� �����
--  ��, �ش� �÷��� �⺻ ���� �����Ǿ� ���� ��� NULL���� �ƴ϶� �⺻������ ����ȴ�

--------------------------------------------------------------------------------
/*
    * ���̺� ���� *
        CREATE TABLE ���̺��
        AS ��������;
*/

-- MEMBER ���̺� ����
CREATE TABLE MEMBER_COPY
AS SELECT * FROM MEMBER;

SELECT * FROM MEMBER_COPY;
--> ���� ������ �������� ����

/*
    * ���̺��� ��������� �����ϰ��� �� �� *
      => ALTER TABLE ���̺�� �����ҳ���
    
    [������ ����]�� �ۼ�
    - NOT NULL : MODIFY �÷��� NOT NULL;
    - UNIQUE : ADD UNIQUE(�÷���);
    - CHECK : ADD CHECK(���ǽ�);
    - PRIMARY KEY : ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ���������̺�� (�������÷���);
    - DEFAULT �ɼ� : MODIFY �÷��� DEFAULT �⺻��;
*/

-- MEMBER_COPY ���̺� ȸ����ȣ �÷��� �⺻Ű ����
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY(MEM_NO);

-- MEMBER_COPY ���̺� ��� �÷��� �⺻�� ���� - '����' 
ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '-';

