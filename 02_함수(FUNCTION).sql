/*
    [�Լ� FUNCTION]
     : ���޵� �÷����� �о �Լ��� ������ ����� ��ȯ
     
     - ������ �Լ� : ���� ���� ���� �о ���� ���� ������� ���� (=> �ึ�� �Լ��� ������ ����� ��ȯ)
     - �׷� �Լ� : ���� ���� ���� �о �� ���� ������� ���� (=>�׷��� ���� �׷캰�� �Լ��� ������ ����� ��ȯ)
     
     * SELECT���� ������ �Լ��� �׷� �Լ��� ���ÿ� ����� �� ����
        => ��� ���� ������ �ٸ��� ������
        
     * �Լ����� ����ϴ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING�� (FROM�� �����ϰ� ��� ����)
     
*/

--------------------------------- [������ �Լ�] ---------------------------------
/*
    ���� Ÿ���� ������ ó�� �Լ�
    -> VARCHAR2(n), CHAR(n)
    
    * LENGTH(�÷��� �Ǵ� '���ڿ�') : �ش� ���ڿ��� ���ڼ��� ��ȯ
    * LENGTHB(�÷��� �Ǵ� '���ڿ�') : �ش� ���ڿ��� ����Ʈ���� ��ȯ
    
    => ������, ����, Ư������ : ���ڴ� 1byte
       �ѱ� : ���ڴ� 3byte               / '��' '��' '��' '��' -> ��� 3byte
*/

-- '����Ŭ' �ܾ��� ���ڼ��� ����Ʈ ���� Ȯ��
SELECT LENGTH('����Ŭ') ���ڼ�, LENGTHB('����Ŭ') ����Ʈ��
FROM DUAL; -- �ӽ����̺� ���

-- 'ORACLE'�ܾ��� ���ڼ��� ����Ʈ ���� Ȯ��
SELECT LENGTH('ORACLE') ���ڼ�, LENGTHB('ORACLE') ����Ʈ��
FROM DUAL;

-- ��� �������� �����, �����(���ڼ�), �����(����Ʈ��)
--              �̸���, �̸���(���ڼ�), �̸���(����Ʈ��)
SELECT EMP_NAME �����, LENGTH(EMP_NAME) ���ڼ�, LENGTHB(EMP_NAME) ����Ʈ��,
        EMAIL �̸���, LENGTH(EMAIL) ���ڼ�, LENGTHB(EMAIL) ����Ʈ��
FROM EMPLOYEE;


/*
    [INSTR] : ���ڿ��κ��� Ư�� ������ ���� ��ġ�� ��ȯ
    
    [ǥ����]
        INSTR(�÷� �Ǵ� '���ڿ�', 'ã���� �ϴ� ����' [, ã�� ��ġ�� ���۰�, ����])
        => �Լ� ���� ������� ����Ÿ��(NUMBER)
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- �տ������� ù��° B�� ��ġ : 3
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- ���� ��ġ : 1 (�⺻��)
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; 
-- ���� ��ġ�� �������� �����ϸ�, �ڿ������� ���ڸ� ã�� ��

SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; 
-- �տ������� �ι�° B�� ��ġ : 9

-- ��� ���� �� �̸���, �̸����� '_'�� ù��° ��ġ, �̸����� '@'�� ù��° ��ġ
SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) "_��ġ" , INSTR (EMAIL, '@', 1, 1) "@��ġ"
FROM EMPLOYEE;


/*
    [SUBSTR] : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����]
        SUBSTR('���ڿ�' �Ǵ� �÷�, ���� ��ġ [, ����(����)])
        => ���̸� �����ϸ� ������ġ���� ���ڿ� ������ ����
*/

SELECT SUBSTR('ORACLE SQL DEVELOPER', 12) FROM DUAL;    -- 12��° ��ġ���� ������ ����

-- �� ���ڿ����� SQL�� ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL;  -- 8��° ��ġ���� 3���ڸ� ����

SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL;    -- �ڿ��� 3��° ��ġ���� ������ ����

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9) FROM DUAL;    -- �ڿ��� 9��° ��ġ���� ������ ����

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; -- �ڿ������� 9��° ��ġ���� 3���ڸ� ����    



-- ����� �� ��������� �̸�, �ֹι�ȣ ��ȸ
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('2','4');
-- EMP_NO �÷��� �����Ϳ��� 8��° ��ġ�� �� ���ڸ� �����Ͽ� ���� ��

-- ����� �� ��������� �̸�, �ֹι�ȣ ��ȸ (��� �̸� �������� �������� ����)
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3')
ORDER BY EMP_NAME ASC;  -- ASC�� ������ ����


-- �Լ����� ��ø�ؼ� ����� ������

-- ��� ���� �� �����, �̸���, ���̵� ��ȸ
-- ���̵� : �̸��Ͽ��� @�ձ����� ������
-- 1] �̸��Ͽ��� '@' ��ġ ã��
-- 2] �̸��� ������ 1��° ��ġ���� @��ġ ������ ����
SELECT EMP_NAME "�����", EMAIL "�̸���", SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "���̵�"
FROM EMPLOYEE;


/*
    [LPAD / RPAD] : ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���(���ĵ� ��ó�� ���̰�)
    
    [ǥ����]
        LPAD('���ڿ�' �Ǵ� �÷�, �� ���� [, '������ ����']) -- ���ʿ� ������ ���ڸ� ä��
        RPAD('���ڿ�' �Ǵ� �÷�, �� ���� [, '������ ����']) -- �����ʿ� ������ ���ڸ� ä��
        => ������ ���ڸ� ������ ��� �������� ä����
*/

-- ��� ���� �� ������� ���ʿ� ������ ä���� 20(����)�� ��ȸ
SELECT EMP_NAME, LPAD(EMP_NAME, 20) "�����"
FROM EMPLOYEE;

-- ������� �����ʿ� ������ ä�� 20(����)�� ��ȸ
SELECT EMP_NAME, RPAD(EMP_NAME, 20) "�����"
FROM EMPLOYEE;

-- ��� ���� �� �����, �̸��� ��ȸ (�̸��� ������ ����)
SELECT EMP_NAME "�����", LPAD(EMAIL, 20) "�̸���"
FROM EMPLOYEE;

SELECT EMP_NAME "�����", RPAD(EMAIL, 20) "�̸���"
FROM EMPLOYEE;

SELECT EMP_NAME "�����", RPAD(EMAIL, 20, '#') "�̸���"
FROM EMPLOYEE;

-- �ֹι�ȣ ���� ���� ���ڸ��� * ó��
SELECT '000201-1', RPAD('000201-1', 14, '*') FROM DUAL;

-- ��� ���� �� �����, �ֹι�ȣ
-- ��, �ֹι�ȣ�� 'XXXXXX-X******' ����
-- 1] �ֹι�ȣ ������ 8�ڸ��� ����
-- 2] �������� *�� ä��
SELECT EMP_NAME �����, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)|| '******'
FROM EMPLOYEE;


/*
    [LTRIM/ RTRIM] : ���ڿ����� Ư�� ���ڸ� ������ �� �������� ��ȯ
    
    [ǥ����]
        LTRIM('���ڿ�' �Ǵ� �÷� [, '������ ���ڵ�')
        RTRIM('���ڿ�' �Ǵ� �÷� [, '������ ���ڵ�')
        => ������ ���� �������� ���� ��� ������ ��������
*/

SELECT LTRIM('     H I') FROM DUAL; -- ���ʺ��� �ٸ� ���ڰ� ���� ������ ���� ����
SELECT RTRIM('H I     ') FROM DUAL; -- �����ʺ��� �ٸ����ڰ� ���� ������ ���� ����

SELECT LTRIM('123123H123', '123') FROM DUAL; 
SELECT LTRIM('123123H123', '321') FROM DUAL;
SELECT RTRIM('123123H123', '321') FROM DUAL;

--SELECT LTRIM('KKHHII, 123) FROM DUAL;


/*
    - TRIM : ���ڿ� ��, ��, ���ʿ� �ִ� ������ ���ڵ��� ������ �� ������ ���� ��ȯ
    
    [ǥ����]
        TRIM ([LEADING | TRAVELING | BOTH ] [������ ���� FROM] ���ڿ� �Ǵ� �÷�)
        * ù��° �ɼ� ���� �� �⺻��
        * ������ ���� ���� �� ���� ����
*/

SELECT TRIM('     H  I    ') FROM DUAL; -- ���� ������� ���ŵ�

SELECT TRIM('L' FROM 'LLLLLHLLLLL') FROM DUAL;

SELECT TRIM(BOTH 'L' FROM 'LLLLLHLLLLL') "��" FROM DUAL; -- �⺻�� Ȯ��
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLLLLL') "��" FROM DUAL; -- LTRIM �� ����
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLLLLL') "��" FROM DUAL; -- RTRIM �� ����


/*
    - LOWER / UPPER / INITCAP
     - LOWER : ���ڿ��� ��� �ҹ��ڷ� �����Ͽ� ��� ��ȯ
     - UPPER : ���ڿ��� ��� �빮�ڷ� �����Ͽ� ��� ��ȯ
     - INITCAP : ���⸦ �������� ù ���ڸ��� �빮�ڷ� �����Ͽ� ��� ��ȯ
*/

-- Hello SQL Developer
SELECT LOWER('Hello SQL Developer') FROM DUAL;
SELECT UPPER('Hello SQL Developer') FROM DUAL;
SELECT INITCAP('Hello SQL Developer') FROM DUAL;


/*
    - CONCAT : ���ڿ� �� ���� �ϳ��� ���ڿ��� ��ģ �� ��ȯ
    
    [ǥ����] 
        CONCAT(���ڿ�1, ���ڿ�2)
*/

SELECT 'KH' || ' A������' FROM DUAL;
SELECT CONCAT('KH', ' A������') FROM DUAL;

-- ��� ���� �� ����� ��ȸ ( {�����}�� �������� ��ȸ)
SELECT CONCAT(EMP_NAME, '��') "�����"
FROM EMPLOYEE;

SELECT EMP_NAME || '��' "�����"
FROM EMPLOYEE;

-- 200 �����ϴ� �������� ��ȸ CONCAT ���
SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '��')) "�����"
FROM EMPLOYEE;


/*
    - REPLACE : ���ڿ����� Ư�� �κ��� ������ ���ڿ��� ��ü�Ͽ� ��ȯ
                *���� �����ʹ� ������� ����
    [ǥ����]
        REPLACE(���ڿ� �Ǵ� �÷�, ã�� ���ڿ�, ������ ���ڿ�)
*/

SELECT REPLACE('����� ������', '������', '���α�') FROM DUAL;

-- ��� ���� �� �̸��� �������� '@kh.or.kr' �κ��� '@gmail.com'���� �����Ͽ� ��ȸ
SELECT EMAIL �̸���, REPLACE(EMAIL, '@kh.or.kr', '@gmail.com') "����� �̸���"
FROM EMPLOYEE;

// ============================================================================

/*
    [���� Ÿ���� �Լ�]
    
    - ABS : ������ ������ �����ִ� �Լ�
*/

SELECT ABS(-100) FROM DUAL;

SELECT ABS(-12.34) FROM DUAL;


/*
    - MOD : �� ���� ���� ������ ���� �����ִ� �Լ�
    
    MOD(����1, ����2) ---> ����1 % ����2
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;


/*
    - ROUND : �ݿø��� ���� �����ִ� �Լ�
    
    ROUND(���� [,�Ҽ��� �ڸ���]) : �Ҽ��� ��ġ���� �ݿø��� ���� ������
                                ���� �� ù��° ��ġ���� �ݿø�
*/

SELECT ROUND(123.456) FROM DUAL;        -- .4 ��ġ���� �ݿø�
SELECT ROUND(123.456, 1) FROM DUAL;     -- .x5 ��ġ���� �ݿø�
SELECT ROUND(123.456, 2) FROM DUAL;     -- .xx6 ��ġ���� �ݿø�
SELECT ROUND(123.456, 2) FROM DUAL;

SELECT ROUND(123.456, -1) FROM DUAL; 
SELECT ROUND(123.456, -2) FROM DUAL;
-- ��ġ���� ����� ������ ���� �Ҽ��� �ڷ� ��ĭ�� �̵�,
--         ������ ������ ���� �Ҽ��� ������ ��ĭ�� �̵�(1�� �ڸ�, 10�� �ڸ�, ...)


/*
    - CEIL   : �ø� ó���� �� ����� ��ȯ���ִ� �Լ�
    - FLOOR  : ���� ó���� �� ����� ��ȯ���ִ� �Լ�
        * �� �Լ� �� ��ġ�� ������ �� ����
        
    - TRUNC : ����ó�� �� ����� ��ȯ���ִ� �Լ� (��ġ ���� ����)
*/

SELECT CEIL(123.456) FROM DUAL;
SELECT FLOOR(123.456) FROM DUAL;
SELECT TRUNC(123.456) FROM DUAL;    -- FLOOR �Լ��� ����
SELECT TRUNC(123.456, 1) FROM DUAL; -- �Ҽ��� ù°�ڸ����� ����ó��
SELECT TRUNC(123.456, -1) FROM DUAL;-- 1�� �ڸ����� ����ó��


// ============================================================================

/*
    [��¥ Ÿ�� ���� �Լ�]
    - SYSDATE : �ý����� ���� ��¥ �� �ð��� ��ȯ
    - MONTHS_BETWEEN : �� ��¥ ������ ���� ���� ��ȯ
            MONTHS_BETWEEN(��¥A, ��¥B) : ��¥A - ��¥B ���� �� ��ȯ
            ��¥ : YY/MM/DD �������� �ۼ�
*/
SELECT SYSDATE FROM DUAL;

-- ���� ������ �� �� ���� ������
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/31')||'������' FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/01')||'������' FROM DUAL;    -- ������ �Ҽ��� ���·� ����
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/12/01'))||'������' FROM DUAL;  -- �Ҽ��� �ø� �ϱ�

SELECT MONTHS_BETWEEN('25/06/18', SYSDATE) || '���� ���ҽ��ϴ�' FROM DUAL;
SELECT FLOOR(MONTHS_BETWEEN('25/06/18', SYSDATE)) || '���� ���ҽ��ϴ�' "~�������..." FROM DUAL;


-- ��� ���� �� �����, �Ի���, �ټӰ�����
SELECT EMP_NAME �����, HIRE_DATE �Ի���,
        CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "�ټ� ���� ��"
FROM EMPLOYEE
WHERE ENT_YN = 'N';
-- WHERE ENT_DATE IS NULL;


/*
    - ADD_MONTHS : Ư�� ��¥�� n���� ���� ���ؼ� ��ȯ
                ADD_MONTHS(��¥, ���Ұ�����)
*/

-- ���� ��¥ ���� 3���� ��
SELECT SYSDATE ����, ADD_MONTHS(SYSDATE, 3) "3���� ��" FROM DUAL;

-- ��� ���� �� �����, �Ի���, ���������� ��ȸ
SELECT EMP_NAME "�����", HIRE_DATE "�Ի���", ADD_MONTHS(HIRE_DATE, 3) "���� ������"
FROM EMPLOYEE;


/*
    - NEXT_DAY : Ư�� ��¥ ���� ������ ������ ���� ����� ��¥�� ��ȯ
                NEXT_DAY(��¥, ����)
                ���� => ���� �Ǵ� ����
                1: ��, 2: ��, ... 7: ��
*/

-- ���� ��¥ ���� ���� ����� �Ͽ����� ��¥ ��ȸ
ALTER SESSION SET LS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- ���� Ÿ���� ��� ���� ���� �����

SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') FROM DUAL;
-- ��� ���� : KOREAN
-- ���� Ÿ������ ���� �� ��� ������ ���� ����� �� ����

-- ��� ���� : AMERICAN
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'MONDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;


/*
    - LAST_DAY : �ش� ���� ������ ��¥�� ��ȯ���ִ� �Լ�
*/

SELECT LAST_DAY(SYSDATE) FROM DUAL;
-- ��� ���� �� �����, �Ի���, �Ի��� ���� ������ ��¥, �Ի��� ���� �ٹ��ϼ� ��ȸ
SELECT EMP_NAME �����, HIRE_DATE �Ի���, LAST_DAY(HIRE_DATE) "�Ի��� ���� ������ ��",
        LAST_DAY(HIRE_DATE) - HIRE_DATE +1 "�Ի� ���� �ٹ��ϼ�"
FROM EMPLOYEE;


/*
    - EXTRACT : Ư�� ��¥�κ��� ����/��/�� ���� �����Ͽ� ��ȯ�ϴ� �Լ�
    
                EXTRACT(YEAR FROM ��¥)  : �ش� ��¥�� ������ ����
                EXTRACT(MONTH FROM ��¥) : �ش� ��¥�� ���� ����
                EXTRACT(DAY FROM ��¥)   : �ش� ��¥�� �ϸ� ����
*/

-- ���� ��¥�� ����/ ��/ ���� ���� �����Ͽ� ��ȸ
SELECT SYSDATE,
        EXTRACT(YEAR FROM SYSDATE) "����",
        EXTRACT(MONTH FROM SYSDATE) "��",
        EXTRACT(DAY FROM SYSDATE) "��"
FROM DUAL;

-- ��� ���� �� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ 
--             (* ���� : �Ի�⵵->�Ի��->�Ի��� ������ ��������=> ASC)
SELECT EMP_NAME, 
        EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵",
        EXTRACT(MONTH FROM HIRE_DATE) "�Ի��",
        EXTRACT(DAY FROM HIRE_DATE) "�Ի���"
FROM EMPLOYEE
-- ORDER BY EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE);
-- ORDER BY "�Ի�⵵", "�Ի��", "�Ի���";
ORDER BY 2, 3, 4;


/*
    * ����ȯ �Լ� : ������ Ÿ���� �������ִ� �Լ�
                   -> ���� / ���� / ��¥
*/

/*
    TO_CHAR : ���� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ �������ִ� �Լ�
            TO_CHAR(���� �Ǵ� ��¥ [, ����])
*/

-- ����Ÿ�� -> ����Ÿ��
SELECT 1234 "����Ÿ���� ������", TO_CHAR(1234) "����Ÿ������ ����� ����" FROM DUAL;

SELECT TO_CHAR(1234) "Ÿ�� ���游 �� ������", TO_CHAR(1234, '999999') "��������" FROM DUAL;
-- => 9 : ������ŭ �ڸ����� Ȯ��. ����������. ���ڸ��� �������� ä��.

SELECT TO_CHAR(1234) "Ÿ�� ���游 �� ������", TO_CHAR(1234, '000000') "��������" FROM DUAL;
-- => 0 : ������ŭ �ڸ����� Ȯ��. ����������. ���ڸ��� 0���� ä��.

SELECT TO_CHAR(1234, 'L000000') "���˵�����" FROM DUAL;
-- => L : ���� ������ ����(���)�� ���� ȭ������� ǥ��. KOREAN -> \(��ȭ), AMERICAN -> $

SELECT TO_CHAR(1234, '$999999') "���˵�����" FROM DUAL;


SELECT 1000000, TO_CHAR(1000000, 'L9,999,999') FROM DUAL;

-- ������� �����, ����, ������ ��ȸ (����, ������ ȭ����� ǥ��. 3�ڸ��� �����Ͽ� ǥ��.)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999') ����
                , TO_CHAR(SALARY*12, 'L999,999,999') ����
FROM EMPLOYEE;


// ================================= 20250304 =================================

/*
    ��¥Ÿ�� -> ����Ÿ��
*/
SELECT SYSDATE, TO_CHAR(SYSDATE) "���ڷ� ��ȯ" FROM DUAL;


/*
    �ð� ���� ����
    
    - HH : �� ����(HOUR) --> 12�ð���
      HH24 : 24�ð���
      
    - MI : �� ����(MINUTE)
    - SS : �� ����(SECOND)
*/
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;  --> 12�ð���
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;  --> 24�ð���

SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
--> AM/PM : ����/ �������� ǥ��


/*
    * ���� ���� ����
    - DAY : X���� -> ������, ȭ����, ... , �Ͽ���
    - DY  : X    -> ��, ȭ, �� ,... , ��
    - D   : ������ ����Ÿ������ ǥ��(1: �Ͽ���, ..., 7:�����)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY D') FROM DUAL;

/*
    * �� ���� ����
    - MON, MONTH : X�� -> 3��, 4��, ..., 12��
    - MM : �� ������ 2�ڸ��� ǥ��
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH MM') FROM DUAL;


/*
    * �� ���� ����
    - DD : �� ������ 2�ڸ��� ǥ��
    - DDD : �ش� ��¥�� �ش�⵵ ���� �� ��° �ϼ�����
*/
SELECT TO_CHAR(SYSDATE, 'DD') "2�ڸ� ǥ��"
        ,TO_CHAR(SYSDATE, 'DDD') "�� ��° ��" FROM DUAL;


/*
    * �⵵ ���� ����
    - YYYY : �⵵�� 4�ڸ��� ǥ��
    - YY   : �⵵�� 2�ڸ��� ǥ��
    
    - RRRR : �⵵�� 4�ڸ��� ǥ��
    - RR   : �⵵�� 2�ڸ��� ǥ��
      => �Էµ� ������ 00 ~ 49�� ��:
            ���� ������ �� �� �ڸ��� 00 ~ 49 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ ����
            ���� ������ �� �� �ڸ��� 50 ~ 99 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ �� ���ڸ��� +1
         �Էµ� ������ 50 ~ 99�� ��:
            ���� ������ �� �� �ڸ��� 00 ~ 49 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ �� �� �ڸ� -1
            ���� ������ �� �� �ڸ��� 50 ~ 99 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ ����
*/

SELECT TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY') "RR���(50�̸�)"
        , TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY') "RR���(50�̻�)"
        , TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY') "YY���(50�̸�)"
        , TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY') "YY���(50�̻�)"
FROM DUAL;  
     
     
-- ��� ���� ��, �����, �Ի� ��¥ ��ȸ
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') "�Ի� ��¥" 
FROM EMPLOYEE;
--> ǥ���� ����(����) �κ��� ū ����ǥ("")�� ��� ���Ͽ� �ݿ��ؾ� ��
     

/*
    * TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �������ִ� �Լ�
    
    TO_DATE(���� �Ǵ� ���� [, ����])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL;   --> 50�� �̸��� �ڵ����� 20XX�� ������
SELECT TO_DATE(550304) FROM DUAL;   --> 50�� �̻��� �ڵ����� 19XX�� ������

SELECT TO_DATE(020222) FROM DUAL;   --> ���ڴ� 0���� �����ϸ� �� ��
SELECT TO_DATE('020222') FROM DUAL; --> 0���� �����ϴ� ��� ����Ÿ������ ����

SELECT TO_DATE('20250304 104230') FROM DUAL;    --> �ð��� �����ϴ� ���, ������ �����ؾ� ��
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS') FROM DUAL;    

-------------------------------------------------------------------------------
/*
    TO_NUMBER : ����Ÿ���� �����͸� ���� Ÿ������ ��������ִ� �Լ�
    
        TO_NUMBER(���� [, ����])
        -> ��ȣ�� ���Եǰų� ȭ������� �����ϴ� ��� ������ ����
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;

SELECT '10000' + '500' FROM DUAL;   --  ����->���� �ڵ����� ��ȯ�Ǿ� ��������� �����
SELECT '10,000' + '500' FROM DUAL;

SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;

-------------------------------------------------------------------------------
/*
    NULL ó�� �Լ�
    
    NVL : �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� �������ִ� �Լ�
    [ǥ����] NVL(�÷���, �ش� �÷��� ���� NULL�� ��� ����� ��)
*/
-- ��� ���� �� �����, ���ʽ� ������ ��ȸ
-- ��, ���ʽ� ���� NULL�� ��� 0���� ǥ�õǵ���
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ��� ���� �� �����, ���ʽ�, ����, ���ʽ� ���� ���� ������ ��ȸ
SELECT EMP_NAME, NVL(BONUS, 0) "BONUS", SALARY*12 "����",
        (SALARY +(SALARY*NVL(BONUS,0))) *12 "���ʽ� ���� ����"
FROM EMPLOYEE;

/*
    NVL2 : �ش� �÷��� ���� NULL�� ��� ǥ���� ���� �����ϰ�,
                         NULL�� �ƴ� ��� ǥ���� ���� ������ �� �ִ� �Լ�
                         -> �����Ͱ� �ִ� ���
    [ǥ����] NVL2(�÷���, �����Ͱ� �����ϴ� ��� ����� ��, NULL�� ��� ����� ��)
*/
-- ��� ���� �� �����, ���ʽ� ���� ��ȸ(���ʽ��� ���� ��� O, ���� ��� X ǥ��)
SELECT EMP_NAME, BONUS, NVL2(BONUS, 'O', 'X') "���ʽ� ����"
FROM EMPLOYEE;

-- ��� ���� �� �����, �μ��ڵ�, �μ���ġ���� ��ȸ(��ġ�� �� ��� '�����Ϸ�', ��ġ���� ���� ��� '�̹���' ǥ��)
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') "�μ� ��ġ ����"
FROM EMPLOYEE;

/*
    NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ´ٸ� �񱳴��1 ��ȯ
    
    [ǥ����] NULLIF(�񱳴��1, �񱳴��2)
*/

SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '000') FROM DUAL;

--------------------------------------------------------------------------------
/*
    * �����Լ�
        DECODE(�񱳴��, �񱳰�1, �����1, �񱳰�2, �����2, ...)
        
        --> �ڹٿ��� switch���� ����
        switch(�񱳴��) {
            case �񱳰�1 : �����1;
            case �񱳰�2 : �����2;
            ...
        }
*/
-- ��� ���� �� ���, �����, �ֹι�ȣ, ���� ��ȸ
-- ��, ������ 1:��, 2:��, �� ��:�˼�����
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), 1, '��', 2, '��', '�˼�����') "����"
FROM EMPLOYEE;

-- ��� ���� �� �����, ���� �޿�, �λ�� �޿� ��ȸ
/*
J7 10% �λ�
J6 15% �λ�
J5 20% �λ�
�� �� 5% �λ�
*/
SELECT EMP_NAME, SALARY, JOB_CODE,
        DECODE(JOB_CODE, 
                'J7', SALARY*1.1, 
                'J6', SALARY*1.15, 
                'J5', SALARY*1.2, 
                SALARY*1.05) "�λ�� �޿�"
FROM EMPLOYEE;


/*
    CASE WHEN THEN : ���ǽĿ� ���� ������� ��ȯ���ִ� �Լ�
    
    [ǥ����]
        CASE
            WHEN ���ǽ�1 THEN �����1
            WHEN ���ǽ�2 THEN �����2
            ...
            ELSE �����
        END
        
    --> �ڹٿ����� if~else���� ����
*/
-- ��� ���� �� �����, �޿�, �޿��� ���� ��� ��ȸ
/* 
    500 �̻� '���'
    350 �̻� '�߱�'
    �� �� '�ʱ�'
*/

SELECT EMP_NAME, SALARY, 
    CASE WHEN SALARY >= 5000000 THEN '���'
        WHEN SALARY >= 3500000 THEN '�߱�'
        ELSE '�ʱ�' END "�޿��� ���� ���"
FROM EMPLOYEE;

--------------------------------------------------------------------------------
---------------------------------- [�׷� �Լ�] ----------------------------------

/*
    SUM : �ش� �÷��� ������ �� ���� ��ȯ���ִ� �Լ�
    
    [ǥ����] SUM(����Ÿ���÷�)
*/
-- ��ü ������� �� �޿��� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 'XXX,XXX,XXX' �������� ��ȸ�ϰ��� �Ѵٸ�...?
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') "�� �޿�"
FROM EMPLOYEE;

-- ���� ������� �� �޿�
SELECT SUM(SALARY) "��������� �� �޿�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8, 1) = 1;

-- �μ� �ڵ尡 D5�� ������� �� ���� ��ȸ
SELECT SUM(SALARY*12) "D5 �μ��� �� ����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*
    AVG : �ش� �÷��� ������ ����� ��ȯ���ִ� �Լ�
    [ǥ����] AVG(����Ÿ���÷�)
*/
-- ��ü ������� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY)) "��ü ��� ��� �޿�"
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*
    MIN : �ش� �÷��� ���� �� ���� ���� ���� ��ȯ���ִ� �Լ�
    [ǥ����] MIN(���Ÿ���÷�)
*/
SELECT MIN(EMP_NAME) "����Ÿ�� �ּڰ�", MIN(SALARY) "����Ÿ�� �ּڰ�", MIN(HIRE_DATE) "��¥Ÿ�� �ּڰ�"
FROM EMPLOYEE;

/*
    MAX : �ش� �÷��� ���� �� ���� ū ���� ��ȯ���ִ� �Լ�
    [ǥ����] MAX(���Ÿ���÷�)
*/
SELECT MAX(EMP_NAME) "����Ÿ�� �ּڰ�", MAX(SALARY) "����Ÿ�� �ּڰ�", MAX(HIRE_DATE) "��¥Ÿ�� �ּڰ�"
FROM EMPLOYEE;


/*
    COUNT : ���� ������ ��ȯ���ִ� �Լ� (��, ������ ���� ��� �ش� ���ǿ� �´� ���� ������ ��ȯ)
    
    [ǥ����]
    COUNT(*) : ��ȸ�� ����� ��� ���� ������ ��ȯ
    COUNT(�÷�) : �ش� �÷��� ���� NULL�� �ƴ� �͸� ���� ������ ���� ��ȯ
    COUNT(DISTINCT �÷�) : �ش� �÷��� ������ �ߺ��� ������ ���� ���� ������ ���� ��ȯ
        => �ߺ� ���� �� NULL�� �������� �ʰ� ������ ������
*/
-- ��ü ��� �� �� ��ȸ
SELECT COUNT(*) "��ü ��� ��" FROM EMPLOYEE;

-- ������ �� ��ȸ
SELECT COUNT(*) "������ ��" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

SELECT COUNT(*) "������ ��" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(*) "���ʽ��� �޴� ��� ��"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS) "���ʽ��� �޴� ��� ��"
FROM EMPLOYEE;

-- �μ� ��ġ�� ���� ��� �� ��ȸ
SELECT COUNT(DEPT_CODE) "�μ� ��ġ�� ���� ��� ��" 
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) "�Ҽ� ����� �ִ� �μ� ��"
FROM EMPLOYEE;