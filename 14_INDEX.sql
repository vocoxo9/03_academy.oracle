SELECT COUNT(*) FROM USER_MOCK_DATA;
---------------------------------------

/*
    * 인덱스(INDEX) *
        : 명령문의 처리 속도를 향상시키기 위해 특정 컬럼에 대해 생성하는 객체
        
        - 장점 : 검색 속도가 빨라져서 시스템 성능을 향상시켜줌
        - 단점 : 인덱스를 위한 별도의 저장공간이 필요함
                데이터 변경 작업(DML) 시 인덱스도 함께 업데이트 되어 오히려 성능이 저하될 수 있다
*/

-- USER_INDEX_DATA 테이블 생성 (=> USER_MOCK_DATA 테이블 복제)
CREATE TABLE USER_INDEX_DATA
AS (SELECT * FROM USER_MOCK_DATA);

SELECT COUNT(*) FROM USER_INDEX_DATA;

-- USER_INDEX_DATA 테이블에 기본키를 추가(ID 컬럼)
ALTER TABLE USER_INDEX_DATA
    ADD CONSTRAINT PK_IDX_ID PRIMARY KEY (ID);
    
-- USER_INDEX_DATA 테이블에 UNIQUE 제약조건 추가(EMAIL 컬럼)
ALTER TABLE USER_INDEX_DATA
    ADD CONSTRAINT UQ_IDX_EMAIL UNIQUE(EMAIL);
    
-- 인덱스 정보 조회
SELECT * FROM USER_IND_COLUMNS;

-------------------------------------------

-- 인덱스가 설정되지 않은 테이블 (USER_MOCK_DATA)의 수행 계획 조회
EXPLAIN PLAN FOR
SELECT * FROM USER_MOCK_DATA WHERE ID = 30000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/*
------------------------------------------------------------------------------------
| Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |                |     5 |   665 |   137   (1)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| USER_MOCK_DATA |     5 |   665 |   137   (1)| 00:00:01 |
------------------------------------------------------------------------------------

- Cost : 실행 예상 비용(자원을 얼마만큼 소비하는가) --> 값이 낮을수록 적은 비용으로 검색을 수행
- Rows : 실행 계획에서 Access된 row 수
- Bytes : 실행 계획에서 Access된 Bytes 수

* TABLE ACCESS FULL (full 스캔) : 전체 테이블을 탐색하여 결과를 도출하게 될 것임을 의미

*/

-- 인덱스가 설정된 테이블 (USER_INDE_DATA)
EXPLAIN PLAN FOR
SELECT * FROM USER_INDEX_DATA WHERE ID = 30000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/*
-----------------------------------------------------------------------------------------------
| Id  | Operation                   | Name            | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                 |     1 |    63 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| USER_INDEX_DATA |     1 |    63 |     2   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_IDX_ID       |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------

* TABLE ACCESS BY INDEX ROWID : 인덱스 객체로 참조한 INDEX ROWID로 탐색하여 결과를 도출하게 될 것임을 의미
* INDEX UNIQUE SCAN : 인덱스 객체를 참조하여 탐색 후 결과를 도출하게 될 것임을 의미
*/

-- * 인덱스 추가 *
/*
    CREATE INDEX 인덱스명 ON 테이블명(적용대상);
    
    => 적용대상 : 컬럼, 함수식, 연산식 등
*/

-- USER_INDEX_DATA 테이블의 FIRST_NAME 컬럼에 인덱스 생성
CREATE INDEX INDEX_FIRST_NAME ON USER_INDEX_DATA(FIRST_NAME);

-- ID, FIRST_NAME으로 조회
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

--- 실행 계획 조회
EXPLAIN PLAN FOR
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/*
-----------------------------------------------------------------------------------------------
| Id  | Operation                   | Name            | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                 |     1 |    63 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| USER_INDEX_DATA |     1 |    63 |     2   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_IDX_ID       |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------

*/
-- 조회 조건을 두가지 컬럼으로 자주 사용하게 될 경우 => 결합 인덱스 생성
CREATE INDEX INDEX_FIRST_NAME_ID ON USER_INDEX_DATA(ID, FIRST_NAME);

EXPLAIN PLAN FOR
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/*
-----------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name                | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                     |     1 |    63 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| USER_INDEX_DATA     |     1 |    63 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | INDEX_FIRST_NAME_ID |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------------------
    INDEX RANGE SCAN : 결합 인덱스를 사용할 계획을 나타냄
*/