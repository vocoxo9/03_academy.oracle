------------------------------------ 250311-------------------------------------

/*
    * ������ (SEQUENCE)
        : �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
         ������ ���������� ������ ������ ������Ű�鼭 ����
         
         ex) �����ȣ, ȸ����ȣ, ������ȣ, ... --> �⺻Ű�� ����ߴ� �÷���
*/
----------------------------------------
/*
    * ������ ���� *
    [ǥ����]
        CREATE SEQUENCE ��������
        [START WITH ����]         --> ó�� �߻���ų ���۰��� ���� (���� �� �⺻�� 1)
        [INCREMENT BY ����]       --> �󸶸�ŭ�� ������ų �������� ���� �� ���� (���� �� �⺻�� 1)
        [MAXVALUE ����]           --> �ִ� (���� �� �⺻�� ��û ŭ)
        [MINVALUE ����]           --> �ּڰ� (���� �� �⺻�� 1)
        [CYCLE | NOCYCLE]        --> ���� ��ȯ���� (�⺻�� NOCYCLE)
                                     * CYCLE : ������ ���� �ִ밪�� �����ϸ� �ּڰ����� �ٽ� ��ȯ�ϵ��� ����
                                     * NOCYCLE : ������ ���� �ִ񰪿� �����ϸ� �� �̻� ������Ű�� �ʵ��� ����
        [NOCACHE | CACHE ����]    --> ĳ�ø޸� �Ҵ� ���� (�⺻�� CACHE 20)
                                     * ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ����
                                        �Ź� ȣ��� ������ ���� ��ȣ�� �����ϴ� ���� �ƴ϶�
                                        ĳ�ø޸𸮶�� ������ �̸� �����ص� ���� �����ٰ� ��� (�ӵ��� ����)
                                        
    *���� (��� ��Ģ)
        - ���̺� : TB_
        - �� : VW_
        - ������ : SEQ_
        - Ʈ��Ŀ : TRG_
*/

-- SEQ_TEST ������ ����
CREATE SEQUENCE SEQ_TEST;

-- ���� ������ ������ ������ ��ȸ
SELECT * FROM USER_SEQUENCES;

-- SEQ_EMPNO ������ ����
-- ���۹�ȣ : 300, ������ : 5, �ִ� : 310, ��ȯX, ĳ�ø޸� X
CREATE SEQUENCE SEQ_EMPNO
START WITH 300 
INCREMENT BY 5 
MAXVALUE 310 
NOCYCLE 
NOCACHE;

----------------------------------------
/*
    * ������ ��� *
    
    - ��������.CURRVAL : ���� ������ ���� ��ȸ�� �� ����. 
                        ���������� ������ VEXTVAL�� ������ ���� Ȯ���� �� ����.
    - ��������.NEXTVAL : ������ ���� ���� ���� �������� �߻��� �����.
                        ���� ������ ������ INCREMENT BY�� ������ ����ŭ ������ ��.
*/

-- SEQ_EMPNO�� ���� ������ �� ��ȸ
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> ! ���� �߻� (NEXTVAL�� �� ���� �������� ���� �������� CURRVAL�� ����� �� ����)
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
--> NEXTVAL�� ��� ���� �� ó�� ���� �� ���� ���� Ȯ���� �� ���� : 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300 + 5 => 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 
--> 315 ���� �߻�. �ִ��� 310���� �����Ǿ� �ֱ� ������ �� �̻��� ���� ��ȸ�� �� ����

----------------------------------------
/*
    * ������ ���� *
    ALTER SEQUENCE ��������
    [INCREMENT BY ����]
    [MAXVALUE ����]
    [MINVALUE ����]
    [CYCLE | NOCYCLE]
    [NOCACHE | CACHE ����]
    --> ���� ���� ���� �Ұ�
*/

-- SEQ_EMPNO �������� 10, �ִ밪�� 400���� ����
ALTER SEQUENCE SEQ_EMPNO 
INCREMENT BY 10 
MAXVALUE 400;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310 + 10 => 320

----------------------------------------
/*
    * ������ ���� *
    DROP SEQUENCE ��������;
*/

-- SEQ_EMPNO ������ ����
DROP SEQUENCE SEQ_EMPNO;
SELECT * FROM USER_SEQUENCES;

--------------------------------------------------------------------------------
-- EMPLOYEE ���̺� ������ �����ϱ�
--> ���(EMP_ID) �÷��� ���
-- SEQ_EID ������ ����, ���� : 300, ĳ�ø޸� X, 1�� ����
CREATE SEQUENCE SEQ_EID START WITH 300 NOCACHE /*INCREMENT BY 1*/;

-- ������ ��� : EMPLOYEE ���̺� �����Ͱ� �߰��� ��
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
            VALUES (SEQ_EID.NEXTVAL, '������', '123456-1234567', 'J7', SYSDATE);
SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
            VALUES (SEQ_EID.NEXTVAL, '������', '123456-1234567', 'J7', SYSDATE);
            
ROLLBACK;   -- �ӽõ����� �߰� ���
