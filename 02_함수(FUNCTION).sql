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
    [INSTR] : 문자열로부터 특정 문자의 시작 위치를 반환
    
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
        TRIM ([LEADING | TRAVELING | BOTH ] [제거할 문자 FROM] 문자열 또는 컬럼)
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

-- Hello SQL Developer
SELECT LOWER('Hello SQL Developer') FROM DUAL;
SELECT UPPER('Hello SQL Developer') FROM DUAL;
SELECT INITCAP('Hello SQL Developer') FROM DUAL;


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
ALTER SESSION SET LS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- 숫자 타입은 언어 관계 없이 실행됨

SELECT NEXT_DAY(SYSDATE, '일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL;
-- 언어 설정 : KOREAN
-- 문자 타입으로 전달 시 언어 설정에 따라 사용할 수 있음

-- 언어 설정 : AMERICAN
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'MONDAY') FROM DUAL;
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
    
                EXTRACT(YEAR FROM 날짜)  : 해당 날짜의 연도만 추출
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
    TO_CHAR : 숫자 또는 날짜 타입의 값을 문자 타입으로 변경해주는 함수
            TO_CHAR(숫자 또는 날짜 [, 포맷])
*/

-- 숫자타입 -> 문자타입
SELECT 1234 "숫자타입의 데이터", TO_CHAR(1234) "문자타입으로 변경된 숫자" FROM DUAL;

SELECT TO_CHAR(1234) "타입 변경만 한 데이터", TO_CHAR(1234, '999999') "포맷지정데이터" FROM DUAL;
-- => 9 : 개수만큼 자리수를 확보. 오른쪽정렬. 빈자리는 공백으로 채움.

SELECT TO_CHAR(1234) "타입 변경만 한 데이터", TO_CHAR(1234, '000000') "포맷지정데이터" FROM DUAL;
-- => 0 : 개수만큼 자리수를 확보. 오른쪽정렬. 빈자리를 0으로 채움.

SELECT TO_CHAR(1234, 'L000000') "포맷데이터" FROM DUAL;
-- => L : 현재 설정된 나라(언어)의 로컬 화폐단위를 표시. KOREAN -> \(원화), AMERICAN -> $

SELECT TO_CHAR(1234, '$999999') "포맷데이터" FROM DUAL;


SELECT 1000000, TO_CHAR(1000000, 'L9,999,999') FROM DUAL;

-- 사원들의 사원명, 월급, 연봉을 조회 (월급, 연봉은 화폐단위 표시. 3자리씩 구분하여 표시.)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999') 월급
                , TO_CHAR(SALARY*12, 'L999,999,999') 연봉
FROM EMPLOYEE;


// ================================= 20250304 =================================

/*
    날짜타입 -> 문자타입
*/
SELECT SYSDATE, TO_CHAR(SYSDATE) "문자로 변환" FROM DUAL;


/*
    시간 관련 패턴
    
    - HH : 시 정보(HOUR) --> 12시간제
      HH24 : 24시간제
      
    - MI : 분 정보(MINUTE)
    - SS : 초 정보(SECOND)
*/
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;  --> 12시간제
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;  --> 24시간제

SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
--> AM/PM : 오전/ 오후인지 표시


/*
    * 요일 관련 패턴
    - DAY : X요일 -> 월요일, 화요일, ... , 일요일
    - DY  : X    -> 월, 화, 수 ,... , 일
    - D   : 요일을 숫자타입으로 표시(1: 일요일, ..., 7:토요일)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MRM-DD DAY DY D') FROM DUAL;

/*
    * 월 관련 패턴
    - MON, MONTH : X월 -> 3월, 4월, ..., 12월
    - MM : 월 정보를 2자리로 표현
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH') FROM DUAL;


/*
    * 일 관련 패턴
    - DD : 일 정보를 2자리로 표현
    - DDD : 해당 날짜의 해당년도 기준 몇 번째 일수인지
*/
SELECT TO_CHAR(SYSDATE, 'DD') "2자리 표현"
        ,TO_CHAR(SYSDATE, 'DDD') "몇 번째 일" FROM DUAL;


/*
    * 년도 관련 패턴
    - YYYY : 년도를 4자리로 표현
    - YY   : 년도를 2자리로 표현
    
    - RRRR : 년도를 4자리로 표현
    - RR   : 년도를 2자리로 표현
      => 입력된 연도가 00 ~ 49일 때:
            현재 연도의 끝 두 자리가 00 ~ 49 -> 변환된 연도의 앞 두자리가 현재 연도와 동일
            현재 연도의 끝 두 자리가 50 ~ 99 -> 변환된 연도의 앞 두자리는 현재 연도의 앞 두자리의 +1
         입력된 연도가 50 ~ 99일 때:
            현재 연도의 끝 두 자리가 00 ~ 49 -> 변환된 연도의 앞 두자리에 현재 연도의 앞 두 자리 -1
            현재 연도의 끝 두 자리가 50 ~ 99 -> 변환된 연도의 앞 두자리가 현재 연도와 동일
*/

SELECT TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY') "RR사용(50미만)"
        , TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY') "RR사용(50이상)"
        , TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY') "YY사용(50미만)"
        , TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY') "YY사용(50이상)"
FROM DUAL;  
     
     
-- 사원 정보 중, 사원명, 입사 날짜 조회
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') "입사 날짜" 
FROM EMPLOYEE;
--> 표시할 문자(글자) 부분은 큰 따옴표("")로 묶어서 패턴에 반영해야 함
     

/*
    * TO_DATE : 숫자타입 또는 문자타입을 날짜타입으로 변경해주는 함수
    
    TO_DATE(숫자 또는 문자 [, 패턴])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL;   --> 50년 미만은 자동으로 20XX로 설정됨
SELECT TO_DATE(550304) FROM DUAL;   --> 50년 이상은 자동으로 19XX로 설정됨

SELECT TO_DATE(020222) FROM DUAL;   --> 숫자는 0으로 시작하면 안 됨
SELECT TO_DATE('020222') FROM DUAL; --> 0으로 시작하는 경우 문자타입으로 제시

SELECT TO_DATE('20250304 104230') FROM DUAL;    --> 시간을 포함하는 경우, 패턴을 지정해야 함
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS') FROM DUAL;    

-------------------------------------------------------------------------------
/*
    TO_NUMBER : 문자타입의 데이터를 숫자 타입으로 변경시켜주는 함수
    
        TO_NUMBER(문자 [, 패턴])
        -> 기호가 포함되거나 화폐단위를 포함하는 경우 패턴을 지정
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;

SELECT '10000' + '500' FROM DUAL;   --  문자->숫자 자동으로 변환되어 산술연산이 수행됨
SELECT '10,000' + '500' FROM DUAL;

SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;

-------------------------------------------------------------------------------
/*
    NULL 처리 함수
    
    NVL : 해당 컬럼의 값이 NULL일 경우 다른 값으로 사용할 수 있도록 변경해주는 함수
    [표현법] NVL(컬럼명, 해당 컬럼의 값이 NULL인 경우 사용할 값)
*/
-- 사원 정보 중 사원명, 보너스 정보를 조회
-- 단, 보너스 값이 NULL인 경우 0으로 표시되도록
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 보너스, 연봉, 보너스 포함 연봉 정보를 조회
SELECT EMP_NAME, NVL(BONUS, 0) "BONUS", SALARY*12 "연봉",
        (SALARY +(SALARY*NVL(BONUS,0))) *12 "보너스 포함 연봉"
FROM EMPLOYEE;

/*
    NVL2 : 해당 컬럼의 값이 NULL인 경우 표시할 값을 지정하고,
                         NULL이 아닌 경우 표시할 값도 지정할 수 있는 함수
                         -> 데이터가 있는 경우
    [표현법] NVL2(컬럼명, 데이터가 존재하는 경우 사용할 값, NULL인 경우 사용할 값)
*/
-- 사원 정보 중 사원명, 보너스 유무 조회(보너스가 있을 경우 O, 없을 경우 X 표시)
SELECT EMP_NAME, BONUS, NVL2(BONUS, 'O', 'X') "보너스 유무"
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 부서코드, 부서배치여부 조회(배치가 된 경우 '배정완료', 배치되지 않은 경우 '미배정' 표시)
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '배정완료', '미배정') "부서 배치 여부"
FROM EMPLOYEE;

/*
    NULLIF : 두 값이 일치하면 NULL, 일치하지 않는다면 비교대상1 반환
    
    [표현법] NULLIF(비교대상1, 비교대상2)
*/

SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '000') FROM DUAL;

--------------------------------------------------------------------------------
/*
    * 선택함수
        DECODE(비교대상, 비교값1, 결과값1, 비교값2, 결과값2, ...)
        
        --> 자바에서 switch문과 유사
        switch(비교대상) {
            case 비교값1 : 결과값1;
            case 비교값2 : 결과값2;
            ...
        }
*/
-- 사원 정보 중 사번, 사원명, 주민번호, 성별 조회
-- 단, 성별은 1:남, 2:여, 그 외:알수없음
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), 1, '남', 2, '여', '알수없음') "성별"
FROM EMPLOYEE;

-- 사원 정보 중 사원명, 기존 급여, 인상된 급여 조회
/*
J7 10% 인상
J6 15% 인상
J5 20% 인상
그 외 5% 인상
*/
SELECT EMP_NAME, SALARY, JOB_CODE,
        DECODE(JOB_CODE, 
                'J7', SALARY*1.1, 
                'J6', SALARY*1.15, 
                'J5', SALARY*1.2, 
                SALARY*1.05) "인상된 급여"
FROM EMPLOYEE;


/*
    CASE WHEN THEN : 조건식에 따라 결과값을 반환해주는 함수
    
    [표현법]
        CASE
            WHEN 조건식1 THEN 결과값1
            WHEN 조건식2 THEN 결과값2
            ...
            ELSE 결과값
        END
        
    --> 자바에서의 if~else문과 유사
*/
-- 사원 정보 중 사원명, 급여, 급여에 따른 등급 조회
/* 
    500 이상 '고급'
    350 이상 '중급'
    그 외 '초급'
*/

SELECT EMP_NAME, SALARY, 
    CASE WHEN SALARY >= 5000000 THEN '고급'
        WHEN SALARY >= 3500000 THEN '중급'
        ELSE '초급' END "급여에 따른 등급"
FROM EMPLOYEE;

--------------------------------------------------------------------------------
---------------------------------- [그룹 함수] ----------------------------------

/*
    SUM : 해당 컬럼의 값들의 총 합을 반환해주는 함수
    
    [표현법] SUM(숫자타입컬럼)
*/
-- 전체 사원들의 총 급여를 조회
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 'XXX,XXX,XXX' 형식으로 조회하고자 한다면...?
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') "총 급여"
FROM EMPLOYEE;

-- 남자 사원들의 총 급여
SELECT SUM(SALARY) "남사원들의 총 급여"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8, 1) = 1;

-- 부서 코드가 D5인 사원들의 총 연봉 조회
SELECT SUM(SALARY*12) "D5 부서의 총 연봉"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*
    AVG : 해당 컬럼의 값들의 평균을 반환해주는 함수
    [표현법] AVG(숫자타입컬럼)
*/
-- 전체 사원들의 평균 급여 조회
SELECT ROUND(AVG(SALARY)) "전체 사원 평균 급여"
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*
    MIN : 해당 컬럼의 값들 중 가장 작은 값을 반환해주는 함수
    [표현법] MIN(모든타입컬럼)
*/
SELECT MIN(EMP_NAME) "문자타입 최솟값", MIN(SALARY) "숫자타입 최솟값", MIN(HIRE_DATE) "날짜타입 최솟값"
FROM EMPLOYEE;

/*
    MAX : 해당 컬럼의 값들 중 가장 큰 값을 반환해주는 함수
    [표현법] MAX(모든타입컬럼)
*/
SELECT MAX(EMP_NAME) "문자타입 최솟값", MAX(SALARY) "숫자타입 최솟값", MAX(HIRE_DATE) "날짜타입 최솟값"
FROM EMPLOYEE;


/*
    COUNT : 행의 갯수를 반환해주는 함수 (단, 조건이 있을 경우 해당 조건에 맞는 행의 갯수를 반환)
    
    [표현법]
    COUNT(*) : 조회된 결과의 모든 행의 갯수를 반환
    COUNT(컬럼) : 해당 컬럼의 값이 NULL이 아닌 것만 행의 갯수로 세어 반환
    COUNT(DISTINCT 컬럼) : 해당 컬럼의 값에서 중복을 제거한 후의 행의 갯수를 세어 반환
        => 중복 제거 시 NULL은 포함하지 않고 갯수가 세어짐
*/
-- 전체 사원 수 를 조회
SELECT COUNT(*) "전체 사원 수" FROM EMPLOYEE;

-- 남직원 수 조회
SELECT COUNT(*) "남직원 수" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

SELECT COUNT(*) "여직원 수" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- 보너스를 받는 사원 수
SELECT COUNT(*) "보너스를 받는 사원 수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS) "보너스를 받는 사원 수"
FROM EMPLOYEE;

-- 부서 배치를 받은 사원 수 조회
SELECT COUNT(DEPT_CODE) "부서 배치를 받은 사원 수" 
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) "소속 사원이 있는 부서 수"
FROM EMPLOYEE;







