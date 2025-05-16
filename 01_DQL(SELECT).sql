----------------------------------- 20250227 -----------------------------------
/*
    SELECT : 데이터 조회(추출)
    [표현식]
    
        SELECT 조회하고자 하는 정보 FROM 테이블명;
        
        SELECT 컬럼명1, 컬럼명2, ... 또는 * FROM 테이블명;
*/

-- 모든 사원의 정보를 조회
SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름, 주민번호, 연락처를 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE;                  -- FROM절부터 조회함

SELECT EMP_NAME AS "이름", EMP_NO AS "주민번호", PHONE AS "연락처" FROM EMPLOYEE;

-- 모든 직급의 정보를 조회
SELECT * FROM JOB;

-- 직급 정보 중 직급명만 조회
SELECT JOB_NAME FROM JOB;

-- 사원 테이블에서 사원명, 이메일, 연락처, 입사일, 급여
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;



/*
    컬럼명에 산술 연산 추가하기
    => SELECT절의 컬럼명 작성부분에 산술 연산을 할 수 있음
*/
-- 사원명, 연봉 정보 조회
SELECT EMP_NAME, SALARY*12 AS "연봉" FROM EMPLOYEE;

-- 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉
SELECT EMP_NAME, SALARY, BONUS, SALARY*12,(SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;


/*
    컬럼에 별칭 부여하기
    : 연산식을 사용한 경우 의미를 파악하기 어렵기 때문에
      별칭을 부여하여 명확하고 깔끔하게 조회할 수 있음
      
      1) 컬럼명 별칭
      2) 컬럼명 AS 별칭
      3) 컬럼명 "별칭"
      4) 컬럼명 AS "별칭"
*/

SELECT EMP_NAME 사원명, SALARY AS 급여, BONUS "보너스", (SALARY*12) AS "연봉", (SALARY+(SALARY*BONUS))*12 AS "보너스 포함 연봉"
FROM EMPLOYEE;

-- 현재 날싸시간 정보 : SYSDATE
-- 가상 테이블(임시 테이블) : DUAL
-- 기본적으로 제공해 줌
SELECT SYSDATE FROM DUAL;   --YY/MM/DD 형식으로 조회

-- 모든 사원의 사원명, 입사일, 근무일수 조회
-- 근무일수 = 현재날짜 - 입사일 +1
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE+1 "근무일수"
FROM EMPLOYEE;
-- DATE타입 - DATE타입 => 일 단위로 표시됨


/*
    리터럴(값 자체) : 임의로 지정한 값을 '문자열' 또는 숫자로 표현
    -> SELECT 절에 사용하는 경우 조회된 결과(Result Set)에 반복적으로 표시됨
*/

-- 사원명, 급여, '원' 조회
SELECT EMP_NAME 사원명, SALARY 급여, '원' 원
FROM EMPLOYEE;

/*
    연결 연산자 : ||
    두 개의 컬럼 또는 값과 컬럼을 연결해주는 연산자
*/

-- XXX원 형식으로 급여 정보 조회
SELECT EMP_NAME 사원명, SALARY || '원' 급여
FROM EMPLOYEE;

-- 사번, 이름, 급여를 한 번에 조회
SELECT EMP_ID || EMP_NAME || SALARY "사원 정보"
FROM EMPLOYEE;

-- XXX의 급여는 XXX원입니다. 형식으로 조회
SELECT EMP_NAME || '의 급여는 ' || SALARY || '원입니다.' "급여 정보" 
FROM EMPLOYEE;


/*
    중복 제거 : DISTINCT
    중복된 결과값이 있을 경우 조회 결과를 하나로 표시해 줌
*/
-- 사원테이블에서 직급코드 조회
SELECT JOB_CODE FROM EMPLOYEE;

-- 사원테이블에서 중복 제거하여 직급코드 조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- 사원테이블에서 부서코드 조회(중복 제거)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- *SELECT절에서 DISTINCT는 한 번만 사용 가능함
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;
-- => 한 쌍으로 묶어 중복 제거해줌
------------------------------------------------------------------------------

/*
    WHERE절 : 조회하고자 하는 데이터를 특정 조건에 따라 추출하고자 할 때 사용
    
    [표현식]
        SELECT 컬럼명, 컬럼 또는 데이터 기준 연산식
        FROM 테이블명
        WHERE 조건;
        
    - 비교 연산자
        대소 비교 : > < >= <=
        동등 비교
            - 같은 지 비교 : =
            - 다른 지 비교 : != <> ^=
*/

-- 사원테이블에서 부서코드가 'D9'인 사원들의 정보를 조회
SELECT *                    -- 3) 전체 컬럼의 데이터를 조회
FROM EMPLOYEE               -- 1) EMPLOYEE 테이블에서
WHERE DEPT_CODE = 'D9';     -- 2) DEPT_CODE 컬럼의 값이 D9인

-- 사원 정보 중 부서코드가 D1인 사원들의 사원명, 급여, 부서코드를 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 사원 정보 중 부서코드가 'D1'이 아닌 사원들의 사원명, 급여, 부서코드를 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';
-- WHRER DEPT_CODE <> 'D1';
-- WHERE DEPT_CODE ^= 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 정보를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- 급여가 400만원 미만인 사원들의 사원명, 부서코드 급여 정보를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < 4000000;

--------------------------------------------------------------------------------
-- 실습문제
-- [1]급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회
SELECT EMP_NAME 사원명, SALARY 급여, HIRE_DATE 입사일, SALARY*12 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- [2]연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME 사원명, SALARY 급여, SALARY*12 연봉, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;

-- [3]직급 코드가 'J5'가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_CODE 직급코드, ENT_yn 퇴사여부
FROM EMPLOYEE
WHERE JOB_CODE <> 'J5';
-- != ^=

-- [4]급여가 350만원 이상 600만원 이하인 모든 사원의 사원명, 사번, 급여 조회
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000;

/*
    BETWEEN AND : 조건식에서 사용되는 구문
    ~이상 ~이하인 범위에 대한 조건을 제시하는 구문
    
    컬럼명 BETWEEN A AND B
    해당 컬럼의 값이 A이상 B이하인 경우
*/

-- 급여가 350만원 미만 또는 600만원 초과인 사원의 사원명, 사번, 급여
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

-- -- 급여가 350만원 미만 또는 600만원 초과인 사원의 사원명, 사번, 급여 (NOT 사용)
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY (NOT) BETWEEN 3500000 AND 6000000;도 가능하지만 위의 코드 추천

/*
    IN : 제시한 값들 중에 일치하는 값이 있는 경우를 조회하는 구문
    
    [표현식]
        컬럼명 IN (값1, 값2, 값3, ...)
        
        아래와 동일함
        컬럼명 = 값1 OR 컬럼명 = 값2 OR 컬럼명 = 값3 ...
*/

-- 부서코드가 D6이거나 D8이거나 D5인 사원들의 사원명, 부서코드, 급여를 조회
-- IN 사용 안 한 코드
SELECT EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- IN 사용한 코드
SELECT EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');


----------------------------------- 20250228 -----------------------------------
/*
    [LIKE] : 비교하고자 하는 컬럼의 값이 제시한 특정 패턴에 만족할 경우 조회
            ==> 특정 패턴 : %, _ 를 와일드카드로 사용
            
            [표현식] 비교대상컬럼 LIKE '패턴'
            
            % : 0글자 이상
             ex) 비교대상컬럼 LIKE '문자%' => 비교대상컬럼의 값이 문자로 시작되는 것을 조회
                 비교대상컬럼 LIKE '%문자' => 비교대상컬럼의 값이 문자로 끝나는 것을 조회
                 비교대상컬럼 LIKE '%문자%' => 비교대상컬럼의 값에 문자가 포함되는 것을 조회
                 
            _ : 1글자
             ex) 비교대상컬럼 LIKE '_문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 한글자가 오는 경우를 조회
                 비교대상컬럼 LIKE '__문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 두글자가 오는 경우를 조회
                 비교대상컬럼 LIKE '_문자_' => 비교대상컬럼의 값에서 문자 앞, 뒤로 무조건 한글자씩 오는 경우를 조회
*/

-- 사원들 중 "전"씨 성을 가진 사원의 사원명, 급여, 입사일 조회
SELECT EMP_NAME 사원명, SALARY 급여, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 사원명에 "하"가 포함된 사원의 사원명, 주민번호, 연락처를 조회
SELECT EMP_NAME 사원명, EMP_NO 주민번호, PHONE 연락처
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 사원명에서 가운데 글자가 "하"인 사원명, 연락처 조회 (사원명인 3글자인 사원 중)
SELECT EMP_NAME 사원명, PHONE 연락처
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 사원들 중 연락처의 3번째 자리가 1인 사원의 사번, 사원명, 연락처, 이메일 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, PHONE 연락처, EMAIL 이메일
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- 사원들 중 이메일의 4번째자리가 _인 사원의 사번, 이름, 이메일을 조회
SELECT EMP_ID 사번, EMP_NAME 이름, EMAIL 이메일
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE'#';
-- WHERE EMAIL LIKE '____%';
-- > 와일드카드로 사용되는 문자와 컬럼에 담긴 문자가 동일하기 때문에 모두 와일드카드로 인식 됨
--   따라서, 구분이 필요하다. => ESCAPE 옵션 추가
-- [표현식] 비교대상컬럼 LIKE '패턴' ESCAPE'기호';
-- 와일드카드를 문자로 인식하게끔 함. 일반 문자에는 사용 불가. 와일드카드 앞에 작성



/*
    [IS NULL / IS NOT NULL]
    : 컬럼값에 NULL이 있는 경우 NULL값을 비교할 때 사용되는 연산자
    
    - IS NULL : 컬럼 값이 NULL 값인지 비교
    - IS NOT NULL : 컬럼 값이 NULL값이 아닌지 비교
*/

-- 보너스를 받지 않는 사원들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, SALARY 급여, BONUS 보너스
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 보너스를 받는 사원들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, SALARY 급여, BONUS 보너스
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; 도 가능 => BONUS IS NULL 자체를 부정

-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME 사원명, MANAGER_ID 사수사번, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서배치를 받지 않았지만, 보너스를 받고 있는 사원의 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME 사원명, BONUS 보너스, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- 직급코드가 'J7'이거나 'J2'인 사원들 중에 급여가 200만원 이상인 사원의 모든 정보를 조회
SELECT *
FROM EMPLOYEE
--WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;
WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >= 2000000;
-- 연산자 우선순위 OR 보다 AND가 더 높기 때문에 OR 을 소괄호로 묶어줌

/*
    [연산자 우선순위]
        (0) ()
        (1) 산술연산자 : * / + -
        (2) 연결연산자 : ||
        (3) 비교연산자 : > < >= <= = != <> ^=
        (4) IS NULL / LIKE '패턴' / IN
        (5) BETWEEN AND
        (6) NOT
        (7) AND
        (8) OR
*/

/*
    [정렬] : ORDER BY
            => SELECT문에서 가장 마지막 줄에 작성
            => 실행 순서 또한 마지막
    [표현식]
        SELECT 조회할 컬럼, ...
        FROM 테이블명
        WHERE 조건식
        ORDER BY 정렬기준이 되는 컬럼|별칭|컬럼순번 [ASC|DESC] [NULLS FIRST|NULLS LAST]
        
        * ASC : 오름차순 정렬 (기본값)
        * DESC : 내림차순 정렬
        * NULLS FIRST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 맨 앞에 배치 (DESC인 경우 기본값)
        * NULLS LAST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 맨 뒤에 배치 (ASC인 경우 기본값)
            --> NULL 값을 큰 값으로 분류하여 정렬
*/

-- 모든 사원의 사원명, 연봉 조회 (연봉별 내림차순 정렬)
SELECT EMP_NAME, SALARY*12 연봉
FROM EMPLOYEE
ORDER BY 연봉 DESC;
-- ORDER BY 2 DESC; >>> 컬럼 순번 사용 (오라클에서는 순서가 1부터 시작)
-- ORDER BY SALARY*12 DESC; >>> 정렬기준이 되는 컬럼

-- 보너스 기준으로 정렬
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;     -- 기본값 (ASC, NULLS LAST)
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS LAST;
--ORDER BY BONUS DESC;    -- (DESC일 때 NULLS FIRST 기본 값)

ORDER BY BONUS DESC, SALARY ASC;
-- => 보너스 값을 내림차순 정렬하는데, 보너스 값이 같을 경우 급여의 값을 오름차순 정렬