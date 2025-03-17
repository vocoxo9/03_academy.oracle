------------------------------------ 250307 ------------------------------------

/*
    DDL : 데이터 정의 언어
    
    오라클에서 제공하는 객체를 새로 만들고 (CREATE)
                            변경하고    (ALTER)
                            삭제하는    (DROP) 언어
    => 실제 데이터가 아닌 규칙/구조를 정의하는 언어
    
    * 오라클에서의 객체(구조) : 테이블, 뷰, 시퀀스, 인덱스, 패키지, 트리거,
                            프로시저, 함수, 동의어, 사용자, ...
*/

/*
    CREATE : 객체를 새로 생성하는 구문
    
    [테이블 생성]
    - 테이블 : 행과 열로 구성되는 가장 기본적인 데이터베이스 객체   
              모든 데이터들은 테이블을 통해 저장된다
              
    - 표현법
    CREATE TABLE 테이블명 (
        컬럼명 자료형(크기),
        컬럼명 자료형,
        컬럼명 자료형,
        ...    
    );
    
    * 자료형
    - 문자 => 반드시 크기 지정해야 함
        CHAR(바이트크기)         : 고정 길이(고정된 길이의 데이터를 담을 경우)
                                -> 지정한 길이보다 작은 길이의 값이 저장될 경우 공백으로 채워서 저장함
                                * 최대 2000바이트까지 지정 가능
        VARCHAR2(바이트크기)     : 가변 길이(데이터의 길이가 정해져있지 않은 경우)
                                -> 저장되는 데이터 길이만큼만 공간이 사용됨
                                * 최대 4000바이트까지 지정 가능
    - 숫자 : NUMBER
    - 날짜 : DATE
*/

-- [1] 회원 정보를 저장할 테이블 생성
-- 테이블명 : MEMBER
/*
    [컬럼 정보]
    - 회원 번호     : 숫자 (NUMBER)
    - 회원 아이디    : 문자 (VARCHAR2(20))
    - 회원 비밀번호   : 문자 (VARCHAR2(20))
    - 회원 이름     : 문자 (VARCHAR2(20))
    - 성별        : 문자 (CHAR(3))
    - 연락처       : 문자 (CHAR(13))
    - 이메일       : 문자 (VARCHAR2(50))
    - 가입일       : 날짜 (DATE)
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
    [2] 컬럼에 설명 추가하기
    COMMENT ON COLUMN 테이블명.컬럼명 IS '설명';
    
    #잘못 작성했을 경우 다시 작성 후 실행 --> 덮어씌워짐
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '가입일';

-- 테이블 삭제하기 : DROP TABLE 테이블명;
-- DROP TABLE MEMBER;

-- [3] 테이블에 데이터 추가하기 : INSERT INTO 테이블명 VALUES (값, 값, 값, ...);
INSERT INTO MEMBER VALUES (1, 'jhy123', '1212jhy12', '정혜영', '여', '010-1234-1234', 'jhy1234@gmail.com', SYSDATE);

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES (2, 'iu123', '4321', '아이유', '여', NULL, NULL, SYSDATE);
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT; --> 변경사항 적용
--------------------------------------------------------------------------------
/*
    [제약조건] : 원하는 데이터 값만 유지하기 위해서 특정 컬럼에 설정하는 제약
                데이터 무결성을 보장하기 위한 목적이 있음
                
        - 설정 방식 : 컬럼레벨방식 / 테이블레벨방식
        - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY(기본키), FOREIGN KEY(외래키)
*/

/*
    * NOT NULL *
        : 해당 컬럼에 반드시 값이 존재해야 하는 경우
          => 절대 NULL값이 저장되면 안 되는 경우
          
    * 데이터를 추가(삽입)/수정 시 NULL값을 허용하지 않음
    * 컬럼 레벨 방식으로만 설정 가능하다
*/

-- NOT NULL 제약 조건을 추가한 회원 테이블
-- 테이블명 : MEMBER_NOTNULL
-- 단, 회원번호/아이디/비밀번호/이름에 대한 데이터는 NULL값을 허용하지 않는다
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
    VALUES(1, 'JHY', '1234', '정혜영', '여', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);
INSERT INTO MEMBER_NOTNULL 
    VALUES(2, 'HKD', '2345' , '홍길동', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_NOTNULL 
    VALUES(3, NULL, '3456', '이름', NULL, NULL, NULL, NULL);
--> ! 제약 조건으로 인해 회원 아이디 값이 NULL이라서 오류 발생 (제약조건에 위배됨)

INSERT INTO MEMBER_NOTNULL 
    VALUES(1, 'JHY', '1234', '정혜영', '여', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);
--> ! 중복되는 데이터가 있음에도 추가가 되고 있음


/*
    * UNIQUE *
    : 해당 컬럼에 중복된 값이 있을 경우 제한하는 제약조건
    => 데이터 추가(삽입)/ 수정 시 기존에 있는 데이터 값 중 중복되는 값이 있을 경우 오류 발생
*/

-- UNIQUE 제약 조건을 추가하여 테이블 생성
-- 테이블명 : MEMBER_UNIQUE, 회원 아이디가 중복되지 않도록 제한

CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,    -- 컬럼레벨방식/ NOT NULL, UNIQUE 제약이 설정되어 있음
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    -- , UNIQUE (MEM_ID)    --> 테이블레벨방식/ 마지막에 제약조건(설정할 컬럼) 형태로 작성
);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE 
    VALUES(1, 'JHY', '1234', '정혜영', '여', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES(1, 'JHY', '12345', '정혜영', '여', '010-1255-1255', 'JHY1@GMAIL.COM', SYSDATE);
-- ! UNIQUE 제약 조건에 위배되어 데이터 추가 실패 (오류 발생)
    -- "unique constraint (C##KH.SYS_C008370) violated"
    -- SYS_C008370 = 제약조건명/ 오류 메세지 만으로는 파악하기가 어려움
    --> 제약조건 설정 시 제약조건명을 지정할 수 있음. 지정하지 않으면 시스템에서 자동으로 만들어 줌
    
/*
    * 제약조건명 설정하기
    name already used by an existing constraint -> 제약 조건명은 중복될 수 없음
    [1] 컬럼 레벨 방식
        CREATE TABLE 테이블명(
            컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건
        );
        
    [2] 테이블 레벨 방식
        CREATE TABLE 테이블명(
            컬럼명 자료형,
            컬럼명 자료형,
            ...
            
            [CONSTRAINT 제약조건명] 제약조건 컬럼명
        );
*/

-- MEMBER_UNIQUE 테이블 삭제
DROP TABLE MEMBER_UNIQUE;

-- 제약조건명을 설정하여 재 생성
CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,    -- 컬럼레벨방식/ NOT NULL, UNIQUE 제약이 설정되어 있음
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
     , CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)    --> 테이블레벨방식. 마지막에 제약조건(설정할 컬럼) 형태로 작성
);

INSERT INTO MEMBER_UNIQUE 
    VALUES(1, 'JHY', '1234', '정혜영', '여', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES(2, 'JHY1', '1234', '정혜영', '여', '010-1234-1234', 'JHY@GMAIL.COM', SYSDATE);
    
SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE 
    VALUES(3, 'JHY', '123', '정혜영', '여', '010-1235-1235', 'JHY1@GMAIL.COM', SYSDATE);
    -- unique constraint (C##KH.MEMID_UQ) violated/ 설정한 제약조건명으로 표시됨

INSERT INTO MEMBER_UNIQUE
    VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    -- 제약조건명이 따로 표시되지는 않음
    
    
--------------------------------------------------------------------------------
/*
    * CHECK(조건식) *
     : 해당 컬럼에 저장할 수 있는 값에 대한 조건을 제시함
        조건에 만족하는 값만을 저장할 수 있음
        => 정해진 값만을 저장하고자 할 때 사용함
*/

INSERT INTO MEMBER_UNIQUE 
    VALUES(3, 'JHY2', '123', '정혜영', '뇽', '010-1235-1235', 'JHY1@GMAIL.COM', SYSDATE);
    
-- CHECK 제약 조건을 추가한 테이블 생성
-- 테이블명 : MEMBER_CHECK
-- 성별 컬럼에 '남' 또는 '여' 데이터만 저장될 수 있도록 제한

CREATE TABLE MEMBER_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE

    , UNIQUE (MEM_ID)
--     , CHECK(GENDER IN ('남', '여'))    --> 테이블레벨방식으로 작성
);

SELECT * FROM MEMBER_CHECK;

INSERT INTO MEMBER_CHECK 
    VALUES (1, 'JEONG', '123', '정혜영', '여', NULL, NULL, NULL);
    
INSERT INTO MEMBER_CHECK 
    VALUES (1, 'HEONG', '123', '정혜영', '뇽', NULL, NULL, NULL);
    -- ! 성별 컬럼에 바이트수에 맞게 데이터를 추가 => 체크 제약조건에 위배(오류발생)
    --> CHECK 조건에 맞는 값만 저장 가능
    
INSERT INTO MEMBER_CHECK 
    VALUES (1, 'REONG', '123', '정혜영', NULL, NULL, NULL, NULL);
    -- 성별 컬럼에 NULL값을 저장
    -- ! NULL은 값이 없다는 의미이기 때문에 저장이 가능함
    --> 허용하지 않고자 한다면 NOT NULL 제약조건을 추가하면 됨
    
--------------------------------------------------------------------------------

/*
    * PRIMARY KEY(기본키) *
        : 테이블에서 각 행을 식별하기 위해 사용되는 컬럼에 부여하는 제약조건
        
    ex) 회원번호, 학번, 제품코드, 주문번호, 예약번호, ...
    
    - PRIMARY KEY => NOT NULL + UNIQUE
    - 테이블 당 오직 한 개만 설정 가능함
*/

-- 기본키 제약 조건을 추가하여 테이블 생성
-- 테이블명 : MEMBER_PRI
-- 회원번호에 기본키를 설정

CREATE TABLE MEMBER_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,  -- 기본키로 설정
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE

    , UNIQUE (MEM_ID)
);

SELECT * FROM MEMBER_PRI;

INSERT INTO MEMBER_PRI VALUES (1, 'JHY', '1234', '정혜영', NULL, NULL, NULL, NULL);

INSERT INTO MEMBER_PRI VALUES (1, 'JHY1', '1234', '정혜영', NULL, NULL, NULL, NULL);
--> 기본키 컬럼(회원번호)에 중복된 값이 저장되려고 하여 오류가 발생 (UNIQUE 제약조건에 위배됨)

INSERT INTO MEMBER_PRI VALUES (NULL, 'JHY1', '1234', '정혜영', NULL, NULL, NULL, NULL);
--> 기본키 컬럼(회원번호)에 NULL값을 저장하려고 하여 오류가 발생 (NOT NULL 제약조건에 위배됨)

INSERT INTO MEMBER_PRI VALUES (2, 'JHY2', '1234', '정혜영', NULL, NULL, NULL, NULL);

--------------------------------------------------------------------------------
-- 두 개의 컬럼으로 기본키를 설정하여 테이블 생성
-- 테이블명 : MEMBER_PRI2
-- 회원번호, 회원아이디를 기본키로 설정 (=> 복합키)

CREATE TABLE MEMBER_PRI2 (
    MEM_NO NUMBER,  -- 기본키로 설정
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE

    , UNIQUE (MEM_ID)
    , CONSTRAINT MEMPRI2_PK PRIMARY KEY(MEM_NO, MEM_ID)   -- 기본키가 2개 이상일 때 테이블레벨 방식으로 작성
);

SELECT * FROM MEMBER_PRI2;

INSERT INTO MEMBER_PRI2 VALUES(1, 'JHY', '1234', '정혜영', NULL, NULL, NULL, SYSDATE);
INSERT INTO MEMBER_PRI2 VALUES(1, 'JHI', '1234', '정혜영', NULL, NULL, NULL, SYSDATE);
--> 복합키 : 두 개의 컬럼을 동시에 하나의 기본키로 지정하는 것
-- ! 회원 번호는 동일하나 회원 아이디가 다르기 때문에 데이터가 추가가 됨

-- 어떤 회원이 제품을 장바구니에 담는 정보를 저장하는 테이블
-- 회원번호, 제품명, 저장날짜
CREATE TABLE MEMBER_LIKE (
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(50),
    LIKE_DATE DATE,
    
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

--DROP TABLE MEMBER_LIKE;

SELECT * FROM MEMBER_LIKE;
INSERT INTO MEMBER_LIKE VALUES (1, '보풀제거기', '25/03/01');
INSERT INTO MEMBER_LIKE VALUES (1, '키보드', '25/03/03');

INSERT INTO MEMBER_LIKE VALUES (2, '키보드', '25/03/05');

SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2
    JOIN MEMBER_LIKE USING (MEM_NO);
    
--------------------------------------------------------------------------------
/*
    * FOREIGN KEY (외래키) *
      : 다른 테이블에서 존재하는 값을 저장하고자 할 때 사용되는 제약조건
        -> 다른 테이블을 참조한다고 표현함
        -> 주로 외래키를 통해서 테이블 간의 관계를 형성
        
    - 컬럼레벨방식
        컬럼명 자료형 REFERENCES 참조할테이블명 (참조할컬럼명)
    - 테이블레벨방식
        FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 (참조할컬럼명)
     
    ===> 참조할 컬럼명 생략 시 참조하는 테이블의 기본키 컬럼이 매칭됨
*/

-- 회원 등급 정보를 저장할 테이블 생성
-- 테이블명 : MEMBER_GRADE
-- 등급번호(PK), 등급명(NOT NULL),
CREATE TABLE MEMBER_GRADE(
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP');

SELECT * FROM MEMBER_GRADE;

-- MEMBER 테이블 삭제
-- MEMBER 테이블 생성 : 회원 번호, 회원 아이디, 회원 비밀번호, 회원 이름, 성별, 가입일, 회원등급번호(GRADE_NO)
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    ENROLLDATE DATE,
    -- 컬럼 레벨 방식으로 외래키 설정
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)
    
    -- 테이블 레벨 방식
    -- , FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO)
);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'JHY', '1234', '정혜영', '여', SYSDATE, 100);
INSERT INTO MEMBER VALUES(2, 'HHY', '2345', '홍', '여', SYSDATE, 200);
INSERT INTO MEMBER VALUES(3, 'GHY', '3456', '공', '여', SYSDATE, NULL);
--> 외래키로 설정한 컬럼에는 기본적으로 NULL값 저장 가능
INSERT INTO MEMBER VALUES (4, 'kong44', '1234', '공', '남', sysdate, 400);
--> 오류 발생 "무결성 제약조건 위배 - 부모키가 없습니다" => 회원등급 테이블에 저장되지 않은 값을 사용했을 경우
-- MEMBER_GRADE (부모테이블) -|--------------<- MEMBER (자식테이블)
-- 1 : N 관계, 1(부모테이블) N(자식테이블)

--> 부모테이블(MEMBER_GRADE)에서 "일반회원" 등급을 삭제한다면?
-- 데이터 삭제 : DELETE FROM 테이블명 WHERE 조건;
-- 회원 등급 테이블에서 등급번호가 100인 데이터를 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> ! 자식테이블(MEMBER)에서 100이라는 값을 사용하고 있기 때문에 삭제 불가능함

-- 회원 등급 테이블에서 등급번호가 300인 데이터를 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 300;
--> 자식테이블(MEMBER)에서 300이라는 값은 사용되지 않았기 때문에 삭제 가능함

-- * 자식테이블에서 이미 사용하고 있는 값이 있을 경우 
--   부모테이블로부터 무조건 삭제가 되지 않는 "삭제옵션"이 있음

ROLLBACK;   -- 변경사항을 취소하는 것

SELECT * FROM MEMBER_GRADE;

--------------------------------------------------------------------------------
/*
    * 외래키 제약 조건 - 삭제 옵션
        : 부모테이블의 데이터 삭제 시 해당 데이터를 사용하고 있는 자식테이블의 값을
          어떻게 할 것인지에 대한 옵션
          
    - ON DELETE RESTRICTED (기본값) : 자식테이블로부터 사용 중인 값이 있을 경우
                                     부모테이블에서 데이터를 삭제할 수 없음
    - ON DELETE SET NULL : 부모테이블에 있는 데이터를 삭제했을 때
                            해당 데이터를 사용하고 있는 자식테이블 값을 NULL값으로 변경
    - ON DELETE CASCADE : 부모테이블에 있는 데이터를 삭제했을 때
                            해당 데이터를 사용하고 있는 자식테이블의 값도 삭제
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    ENROLLDATE DATE,
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'JHY', '1234', '정혜영', '여', SYSDATE, 100);
INSERT INTO MEMBER VALUES(2, 'HHY', '2345', '홍', '여', SYSDATE, 200);
INSERT INTO MEMBER VALUES(3, 'GHY', '3456', '공', '여', SYSDATE, NULL);

-- 회원 등급 정보 중 100번 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> 삭제 옵션에 의해 자식테이블인 MEMBER테이블에서 100번을 사용했던 데이터가 NULL로 변경 됨
--> 부모테이블(MEMBER_GRADE)에서 100번에 대한 정보가 삭제 됨

ROLLBACK;
------------------------

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    ENROLLDATE DATE,
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
);

INSERT INTO MEMBER VALUES(1, 'JHY', '1234', '정혜영', '여', SYSDATE, 100);
INSERT INTO MEMBER VALUES(2, 'HHY', '2345', '홍', '여', SYSDATE, 200);
INSERT INTO MEMBER VALUES(3, 'GHY', '3456', '공', '여', SYSDATE, NULL);

SELECT * FROM MEMBER;

-- 회원 등급 중 100번 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> 삭제 옵션에 의해 자식테이블(MEMBER)에서 100번을 사용하고 있던 데이터(행)가 삭제 됨

--------------------------------------------------------------------------------
/*
    * 기본값 (DEFAULT)
     : 제약조건은 아님
       컬럼을 제시하지 않고 데이터 추가 시 NULL값이 추가되는데
       이 때, NULL값이 아닌 다른 값으로 저장하고자 할 때 설정함
       
       DEFAULT 저장할기본값 -> 형태로 작성
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER,
    HOBBY VARCHAR2(30) DEFAULT '없음',
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'JHY', '28', '음악감상', SYSDATE);
INSERT INTO MEMBER VALUES(2, 'DHY', '25', '게임', SYSDATE);
INSERT INTO MEMBER VALUES(3, 'GHY', '26', NULL, SYSDATE);

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES (4, '용');
--> 지정하지 않은 컬럼에 대한 값은 기본적으로 NULL값이 저장됨
--  단, 해당 컬럼에 기본 값이 설정되어 있을 경우 NULL값이 아니라 기본값으로 저장된다

--------------------------------------------------------------------------------
/*
    * 테이블 복제 *
        CREATE TABLE 테이블명
        AS 서브쿼리;
*/

-- MEMBER 테이블 복제
CREATE TABLE MEMBER_COPY
AS SELECT * FROM MEMBER;

SELECT * FROM MEMBER_COPY;
--> 제약 조건은 복제되지 않음

/*
    * 테이블의 변경사항을 적용하고자 할 때 *
      => ALTER TABLE 테이블명 변경할내용
    
    [변경할 내용]에 작성
    - NOT NULL : MODIFY 컬럼명 NOT NULL;
    - UNIQUE : ADD UNIQUE(컬럼명);
    - CHECK : ADD CHECK(조건식);
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 (참조할컬럼명);
    - DEFAULT 옵션 : MODIFY 컬럼명 DEFAULT 기본값;
*/

-- MEMBER_COPY 테이블에 회원번호 컬럼에 기본키 설정
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY(MEM_NO);

-- MEMBER_COPY 테이블에 취미 컬럼에 기본값 설정 - '없음' 
ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '-';

