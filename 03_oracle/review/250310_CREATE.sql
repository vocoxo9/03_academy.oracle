

/*
빈칸에 적절한 단어를 작성하시오.
(DDL) :CREATE, ALTER, DROP

(DML): INSERT,DELETE,UPDATE

(DQL): SELECT
*/

/*
-- 다음 사용자 계정 접속 후 아래 내용을 작성해주세요.
-- ID/PW  :  TEST250305 / test0305

-- 아래 내용을 추가하기 위한 테이블을 생성해주세요.
-- 각 컬럼별 설명을 추가해주세요.
-- 샘플 데이터를 추가하기 위한 삽입 쿼리문을 작성해주세요.
--  ex) 제목: 삼국지, 저자: 지연, 출판일: 14/02/14, ISBN : 9780394502946
------------------------------------------------------------
*/
/*
	- 도서 정보 테이블 : BOOK
	- 제약 조건
	  - 제목과 저자명은 NULL값을 허용하지 않는다.
	  - ISBN 번호는 중복을 허용하지 않는다.
	- 저장 데이터
	  + 도서 번호 ex) 1, 2, 3, ...
	  + 제목 ex) '삼국지', '어린왕자', '코스모스', ...
	  + 저자 ex) '지연', '생텍쥐페리', '칼 세이건', ...
	  + 출판일 ex) '14/02/14', '22/09/19', ...
	  + ISBN번호 ex) '9780394502946', '9780152048044', ...
*/

------------------------------------------------------------

CREATE TABLE BOOK(
    BOOK_NO NUMBER PRIMARY KEY,
    TITLE VARCHAR2(200) NOT NULL,
    AUTHOR VARCHAR2(200) NOT NULL,
    PUBLICATION DATE,
    ISBN VARCHAR2(50) CONSTRAINT ISBN_UQ UNIQUE
);

COMMENT ON COLUMN BOOK.BOOK_NO IS '도서번호';
COMMENT ON COLUMN BOOK.TITLE IS '제목';
COMMENT ON COLUMN BOOK.AUTHOR IS '저자';
COMMENT ON COLUMN BOOK.PUBLICATION IS '출판일';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN';

INSERT INTO BOOK VALUES(1, '삼국지', '지연', '14/02/14', 9780394502946);
INSERT INTO BOOK VALUES(2, '어린왕자', '생텍쥐페리', '22/09/19', 9780152048044);
INSERT INTO BOOK VALUES(3, '코스모스', '칼 세이건', '25/03/10', 9780579561384);