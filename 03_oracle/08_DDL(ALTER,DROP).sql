------------------------------------ 250310 ------------------------------------

/*
    * DDL (데이터 정의 언어)
    객체들을 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 구문
*/
-------------------------------------------------------
/*
    * ALTER : 객체를 변경하는 구문
    
    - 테이블에 대한 변경
      [표현법]
            ALTER TABLE 테이블명 변경할내용
                
      * 변경되는 내용 *
        - 컬럼 추가/수정/삭제
        - 제약조건 추가/삭제    --> 수정 불가 (수정하고자 할 경우, 삭제 후 추가하면 됨)
        - 컬럼명/제약조건명/테이블명 변경
*/
-------------------------------------------------------
/*
    * 컬럼 추가/수정/삭제
    
      - 컬럼 추가
            ALTER TABLE 테이블명 ADD 컬럼명 데이터타입 [DEFAULT 기본값] [제약조건];
*/
-- DEPT_TABLE 테이블에 CNAME VARCHAR2(20) 컬럼 추가
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);
--> 새로운 컬럼이 추가되고, 기본적으로 NULL값으로 채워짐

SELECT * FROM DEPT_TABLE;

-- DEPT_TABLE 테이블에 LNAME VARCHAR2(20) 컬럼 추가, 기본값 지정: 한국
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '한국';
--> 새로운 컬럼이 추가되고, 지정한 기본값으로 채워짐
-------------------------------------------------------
/*
    - 컬럼 수정 (MODIFY)
         * 데이터 타입 수정 : MODIFY 컬럼명 변경할데이터타입;
         * 기본값 수정     : MODIFY 컬럼명 DEFAULT 변경할기본값; 
*/
-- DEPT_TABLE 테이블의 DEPT_ID 컬럼을 변경
-- * 데이터 타입 : CHAR(2) -> CHAR(5)
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);

-- * 데이터 타입 : 숫자타입으로 변경 CHAR(5) -> NUMBER
-- ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;
--> 형식 오류 발생 (기존 문자타입에서 숫자타입으로 변경 --> X)

-- DEPT_TABLE 테이블의 DEPT_TITLE 컬럼 변경
-- * 데이터 타입 : VARCHAR2(35) -> VARCHAR2(10)
-- ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10);
--> 크기 오류 발생

-- * 데이터 타입 : VARCHAR2(35) -> VARCHAR2(50)
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(50);

-- EMP_TABLE 테이블의 SALARY 컬럼 변경
-- * 데이터 타입 : NUMBER -> VARCHAR2(50)
ALTER TABLE EMP_TABLE MODIFY SALARY VARCHAR2(50);
--> 형식 오류 발생

-- 여러 개의 컬럼 변경 가능
-- DEPT_TABLE 테이블의 DEPT_TITLE 컬럼은 VARCHAR2(55),
--                    LNAME 컬럼은 기본값을 코리아로 변경
ALTER TABLE DEPT_TABLE
        MODIFY DEPT_TITLE VARCHAR2(55)  
        MODIFY LNAME DEFAULT '코리아';
-------------------------------------------------------
/*
    - 컬럼 삭제
        ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
*/
-- DEPT_TABLE 테이블을 DEPT_COPY 테이블로 복제
CREATE TABLE DEPT_COPY
AS ( SELECT * FROM DEPT_TABLE );

SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에서 LNAME 컬럼 삭제
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
--> ! 오류 발생. 테이블에는 최소한 한 개의 컬럼은 존재해야 함
---------------------------------------------------------------
/*
    * 제약조건 추가/삭제 (수정: 삭제->추가)
    
    - 제약조건 추가
        * 기본키 (PRIMARY KEY) : ADD PRIMARY KEY (컬럼명);
        * 외래키 (FOREIGN KEY) : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 [(참조할컬럼명)];
        * UNIQUE              : ADD UNIQUE(컬럼명)          --> 중복을 허용하지 않는다
        * CHECK               : ADD CHECK(컬럼에대한 조건식) --> 특정 값들만 저장하고자 할 때 사용. NULL값도 저장 가능
        * NOT NULL            : MODIFY 컬럼명 NOT NULL|NULL --> NULL값을 허용할지 말지에 대한 제약조건
        
    * 제약조건명을 지정하고자 한다면: "CONSTRAINT 제약조건명" 제약조건 
*/
-- DEPT_TABLE 테이블에 
-- DEPT_ID 컬럼에 기본키(PK) 추가 -> DT_PK
-- DEPT_TITLE 컬럼에 UNIQUE 추가 -> DT_UQ
-- LNAME 컬럼에 NOT NULL 추가
ALTER TABLE DEPT_TABLE
        ADD CONSTRAINT DT_PK PRIMARY KEY (DEPT_ID)
        ADD CONSTRAINT DT_UQ UNIQUE(DEPT_TITLE)
        MODIFY LNAME NOT NULL;


-- ALTER TABLE DEPT_TABLE ADD UNIQUE(DEPT_TITLE);
-- > 이미 존재하는 제약조건은 다시 추가할 수 없음
-------------------------------------------------------
/*
    - 제약조건 삭제
        ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
        MODIFY 컬럼명 NULL (-> NOT NULL제약을 NULL로 변경)
*/
-- DEPT_TABLE 테이블에서 기본키 삭제
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_PK;

ALTER TABLE DEPT_TABLE
    DROP CONSTRAINT DT_UQ
    MODIFY LNAME NULL;
-------------------------------------------------------
/*
    * 컬럼명, 제약조건명, 테이블명 변경 (RENAME)
*/
-- 1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 변경할컬럼명
-- DEPT_TABLE 테이블의 DEPT_TITLE 컬럼의 이름을 DEPT_NAME으로 변경
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 변경할제약조건명
-- DEPT_TABLE 테이블의 "DEPT_ID의 NOT NULL 제약조건명"을 "DT_DEPTID_NN" 으로 변경
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008474 TO DT_DEPTID_NN;

-- 3) 테이블명 변경 : RENAME TO 변경할테이블명
ALTER TABLE DEPT_TABLE RENAME TO DEPT_END;
--------------------------------------------------------------------------------
/*
    * DROP : 객체를 삭제하고자 할 때 사용하는 구문
    
    - 테이블 삭제
        DROP TABLE 테이블명
*/
-- DEPT_END 테이블을 삭제
DROP TABLE DEPT_END;
---> 어딘 가에 참조되고 있는 부모테이블은 삭제가 되지 않음
--   지우고자 할 경우 1) 자식테이블을 먼저 삭제한 후 부모테이블 삭제
--                 2) 부모테이블만 삭제하는데, 제약조건까지 삭제
--                      DROP TABLE 테이블명 CASCADE CONSTRAINT
