/*
    [함수 FUNCTION]
     : 전달된 컬럼값을 읽어서 함수를 실행한 결과를 반환
     
     - 단일행 함수 : 여러 개의 값을 읽어서 여러 개의 결과값을 리턴 (=> 행마다 함수를 실행한 결과를 반환)
     - 그룹 함수 : 여러 개의 값을 읽어서 한 개의 결과값을 리턴 (=>그룹을 지어 그룹별로 함수를 실행한 결과를 반환)
     
     * SELECT절에 단일행 함수와 그룹 함수는 동시에 사용할 수 없음
        => 결과 행의 개수가 다르기 때문에
        
     * 함수식을 사용하는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절 (FROM절 제외하고 사용 가능)
     
*/

--------------------------------- [단일행 함수] ---------------------------------
/*
    문자 타입의 데이터 처리 함수
    -> VARCHAR2(n), CHAR(n)
    
    * LENGTH(컬럼명 또는 '문자열') : 해당 문자열의 글자수를 반환
    * LENGTHB(컬럼명 또는 '문자열') : 해당 문자열의 바이트수를 반환
    
    => 영문자, 숫자, 특수문자 : 글자당 1byte
       한글 : 글자당 3byte               / '김' 'ㄱ' '나' '꽥' -> 모두 3byte
*/

-- '오라클' 단어의 글자수와 바이트 수를 확인
SELECT LENGTH('오라클') 글자수, LENGTHB('오라클') 바이트수
FROM DUAL; -- 임시테이블 사용

-- 'ORACLE'단어의 글자수와 바이트 수를 확인
SELECT LENGTH('ORACLE') 글자수, LENGTHB('ORACLE') 바이트수
FROM DUAL;

-- 사원 정보에서 사원명, 사원명(글자수), 사원명(바이트수)
--              이메일, 이메일(글자수), 이메일(바이트수)
SELECT EMP_NAME 사원명, LENGTH(EMP_NAME) 글자수, LENGTHB(EMP_NAME) 바이트수,
        EMAIL 이메일, LENGTH(EMAIL) 글자수, LENGTHB(EMAIL) 바이트수
FROM EMPLOYEE;


/*
    [INSTR] : 문자열로부터 특장 문자의 시작 위치를 반환
    
    [표현법]
        INSTR(컬럼 또는 '문자열', '찾고자 하는 문자' [, 찾은 위치의 시작값, 순번])
        => 함수 실행 결과값은 숫자타입(NUMBER)
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 앞에서부터 첫번째 B의 위치 : 3
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 시작 위치 : 1 (기본값)
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; 
-- 시작 위치를 음수값을 전달하면, 뒤에서부터 문자를 찾게 됨

SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; 
-- 앞에서부터 두번째 B의 위치 : 9

-- 사원 정보 중 이메일, 이메일의 '_'의 첫번째 위치, 이메일의 '@'의 첫번째 위치
SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) "_위치" , INSTR (EMAIL, '@', 1, 1) "@위치"
FROM EMPLOYEE;


/*
    [SUBSTR] : 문자열에서 특정 문자열을 추출해서 반환
    
    [표현법]
        SUBSTR('문자열' 또는 컬럼, 시작 위치 [, 길이(개수)])
        => 길이를 생략하면 시작위치부터 문자열 끝까지 추출
*/

SELECT SUBSTR('ORACLE SQL DEVELOPER', 12) FROM DUAL;    -- 12번째 위치부터 끝까지 추출

-- 위 문자열에서 SQL만 추출
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL;  -- 8번째 위치부터 3글자만 추출

SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL;    -- 뒤에서 3번째 위치부터 끝까지 추출

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9) FROM DUAL;    -- 뒤에서 9번째 위치부터 끝까지 추출

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; -- 뒤에서부터 9번째 위치부터 3글자만 추출    



-- 사원들 중 여사원들의 이름, 주민번호 조회
SELECT EMP_NAME 이름, EMP_NO 주민번호
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('2','4');
-- EMP_NO 컬럼의 데이터에서 8번째 위치의 한 글자만 추출하여 값을 비교

-- 사원들 중 남사원들의 이름, 주민번호 조회 (사원 이름 기준으로 오름차순 정렬)
SELECT EMP_NAME 이름, EMP_NO 주민번호
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3')
ORDER BY EMP_NAME ASC;  -- ASC는 생략도 가능


-- 함수들은 중첩해서 사용이 가능함

-- 사원 정보 중 사원명, 이메일, 아이디 조회
-- 아이디 : 이메일에서 @앞까지의 데이터
-- 1] 이메일에서 '@' 위치 찾기
-- 2] 이메일 값에서 1번째 위치부터 @위치 전까지 추출
SELECT EMP_NAME "사원명", EMAIL "이메일", SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "아이디"
FROM EMPLOYEE;


/*
    [LPAD / RPAD] : 문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용(정렬된 것처럼 보이게)
    
    [표현법]
        LPAD('문자열' 또는 컬럼, 총 길이 [, '덧붙일 문자']) -- 왼쪽에 덧붙일 문자를 채움
        RPAD('문자열' 또는 컬럼, 총 길이 [, '덧붙일 문자']) -- 오른쪽에 덧붙일 문자를 채움
        => 덧붙일 문자를 생략할 경우 공백으로 채워짐
*/

-- 사원 정보 중 사원명을 왼쪽에 공백을 채워서 20(길이)로 조회
SELECT EMP_NAME, LPAD(EMP_NAME, 20) "사원명"
FROM EMPLOYEE;

-- 사원명의 오른쪽에 공백을 채워 20(길이)로 조회
SELECT EMP_NAME, RPAD(EMP_NAME, 20) "사원명"
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 이메일 조회 (이메일 오른쪽 정렬)
SELECT EMP_NAME "사원명", LPAD(EMAIL, 20) "이메일"
FROM EMPLOYEE;

SELECT EMP_NAME "사원명", RPAD(EMAIL, 20) "이메일"
FROM EMPLOYEE;

SELECT EMP_NAME "사원명", RPAD(EMAIL, 20, '#') "이메일"
FROM EMPLOYEE;

-- 주민번호 성별 이후 뒷자리를 * 처리
SELECT '000201-1', RPAD('000201-1', 14, '*') FROM DUAL;

-- 사원 정보 중 사원명, 주민번호
-- 단, 주민번호는 'XXXXXX-X******' 형식
-- 1] 주민번호 데이터 8자리를 추출
-- 2] 오른쪽을 *로 채움
SELECT EMP_NAME 사원명, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)|| '******'
FROM EMPLOYEE;


/*
    [LTRIM/ RTRIM] : 문자열에서 특정 문자를 제거한 후 나머지를 반환
    
    [표현법]
        LTRIM('문자열' 또는 컬럼 [, '제거할 문자들')
        RTRIM('문자열' 또는 컬럼 [, '제거할 문자들')
        => 제거할 문자 제시하지 않을 경우 공백을 제거해줌
*/

SELECT LTRIM('     H I') FROM DUAL; -- 왼쪽부터 다른 문자가 나올 때까지 공백 제거
SELECT RTRIM('H I     ') FROM DUAL; -- 오른쪽부터 다른문자가 나올 때까지 공백 제거

SELECT LTRIM('123123H123', '123') FROM DUAL; 
SELECT LTRIM('123123H123', '321') FROM DUAL;
SELECT RTRIM('123123H123', '321') FROM DUAL;

--SELECT LTRIM('KKHHII, 123) FROM DUAL;


/*
    - TRIM : 문자열 앞, 뒤, 양쪽에 있는 지정한 문자들을 제거한 후 나머지 값을 반환
    
    [표현법]
        TRIM ([LEADING | TRAVELING | BOTH | [제거할 문자 FROM] 문자열 또는 컬럼)
        * 첫번째 옵션 생략 시 기본값
        * 제거할 문자 생략 시 공백 제거
*/

SELECT TRIM('     H  I    ') FROM DUAL; -- 양쪽 공백들이 제거됨

SELECT TRIM('L' FROM 'LLLLLHLLLLL') FROM DUAL;

SELECT TRIM(BOTH 'L' FROM 'LLLLLHLLLLL') "값" FROM DUAL; -- 기본값 확인
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLLLLL') "값" FROM DUAL; -- LTRIM 과 유사
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLLLLL') "값" FROM DUAL; -- RTRIM 과 유사


/*
    - LOWER / UPPER / INITCAP
     - LOWER : 문자열을 모두 소문자로 변경하여 결과 반환
     - UPPER : 문자열을 모두 대문자로 변경하여 결과 반환
     - INITCAP : 띄어쓰기를 기준으로 첫 글자마자 대문자로 변경하여 결과 반환
*/

-- Oh my god
SELECT LOWER('Oh my god') FROM DUAL;
SELECT UPPER('Oh my god') FROM DUAL;
SELECT INITCAP('Oh my god') FROM DUAL;


/*
    - CONCAT : 문자열 두 개를 하나의 문자열로 합친 후 반환
    
    [표현법] 
        CONCAT(문자열1, 문자열2)
*/

SELECT 'KH' || ' A강의장' FROM DUAL;
SELECT CONCAT('KH', ' A강의장') FROM DUAL;

-- 사원 정보 중 사원명 조회 ( {사원명}님 형식으로 조회)
SELECT CONCAT(EMP_NAME, '님') "사원명"
FROM EMPLOYEE;

SELECT EMP_NAME || '님' "사원명"
FROM EMPLOYEE;

-- 200 성동일님 형식으로 조회 CONCAT 사용
SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '님')) "사원명"
FROM EMPLOYEE;


/*
    - REPLACE : 문자열에서 특정 부분을 제시한 문자열로 교체하여 반환
                *실제 데이터는 변경되지 않음
    [표현법]
        REPLACE(문자열 또는 컬럼, 찾을 문자열, 변경할 문자열)
*/

SELECT REPLACE('서울시 강남구', '강남구', '종로구') FROM DUAL;

-- 사원 정보 중 이메일 데이터의 '@kh.or.kr' 부분을 '@gmail.com'으로 변경하여 조회
SELECT EMAIL 이메일, REPLACE(EMAIL, '@kh.or.kr', '@gmail.com') "변경된 이메일"
FROM EMPLOYEE;

// ============================================================================

/*
    [숫자 타입의 함수]
    
    - ABS : 숫자의 절댓값을 구해주는 함수
*/

SELECT ABS(-100) FROM DUAL;

SELECT ABS(-12.34) FROM DUAL;


/*
    - MOD : 두 수를 나눈 나머지 값을 구해주는 함수
    
    MOD(숫자1, 숫자2) ---> 숫자1 % 숫자2
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;


/*
    - ROUND : 반올림한 값을 구해주는 함수
    
    ROUND(숫자 [,반올림할 위치]) : 소숫점 위치까지 반올림한 값을 구해줌
                                생략 시 첫번째 위치에서 반올림
*/

SELECT ROUND(123.456) FROM DUAL;        -- .4 위치에서 반올림
SELECT ROUND(123.456, 1) FROM DUAL;     -- .x5 위치에서 반올림
SELECT ROUND(123.456, 2) FROM DUAL;     -- .xx6 위치에서 반올림
SELECT ROUND(123.456, 2) FROM DUAL;

SELECT ROUND(123.456, -1) FROM DUAL; 
SELECT ROUND(123.456, -2) FROM DUAL;
-- 위치값은 양수로 증가할 수록 소숫점 뒤로 한칸씩 이동,
--         음수로 증가할 수록 소숫점 앞으로 한칸씩 이동(1의 자리, 10의 자리, ...)


/*
    - CEIL   : 올림 처리를 한 결과를 반환해주는 함수
    - FLOOR  : 버림 처리를 한 결과를 반환해주는 함수
        * 두 함수 다 위치를 지정할 수 없음
        
    - TRUNC : 버림처리 한 결과를 반환해주는 함수 (위치 지정 가능)
*/

SELECT CEIL(123.456) FROM DUAL;
SELECT FLOOR(123.456) FROM DUAL;
SELECT TRUNC(123.456) FROM DUAL;    -- FLOOR 함수와 동일
SELECT TRUNC(123.456, 1) FROM DUAL; -- 소숫점 첫째자리에서 버림처리
SELECT TRUNC(123.456, -1) FROM DUAL;-- 1의 자리에서 버림처리


// ============================================================================

/*
    [날짜 타입 관련 함수]
    - SYSDATE : 시스템의 현재 날짜 및 시간을 반환
    - MONTHS_BETWEEN : 두 날짜 사이의 개월 수를 반환
            MONTHS_BETWEEN(날짜A, 날짜B) : 날짜A - 날짜B 개월 수 반환
            날짜 : YY/MM/DD 형식으로 작성
*/
SELECT SYSDATE FROM DUAL;

-- 공부 시작한 지 몇 개월 차일지
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/31')||'개월차' FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/01')||'개월차' FROM DUAL;    -- 원래는 소숫점 형태로 나옴
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/12/01'))||'개월차' FROM DUAL;  -- 소숫점 올림 하기

SELECT MONTHS_BETWEEN('25/06/18', SYSDATE) || '개월 남았습니다' FROM DUAL;
SELECT FLOOR(MONTHS_BETWEEN('25/06/18', SYSDATE)) || '개월 남았습니다' "~수료까지..." FROM DUAL;


-- 사원 정보 중 사원명, 입사일, 근속개월수
SELECT EMP_NAME 사원명, HIRE_DATE 입사일,
        CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "근속 개월 수"
FROM EMPLOYEE
WHERE ENT_YN = 'N';
-- WHERE ENT_DATE IS NULL;


/*
    - ADD_MONTHS : 특정 날짜에 n개월 수를 더해서 반환
                ADD_MONTHS(날짜, 더할개월수)
*/

-- 현재 날짜 기준 3개월 후
SELECT SYSDATE 오늘, ADD_MONTHS(SYSDATE, 3) "3개월 후" FROM DUAL;

-- 사원 정보 중 사원명, 입사일, 수습종료일 조회
SELECT EMP_NAME "사원명", HIRE_DATE "입사일", ADD_MONTHS(HIRE_DATE, 3) "수습 종료일"
FROM EMPLOYEE;


/*
    - NEXT_DAY : 특정 날짜 이후 지정한 요일의 가장 가까운 날짜를 반환
                NEXT_DAY(날짜, 요일)
                요일 => 숫자 또는 문자
                1: 일, 2: 월, ... 7: 토
*/

-- 현재 날짜 기준 가장 가까운 일요일의 날짜 조회
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- 숫자 타입은 언어 관계 없이 실행됨

SELECT NEXT_DAY(SYSDATE, '일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL;
-- 언어 설정 : KOREAN
-- 문자 타입으로 전달 시 언어 설정에 따라 사용할 수 있음

-- 언어 설정 : AMERICAN
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUN') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일') FROM DUAL;


/*
    - LAST_DAY : 해당 월의 마지막 날짜를 반환해주는 함수
*/

SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 사원 정보 중 사원명, 입사일, 입사한 달의 마지막 날짜, 입사한 달의 근무일수 조회
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, LAST_DAY(HIRE_DATE) "입사한 달의 마지막 날",
        LAST_DAY(HIRE_DATE) - HIRE_DATE +1 "입사 월의 근무일수"
FROM EMPLOYEE;


/*
    - EXTRACT : 특정 날짜로부터 연도/월/일 값을 추출하여 반환하는 함수
    
                EXTRACT(YEAR FROM 날짜)  : 해당 날씨의 연도만 추출
                EXTRACT(MONTH FROM 날짜) : 해당 날짜의 월만 추출
                EXTRACT(DAY FROM 날짜)   : 해당 날짜의 일만 추출
*/

-- 현재 날짜의 연도/ 월/ 일을 각각 추출하여 조회
SELECT SYSDATE,
        EXTRACT(YEAR FROM SYSDATE) "연도",
        EXTRACT(MONTH FROM SYSDATE) "월",
        EXTRACT(DAY FROM SYSDATE) "일"
FROM DUAL;

-- 사원 정보 중 사원명, 입사년도, 입사월, 입사일 조회 
--             (* 정렬 : 입사년도->입사월->입사일 순으로 오름차순=> ASC)
SELECT EMP_NAME, 
        EXTRACT(YEAR FROM HIRE_DATE) "입사년도",
        EXTRACT(MONTH FROM HIRE_DATE) "입사월",
        EXTRACT(DAY FROM HIRE_DATE) "입사일"
FROM EMPLOYEE
-- ORDER BY EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE);
-- ORDER BY "입사년도", "입사월", "입사일";
ORDER BY 2, 3, 4;


/*
    * 형변환 함수 : 데이터 타입을 변경해주는 함수
                   -> 문자 / 숫자 / 날짜
*/

/*
    TO_CHAR : 숫자 또는 날씨 타입의 값을 문자 타입으로 변경해주는 함수
            TO_CHAR(숫자 또는 날짜 [, 포맷])
*/

-- 숫자타입 -> 문자타입
SELECT 1234 "숫자타입의 데이터", TO_CHAR(1234) "문자타입으로 변경된 숫자" FROM DUAL;

SELECT TO_CHAR(1234) "타입 변경만 한 데이터", TO_CHAR(1234, '999999') "포맷지정데이터" FROM DUAL;
-- => 9 : 개수만큼 자리수를 확보. 오른쪽정렬. 빈자리는 공백으로 채움.

SELECT TO_CHAR(1234) "타입 변경만 한 데이터", TO_CHAR(1234, '000000') "포맷지정데이터" FROM DUAL;
-- => 0 : 개수만큼 자리수를 확보. 오른쪽정렬. 빈자리를 0으로 채움.

SELECT TO_CHAR(1234, 'L999999') "포맷데이터" FROM DUAL;
-- => L : 현재 설정된 나라(언어)의 로컬 화폐단위를 표시. KOREAN -> \(원화), AMERICAN -> $

SELECT TO_CHAR(1234, '$999999') "포맷데이터" FROM DUAL;


SELECT 1000000, TO_CHAR(1000000, 'L9,999,999') FROM DUAL;

-- 사원들의 사원명, 월급, 연봉을 조회 (월급, 연봉은 화폐단위 표시. 3자리씩 구분하여 표시.)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999') 월급
                , TO_CHAR(SALARY*12, 'L999,999,999') 연봉
FROM EMPLOYEE;


// ================================= 20250303 =================================

