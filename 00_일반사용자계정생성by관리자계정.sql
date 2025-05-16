-- �� �� �ּ�
/*
    ���� �� �ּ�
*/

-- ���� ��� �����鿡 ���Ͽ� ��ȸ�ϴ� ��ɹ�
SELECT * FROM DBA_USERS;
-- ��ɹ�(sql) ���� : �����ư Ŭ�� �Ǵ� Ctrl + Enter �Է�

-- �Ϲ� ����� ���� ���� ���� --> ������ �������θ� ���� ������
-- [ǥ����] CREATE USER ������ IDENFITIED BY ��й�ȣ;
-- *12C �������ʹ� ������ �տ� C##�� �ٿ���� ��

-- (1) ����ڸ�: KH, ��й�ȣ: KH�� ���� �߰�
CREATE USER C##KH IDENTIFIED BY KH;

-- ���� ���� �� C##�� �����ϰ� ���� ���ó�� �ϰ��� �� ���
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- * �� ��ɹ��� SQL Developer ������ ������ ��ɹ��� �����ؾ� ��
CREATE USER KHTEST IDENTIFIED BY KHTEST;

-- (2) ���� �ο�
--      ������ ����ڿ��� �ּ����� ������ �ο�(����, ��ü ���� ����)
--      [ǥ����] GRANT ����1, ����2, ... TO ������
GRANT CONNECT, RESOURCE TO C##KH;
-- CONNECT : ���� ����
-- RESOURCE : ������ ����. DB������ ��ü(���̺�, ������, ���ν���, Ʈ���� ��) ���� ����

-- ���̺� �����̽� ���� ����
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;