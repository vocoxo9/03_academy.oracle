/*
    * PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL
        
        오라클 자체에 내장되어 있는 절차적 언어
        SQL문장 내에서 변수 정의, 조건문, 반복문 등을 지원 -> SQL 단점을 보완
        다수의 SQL문을 한번에 실행할 수 있다
        
    * 구조 *
    
    [선언부]           : DECLARE로 시작. 변수나 상수를 초기화하는 부분이다.
    실행부             : BEGIN으로 시작. SQL문 또는 제어문(조건문, 반복문)등의 로직을 작성하는 부분
    [예외처리부]        : EXCEPTION으로 시작. 예외 발생 시 해결(처리)하기 위한 부분
*/

-- 화면에 표시하기 위한 설정
SET SERVEROUTPUT ON;    -- 기본적으로 OFF 되어있음

-- 'HELLO ORACLE' 출력
---> 화면에 출력하고자 할 때 : DBMS_OUTPUT.PUT_LINE(출력할 내용)

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    --> JAVA: System.out.println("Hello Java");
END;
/

--------------------------------------------------------------------------------
/*
    * 선언부 DECLARE *
        : 변수 또는 상수를 선언하는 부분 (선언과 동시에 초기화도 가능하다)
        
    - 데이터타입 선언 종류
        * 일반 타입
        * 레퍼런스 타입
        * ROW 타입
*/
--------------------------------------------
/*
    * 일반 타입 변수 *
    변수명 [CONSTANT] 자료형 [:= 값];
            ㄴ 상수로 선언하고자 할 때 사용
    - 상수 선언 시 CONSTANT 추가
    - 초기화 시 := 기호 사용
*/

-- EID라는 이름의 NUMBER 타입 변수
-- ENAME라는 이름의 VARCHAR2(20) 타입 변수
-- PI라는 이름의 NUMBER 타입 상수 선언 및 3.14라는 값으로 초기화
DECLARE EID NUMBER;
        ENAME VARCHAR2(20);
        PI CONSTANT NUMBER := 3.14;
BEGIN
    -- 변수에 값을 대입
    -- EID 변수에 100이라는 값을 대입
    EID := 100;
    -- ENAME 변수에 본인 이름 대입
    ENAME := '정혜영';
    
    -- 각 변수와 상수에 저장된 값을 화면에 출력
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
    --> 특정 문자와 값(변수)을 연결하고자 할 경우 연결연산자(||)를 사용
END;
/

------------------ 값을 입력 받아 변수에 대입
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    ENAME := '정혜영';
    EID := &사원번호;
    --> 값을 입력받고자 할 경우 '&대체변수명' 형식으로 작성
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

--------------------------------------------
/*
    * 레퍼런스 타입 변수 *
        : 어떤 테이블의 어떤 컬럼의 데이터타입을 참조하여 해당 타입으로 변수를 선언
        
    [표현법]
        변수명 테이블명.컬럼명%TYPE
*/

-- EID라는 변수는 EMPLOYEE 테이블의 EMP_ID 컬럼의 타입을 참조
-- ENAME 변수는 EMPLOYEE 테이블의 EMP_NAME 컬럼의 타입을 참조
-- SAL 변수는 EMPLOYEE 테이블의 SALARY 컬럼의 타입을 참조
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;    
BEGIN
    -- EMPLOYEE 테이블에서 입력 받은 사번에 대한 사원 정보를 조회
    SELECT EMP_ID, EMP_NAME, SALARY
        INTO EID, ENAME, SAL    --> 각 컬럼에 대한 값을 변수에 저장(대입)
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;    -- 사번을 입력 받아 해당 사번의 사원 정보를 조회
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

--------- QUIZ --------
/*
    레퍼런스 타입 변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고
    각 자료형을 EMPLOYEE 테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼과
              DEPARTMENT 테이블의 DEPT_TITLE 컬럼을 참조하도록 한 뒤
    사용자가 입력한 사번의 사원 정보를 조회하여 변수에 담아 출력
    
    => 출력 형식 : 사번, 이름, 직급코드, 급여, 부서명
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
        INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
        JOIN DEPARTMENT ON  DEPT_CODE = DEPT_ID
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || 
                        JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/

--------------------------------------------
/*
    * ROW 타입 변수 *
        : 테이블의 한 행에 대한 모든 컬럼값을 한번에 담을 수 있는 변수
        
    [표현법]
        변수명 테이블명%ROWTYPE;
*/

-- E라는 변수에 EMPLYEE 테이블의 ROW타입 변수 선언
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || TO_CHAR(NVL(E.BONUS,0), '0.0'));
    --> NULL값을 다른 값으로 표시하고자 할 경우
    --> 소수점 표기 패턴 적용
END;
/

--==============================================================================
/*
    * 실행부 (BEGIN) *
    
    조건문
        - 단일 IF문 : IF 조건식 THEN 실행내용 END IF;
        - IF/ELSE문 : IF 조건식 THEN 조건을_만족할때_실행내용
                        ELSE 조건을_만족하지_않을때_실행내용 END IF;
        - IF/ELSIF문 : IF 조건식1 THEN 조건식1을_만족할때_실행내용
                        ELSIF 조건식2 THEN 조건식2를_만족할때_실행내용
                        ... 
                        [ELSE 조건을_만족하지_않을때_실행내용 ]END IF;
        - CASE/WHEN/THEN문
            CASE 비교대상 WHEN 비교값1 THEN 결과값1   -- 비교대상과 비교값1이 같은 경우 결과값1
                        WHEN 비교값2 THEN 결과값2
                        ...
                        ELSE 결과값N               -- 비교값들이 비교대상과 모두 다른 경우
            END;
*/

/*
    사용자에게 사번을 입력받아 해당 사원의 사번, 이름, 급여, 보너스 정보를 조회하여 출력
    각 데이터에 대한 변수 : EID, ENAME, SAL, BONUS
    단, 보너스 값이 0(NULL)인 사원의 경우 "보너스를 받지 않는 사원입니다" 출력
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
        INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    IF BONUS = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사원입니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS);
        --  TO_CHAR(BONUS,'0.0')
    END IF;
END;
/

/*
    사용자로부터 사번을 입력 받아 사원 정보를 조회하여 화면에 표시(사번, 이름, 부서명, 국가정보)
    --> 국가명 : 'KO'인 경우 '국내팀' 표시, 그렇지 않은 경우 '해외팀'표시
    
    * 레퍼런스 타입 변수 : 사번, 이름, 부서명, 국가코드
    * 일반 타입 변수 : 팀 정보를 저장. 문자 타입.
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    WHERE EMP_ID = '&사원_번호';
    --> 공백이 들어갈 경우 '작은따옴표'로 감싸기
    
    IF NCODE = 'KO'
        THEN TEAM := '국내팀';  -- TEAM 변수에 '국내팀' 값을 저장
    ELSE
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
--    DBMS_OUTPUT.PUT_LINE('국가코드 : ' || NCODE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);    
END;
/

--------------------------------------------

DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := &점수;
    
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >= 80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('점수는 ' || SCORE || '이고, 등급은 ' || GRADE || '입니다.');
    IF GRADE = 'F'
        THEN DBMS_OUTPUT.PUT_LINE('재평가 대상입니다.');
    END IF;
END;
/

-- 사번을 입력 받아 해당 사원의 부서코드를 기준으로 부서명을 출력 (JOIN 사용 X)
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(20);
BEGIN
    -- 사번을 입력 받아 해당 사원의 정보를 조회하여 변수에 대입
    SELECT *
     INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    -- 해당 사원의 부서코드 기준으로 부서명 정보 DTITLE 변수에 저장
    DTITLE := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업무'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
                END;
                
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '사원의 소속부서는 ' || DTITLE || '입니다.');
END;
/

--------------------------------------------
/*
    * 반복문 *
    
    - 기본 구문
        LOOP
            반복할 구문
            반복문을 종료할 구문
        END LOOP;
        
        *반복문을 종료할 구문
         1) IF 조건식
                THEN EXIT 
            END IF;
            
         2) EXIT WHEN 조건식;
         
    - FOR LOOP문
        FOR 변수명 IN [REVERSE] 초기값..최종값
        LOOP
            반복할 구문
            [반복문 종료할 구문]
        END LOOP;
        
        * REVERSE : 최종값부터 초기값까지 반복시켜줌
        
    - WHILE LOOP문
        WHILE 조건식
        LOOP
            반복할 구문
            [반복문 종료할 구문]
        END LOOP;
*/

--  기본 구문을 사용하여 'HELLO ORACLE' 다섯 번 출력
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
        N := N+1;
        IF N > 5 THEN EXIT;
            END IF;
    END LOOP;
END;
/

-- FOR LOOP문 사용하여 HELLO ORACLE 5번 출력
BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I || ' HELLO ORACLE');
    END LOOP;
END;
/

-- TEST 테이블 삭제
DROP TABLE TEST;

-- TEST 테이블 생성 : TNO(PK), TDATE
CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);
-- SEQ_TNO 시퀀스 생성. 증가값 : 2, 최댓값 : 1000, 순환X, 캐시메모리X
CREATE SEQUENCE SEQ_TNO INCREMENT BY 2 MAXVALUE 1000 NOCYCLE NOCACHE;
DROP SEQUENCE SEQ_TNO;
-- TEST 테이블에 데이터를 100개 추가. TDATE 값은 현재 날짜 정보로 추가
BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT COUNT(*) FROM TEST;

--==============================================================================
/*
    * 예외처리부 (EXCEPTION) *
    -> 실행 중 발생하는 오류
    
    [표현법]
        EXCEPTION
            WHEN 예외명 THEN 예외처리구문;
            WHEN 예외명 THEN 예외처리구문;
            ...
            WHEN OTHERS THEN 예외처리구문;
            
        * 오라클에서 미리 정의한 예외 => 시스템 예외
            - NO_DATA_FOUND : 조회된 결과가 없을 때
            - TOO_MANY_ROWS : 조회된 결과가 여러 행일 때 (=> 변수에 대입)
            - ZERO_DIVIDE : 0으로 값을 나누려고 할 때
            - DUP_VAL_ON_INDEX : UNIQUE 조건에 위배될 때 (중복이 있는 경우)
            ....
            * OTHERS : 어떤 예외든 발생되었을 때 처리할 수 있는 키 값
*/

-- 사용자에게 숫자를 입력 받아 10을 나눈 결과 출력
DECLARE
    NUM NUMBER;
BEGIN
    NUM := &숫자;
    
    DBMS_OUTPUT.PUT_LINE( 10 / NUM );
    
EXCEPTION   --> 예외처리부 추가
--    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없음!');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없음!');
END;
/

-- EMPLOYEE 테이블에 EMP_ID 컬럼이 기본키로 설정
-- ALTER TABLE EMPLOYEE ADD PRIMARY KEY (EMP_ID);

-- 사용자에게 사번을 입력 받아, 노옹철 사원의 사번을 변경
BEGIN

    UPDATE EMPLOYEE
    SET EMP_ID = '&변경할_사번'
    WHERE EMP_NAME = '노옹철';
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('중복된 사원번호입니다.');
END;
/