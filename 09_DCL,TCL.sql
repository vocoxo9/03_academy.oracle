/*
    DCL(Data Control Language) : 데이터 제어 언어
    
    => 계정에 시스템 권한/객체 접근 권한을 부여(GRANT)하거나 회수(REVOKE)하는 구문
    
        - 시스템 권한 : DB에 접근하는 권한, 객체를 생성하는 권한
        - 객체 접근 권한 : 특정 객체들을 조작할 수 있는 권한
*/

/*
    * 계정 생성 *
        CREATE USER 계정명 IDENTIFIED BY 비밀번호;
        
    * 권한 부여 *
        GRANT 권한(CONNET, RESOURCE) TO 계정명;
    
    - 시스템 권한 종류 -
        CREATE SESSION :  접속 권한
        CREATE TABLE : 테이블 생성 권한
        CREATE VIEW : 뷰 생성 권한
        CREATE SEQUENCE : 시퀀스 생성 권한
*/

-- SAMPLE/ SAMPLE 계정 생성 --> 관리자 계정으로 생성해야 함
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;

-- 접속 권한 (CREATE SESSION) 부여
GRANT CREATE SESSION TO C##SAMPLE;

-- 테이블 생성 권한 (CREATE TABLE) 부여
GRANT CREATE TABLE TO C##SAMPLE;

-- 테이블 스페이스 할당
ALTER USER C##SAMPLE QUOTA 2M ON USERS;
--> 2M 정도의 테이블 스페이스 공간 할당

---------------------
/*
    * 객체 접근 권한 종류 *
    
    종류      | 접근 객체
    ===========================================
    SELECT   | TABLE, VIEW, SEQUENCE    -- 조회
    INSERT   | TABLE, VIEW              -- 추가
    UPDATE   | TABLE, VIEW              -- 수정
    DELETE   | TABLE, VIEW              -- 삭제
    ===========================================
    
    * 권한 부여 *
    GRANT 권한 종류 ON 특정객체 TO 계정명;
    
    ex) TEST 계정에 KH 계정의 EMPLOYEE테이블을 조회할 수 있는 권한 부여
        GRANT SELECT ON C##KH.EMPLOYEE TO TEST;
    
    * 권한 회수 *
    REVOKE 회수할권한 FROM 계정명;
    
    ex) TEST 계정에 부여했던 KH계정의 EMPLOYEE 테이블을 조회할 수 있는 권한을 회수
        REVOKE SELECT ON KH.EMPLOYEE FROM TEST;
*/
--------------------------------
/*
    ROLE (롤, 규칙) : 특정 권한들을 하나의 집합으로 모아놓은 것
    
    - CONNECT : 접속 권한 (CREATE SESSION)
    - RESOURCE : 자원 관리. 특정 객체 생성 권한
                (CREATE TABLE, CREATE SEQUENCE, ...)
                
*/
-- 롤 정보 조회
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');

--------------------------------------------------------------------------------
/*
    TCL(Transanction Control Language)
    
        - 트랜잭션 : 데이터베이스에서의 논리적 연산 단위
                    데이터의 변경사항들(DML 사용 시)을 하나의 묶음처럼 트랜잭션에 모아둠
                    DML문 한 개를 수행할 때 트랜잭션이 존재하면 해당 트랜잭션에 모아서 같이 처리함
                                                  존재하지 않으면 트랜잭션을 만들어서 묶어줌
                    COMMIT 사용하기 전까지의 변경사항들을 하나의 트랜잭션으로 담게 됨
                    -> 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)
                    
        - 트랜잭션 종류
            * COMMIT; : 변경사항 적용 -> 트랜잭션에 담겨져 있는 변경사항들을 실제 DB에 적용하겠다는 의미
            * ROLLBACK; : 변경사항 취소 -> 트랜잭션에 담겨져 있는 변경사항들을 삭제(취소)하고,
                                         마지막 COMMIT 위치(시점)로 돌아가는 것을 의미함
            * SAVEPOINT 포인트명; : 현재 시점에 변경사항들을 임시로 저장해두는 것을 의미
                                    ROLLBACK 시 전체 변경 사항들을 모두 삭제하지 않고,
                                    해당 위치까지만 취소가 가능함 (=> ROLLBACK 포인트명;)
*/

-- KH 계정으로 접속 변경--

-- EMP01 테이블 삭제
DROP TABLE EMP01;

-- EMP01 테이블 생성 (EMPLOYEE 테이블에서 사번, 사원명, 부서명 정보로 복제)
CREATE TABLE EMP01 AS
(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);

SELECT * FROM EMP01 ORDER BY EMP_ID;

-- 217, 214인 사원 데이터를 삭제(DML)
DELETE FROM EMP01 WHERE EMP_ID IN (217, 214);

ROLLBACK;   -- 변경사항 취소 (트랜잭션 삭제)
DELETE FROM EMP01 WHERE EMP_ID = 217;
DELETE FROM EMP01 WHERE EMP_ID = 214;

COMMIT;     -- 변경사항 적용 (실제 DB에 적용)
ROLLBACK;   -- 마지막 커밋 시점으로 돌아감 (217, 214 사원이 삭제된 시점)

-- 사번이 208, 209, 210번인 사원 삭제
DELETE FROM EMP01 WHERE EMP_ID IN (208, 209, 210);

SAVEPOINT SP;   -- SP라는 이름의 임시로 시점을 저장

-- 사번이 500번인 사원을 추가
INSERT INTO EMP01 VALUES (500, '전한길', '인사관리부');

-- 사번이 211번인 사원 삭제
DELETE FROM EMP01 WHERE EMP_ID = 211;

ROLLBACK TO SP;
COMMIT;     -- SP시점으로 돌아간 뒤 COMMIT을 했기 때문에
            -- DELETE 208,209,210 변경사항만 DB에 적용됨

--------------------------------------------------------------------------------
-- 221번 사원 삭제
DELETE FROM EMP01 WHERE EMP_ID = 221;

-- 테이블 생성(DDL)
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;
SELECT * FROM EMP01 ORDER BY EMP_ID;
--> DDL(CREATE, ALTER, DROP)을 사용하게 되면 기존 트랜잭션에 저장된 변경사항들이 무조건 반영됨(COMMIT)
--  DDL문 사용하기 전에 DML(INSERT, UPDATE, DELETE)로 작성된 쿼리문이 있다면
--  확실하게 트랜잭션 처리(COMMIT/ROLLBACK)한 후에 DDL을 사용해야 함
