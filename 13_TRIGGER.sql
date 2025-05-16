/*
    * 트리거 (TRIGGER) *
     : 지정한 테이블에 DML(INSERT, UPDATE, DELETE)문에 의해서 변경사항이 있을 때(이벤트가 발생했을 때)
       자동으로 매번 실행할 내용을 미리 정의해두는 것
       
    ex) 회원 탈퇴 시 기존 회원 테이블에서 데이터 삭제(DELETE)
        탈퇴 회원 테이블에 데이터 추가(INSERT)해야할 때 자동으로 실행...
        
    ex) 신고 횟수가 특정 값을 넘어갔을 때 블랙리스트로 처리
    
    ex) 입출고에 대한 데이터를 관리할 때 해당 상품의 재고 수량을 갱신해야 할 때
*/
-----------------------------------
/*
    * 트리거의 종류 *
    
    - SQL문의 실행 시기에 따른 분류 -
        * BEFORE TRIGGER : 지정한 테이블에 이벤트가 발생하기 전에 트리거 실행
        * AFTER TRIGGER : 지정한 테이블에 이벤트가 발생한 후에 트리거 실행
        
    - SQL문에 의해 영향을 받는 각 행에 따른 분류 -
        * 문장 트리거 : 이벤트가 발생한 SQL문에 대해 딱 한 번만 트리거를 실행
        * 행 트리거 : 해당 SQL문이 실행될 때마다 매번 트리거를 실행
                    - FOR EACH ROW 옵션 설정해야 함.
                    
            :OLD    - BEFORE UPDATE (수정 전 데이터), BEFORE DELETE (삭제 전 데이터)
            :NEW    - AFTER INSERT (추가된 데이터), AFTER UPDATE (수정된 데이터)
*/
-----------------------------------
/*
    * 트리거 생성 *
    CREATE TRIGGER 트리거명                           -- 트리거 기본 정보(이름)
    BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명     -- 이벤트 관련 정보
    [FOR EACH ROW]                                   -- 매번 트리거를 발생 시킬 경우 작성
        --> 이벤트가 발생됐을 때 실행할 내용 프로시저로 작성
        [DECLARE]           -- 변수/상수 선언 및 초기화
        BEGIN               -- 실행부 (SQL문, 조건문, 반복문, ...)
                            -- 이벤트 발생 시 자동으로 처리하고자 하는 구문
        [EXCEPTION]         -- 예외처리부
        END;
        /
*/

-- EMPLOYEE 테이블에 데이터가 추가될 때마다 '신입사원님 환영합니다^^' 화면에 출력
CREATE TRIGGER TRG_EMP01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다.');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES (SEQ_EID.NEXTVAL, '홍길동', '123456-1234567', 'J5', SYSDATE);

SELECT * FROM EMPLOYEE;

-----------------------------------
-- 상품 입고, 출고 관련
-- TB_PRODUCT 테이블 생성    --> 상품 정보를 저장하기 위한 테이블
CREATE TABLE TB_PRODUCT(
    PNO NUMBER PRIMARY KEY,         -- 상품번호
    PNAME VARCHAR2(30) NOT NULL,    -- 상품명
    BRAND VARCHAR2(30) NOT NULL,    -- 브랜드
    PRICE NUMBER DEFAULT 0,         -- 가격
    STOCK NUMBER DEFAULT 0          -- 재고수량
);


-- SEQ_PNO 시퀀스 생성. 시작번호 : 200, 증가값 : 5, 캐시메모리 X
CREATE SEQUENCE SEQ_PNO START WITH 200 INCREMENT BY 5 NOCACHE;

-- 샘플데이터 추가
INSERT INTO TB_PRODUCT (PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '아이폰16', '사과');
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '갤럭시25', '샘성', 1200000, 50);
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '샤오미폰', '샤옴미', 900000, 200);

SELECT * FROM TB_PRODUCT;

COMMIT;     -- DB에 적용

-- TB_PDETAIL 테이블 생성    --> 상품 입출고 내역을 저장하기 위한 테이블
CREATE TABLE TB_PDETAIL (
    DNO NUMBER PRIMARY KEY,             -- 입출고내역 번호
    PNO NUMBER REFERENCES TB_PRODUCT,   -- 상품 번호
    DDATE DATE DEFAULT SYSDATE,         -- 입출고일
    AMOUNT NUMBER NOT NULL,             -- 입출고 수량
    DTYPE CHAR(10) CHECK(DTYPE IN ('입고', '출고')) -- 입/출고 종류 
);

-- SEQ_DNO 시퀀스 생성. 캐시메모리 X  ---> 시작 번호 : 1, 증가값 : 1
CREATE SEQUENCE SEQ_DNO NOCACHE;

-- 205번 상품, 오늘 5개 출고
-- TB_PDETAIL 테이블에는 데이터가 추가되어야 함
INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '출고');
-- TB_PRODUCT 테이블에는 데이터를 변경(갱신)해줘야 함 -> 205번 상품의 재고
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PNO = 205;

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PDETAIL;

COMMIT;

-- 200번 상품이 10개 입고
-- TB_PDETAIL 테이블에 데이터 추가
INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');
-- TB_PRODUCT 테이블 업데이트
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PNO = 205;        --> 업데이트를 잘못함. 롤백 필요

ROLLBACK;

INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');

UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PNO = 200; 

--------------------------------------------------------------------------------
/*
    TB_PDETAIL (입출고내역) 테이블에 데이터가 추가되었을 때
    TB_PRODUCT (상품) 테이블에 해당 데이터의 재고 수량을 갱신(업데이트)해야함
    
    - UPDATE 조건 - 
    * 상품이 입고된 경우 -> 해당 상품을 찾아 재고 수량 증가
        UPDATE TB_PRODUCT
            SET STOCK = STOCK + 입고수량(TB_PDETAIL.AMOUNT) ---> :NEW.AMOUNT
        WHERE PNO = 입고된 상품 번호(TB_PDETAIL.PNO)         ---> :NEW.PNO
        
    * 상품이 출고된 경우 -> 해당 상품을 찾아 재고 수량 증가
        UPDATE TB_PRODUCT
            SET STOCK = STOCK - 출고수량(TB_PDETAIL.AMOUNT) ---> :NEW.AMOUNT
        WHERE PNO = 출고된 상품 번호(TB_PDETAIL.PNO)         ---> :NEW.PNO
*/

-- TRG_02 트리거 생성
CREATE TRIGGER TRG_02
AFTER INSERT ON TB_PDETAIL
FOR EACH ROW
BEGIN
    IF :NEW.DTYPE = '입고' THEN   --> :NEW(새로 추가 된 데이터) 중 DTYPE 컬럼의 값이 '입고'인 경우
        UPDATE TB_PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PNO = :NEW.PNO;
    ELSE
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PNO = :NEW.PNO;
    END IF;
END;
/
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PDETAIL;

-- 입고 데이터 추가
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 210, SYSDATE, 7, '입고');

-- 출고 데이터 추가
INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 3, '출고');

-- 시퀀스는 테이블과 별개의 객체이기 때문에 DNO값에 오류가 나도 증가됨 따라서 seq_dno.nextval중 2가 없음
COMMIT;