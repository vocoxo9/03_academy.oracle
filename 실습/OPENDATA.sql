/*
-- 행정동 :: 문자(가변)
-- 도로명주소 :: 문자(가변)
-- 지번주소 :: 문자(가변)
-- 위도 :: 숫자
-- 경도 :: 숫자
-- 데이터기준일자 :: 날짜
*/

-- 테이블 생성
DROP TABLE TB_CLOTHES_BIN;
CREATE TABLE TB_CLOTHES_BIN(
    DONG_NAME VARCHAR2(30),
    ROAD_ADDRESS VARCHAR2(300),
    LOT_ADDRESS VARCHAR2(500),
    LAT NUMBER,
    LON NUMBER,
    UPDATE_DATE DATE
);

COMMENT ON COLUMN TB_CLOTHES_BIN.DONG_NAME IS '행정동 이름';

select * from tb_clothes_bin;
SELECT distinct dong_name FROM TB_CLOTHES_BIN order by dbms_random.random;

