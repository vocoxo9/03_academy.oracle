

/*
��ĭ�� ������ �ܾ �ۼ��Ͻÿ�.
(DDL) :CREATE, ALTER, DROP

(DML): INSERT,DELETE,UPDATE

(DQL): SELECT
*/

/*
-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  TEST250305 / test0305

-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.
-- �� �÷��� ������ �߰����ּ���.
-- ���� �����͸� �߰��ϱ� ���� ���� �������� �ۼ����ּ���.
--  ex) ����: �ﱹ��, ����: ����, ������: 14/02/14, ISBN : 9780394502946
------------------------------------------------------------
*/
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/

------------------------------------------------------------

CREATE TABLE BOOK(
    BOOK_NO NUMBER PRIMARY KEY,
    TITLE VARCHAR2(200) NOT NULL,
    AUTHOR VARCHAR2(200) NOT NULL,
    PUBLICATION DATE,
    ISBN VARCHAR2(50) CONSTRAINT ISBN_UQ UNIQUE
);

COMMENT ON COLUMN BOOK.BOOK_NO IS '������ȣ';
COMMENT ON COLUMN BOOK.TITLE IS '����';
COMMENT ON COLUMN BOOK.AUTHOR IS '����';
COMMENT ON COLUMN BOOK.PUBLICATION IS '������';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN';

INSERT INTO BOOK VALUES(1, '�ﱹ��', '����', '14/02/14', 9780394502946);
INSERT INTO BOOK VALUES(2, '�����', '�������丮', '22/09/19', 9780152048044);
INSERT INTO BOOK VALUES(3, '�ڽ���', 'Į ���̰�', '25/03/10', 9780579561384);