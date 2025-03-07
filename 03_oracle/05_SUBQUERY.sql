/*
    서브쿼리(SUB QUERY)
    : 하나의 쿼리문 내에 포함된 또 다른 쿼리문
      메인 역할을 하는 쿼리문을 위해 보조 역할을 하는 쿼리문
*/

-- "노옹철"과 같은 부서에 속한 사원 정보를 조회
-- 노옹철 사원의 부서 코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 부서코드가 D9인 사원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--> 위의 두 쿼리문을 하나로
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');
                    
-- 전체 사원의 평균 급여보다 더 많은 급여를 받는 사원의 정보를 조회
SELECT *                                    -- 2
FROM EMPLOYEE
WHERE SALARY >= (SELECT ROUND(AVG(SALARY))  -- 1
                FROM EMPLOYEE);
                
--------------------------------------------------------------------------------
/*
    서브쿼리의 종류
    서브쿼리를 수행한 결과값이 몇 행 몇 열로 나오냐에 따라 분류된다.
    
    - 단일행 서브쿼리 : 서브쿼리의 결과가 오로지 1개일 때(1행 1열)
    - 다중행 서브쿼리 : 서브쿼리의 결과가 여러개 행일 때 (N행 1열)
    - 다중열 서브쿼리 : 서브쿼리의 결과가 한 행이고 여러 개의 열(컬럼)일때 (1행 N열)
    - 다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행 여러 열(컬럼)일 때 (N행 N열)
    
    >> 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라진다
*/

-------------------------------- [단일행 서브쿼리] --------------------------------
-- >> 일반적인 비교연산자 사용 가능 : = != > < >= <

-- 전 사원의 평균 급여보다 더 적게 급여를 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE ,SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);
                
-- 가장 급여가 적은 사원의  사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE ,SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 노옹철 사원의 급여보다 많이 받는 사원의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

--> 부서코드를 부서명으로 조회하고자 한다면?
-- * 오라클
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- * ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');


-- 부서별로 급여 합이 가장 큰 부서의 부서코드, 급여 합 조회
-- 부서별 부서 코드, 급여 합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 가장 큰 급여 합
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

--> 서브쿼리로 적용
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);
                        
                        
-- 전지연 사원과 같은 부서의 사원들의 사번, 사원명, 연락처, 입사일, 부서명 조회
-- 단, 전지연 사원은 제외하고 조회
-- *오라클
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '전지연')
    AND EMP_NAME != '전지연';  -- 전지연 사원을 제외할 조건

-- *ANSI
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '전지연')
    AND EMP_NAME != '전지연';
    
    
-------------------------------- [다중행 서브쿼리] --------------------------------
/*
    서브쿼리 결과가 여러 행인 경우 (N행 1열)
    IN (서브쿼리) : 여러 개의 결과값 중에 하나라도 일치하는 값이 있을 경우 조회
    
    > ANY(서브쿼리) : 여러 개의 결과값 중에서 하나라도 큰 경우가 있다면 조회
    < ANY(서브쿼리) : 여러 개의 결과값 중에서 하나라도 작은 경우가 있다면 조회
        * 비교대상 > 결과값1 OR 비교대상 > 결과값2 OR 비교대상 > 결과값3 ...
        
    > ALL(서브쿼리) : 여러 개의 모든 결과값보다 클 경우 조회
    < ALL(서브쿼리) : 여러 개의 모든 결과값보다 작을 경우 조회
        * 비교대상 < 결과값1 AND 비교대상 < 결과값2 AND 비교대상 < 결과값3 ...
*/

-- 유재식 사원 또는 윤은해 사원과 같은 직급인 사원들의 정보 조회 (사번, 사원명, 직급코드, 급여)
-- 유재식 사원 또는 윤은해 사원의 직급코드 조회
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해');

-- 직급코드가 J3 또는 J7인 사원들의 정보 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- 서브쿼리 적용하기
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('유재식', '윤은해'));
                    
-- 대리 직급인 사원들 중 과장 직급의 최소 급여보다 많이 받는 사원 정보 조회\
-- 과장 직급의 급여 조회
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- ANY 연산자를 사용하여 비교
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (3760000, 2200000, 2500000)
AND JOB_NAME = '대리';

-- 서브쿼리로 적용
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '과장')
AND JOB_NAME = '대리';


-------------------------------- [다중열 서브쿼리] --------------------------------
/*
    다중열 서브쿼리 : 서브쿼리 결과가 1개 행이고, 여러 개의 열(컬럼)인 경우
*/

-- 하이유 사원과 같은 부서, 같은 직급인 사원의 정보 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- 단일행 서브쿼리를 사용한다면
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유')
AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');

-- 다중열 서브쿼리를 적용
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE 
                                FROM EMPLOYEE 
                                WHERE EMP_NAME = '하이유');

-- 박나라 사원과 직급이 같고, 사수가 동일한 사원의 사원명, 직급코드, 사수 번호 조회
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID 
                                FROM EMPLOYEE 
                                WHERE EMP_NAME = '박나라')
                                AND EMP_NAME <> '박나라';


----------------------------- [다중행 다중열 서브쿼리] -----------------------------
/*
    다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행, 여러 열(컬럼)인 경우
*/

-- 각 직급 별로 최소 급여를 받는 사원 정보를 조회
-- 직급별 최소 급여 조회
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 서브쿼리X
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' AND SALARY = 8000000
    OR JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J4' AND SALARY = 1550000;
    -- ... 
    
-- 서브쿼리를 적용한다면
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                                FROM EMPLOYEE
                                GROUP BY JOB_CODE);SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                                FROM EMPLOYEE
                                GROUP BY JOB_CODE);

--------------------------------------------------------------------------------
/*
    [인라인 뷰]
    : 서브쿼리를 FROM절에 사용하는 것
    => 서브쿼리의 결과를 마치 테이블처럼 사용하는 것
*/

-- 사번, 이름, 보너스 포함 연봉, 부서코드를 조회
-- 단, 보너스 포함 연봉의 결과가 NULL이 아니어야 하고,
-- 보너스 포함 연봉이 3000만원 이상인 사원들만 조회
SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY*NVL(BONUS,0)))*12 "보너스 포함 연봉", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + (SALARY*NVL(BONUS,0)))*12 >= 30000000
ORDER BY 3 DESC;

--> 상위 N개를 조회 : TOP-N분석
--      => ROWNUM : 조회된 행에 대하여 순서대로 1부터 순번을 부여해주는 가상 컬럼
SELECT ROWNUM, 사번, EMP_NAME, "보너스 포함 연봉", DEPT_CODE 
FROM (
        SELECT EMP_ID 사번, EMP_NAME, (SALARY + (SALARY*NVL(BONUS,0)))*12 "보너스 포함 연봉", DEPT_CODE
        FROM EMPLOYEE
        WHERE (SALARY + (SALARY*NVL(BONUS,0)))*12 >= 30000000
        ORDER BY 3 DESC
      )
WHERE ROWNUM <= 5;
--> 보너스 포함 연봉이 높은 5명의 사원을 조회


-- 가장 최근에 입사한 사원 5명을 조회
-- 입사일 기준 내림차순 정렬
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM (
        SELECT EMP_ID, EMP_NAME, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC
    )
WHERE ROWNUM <= 5;

-- ROWNUM을 중간 범위로 지정하고자 할 때
-- 인라인 뷰에 컬럼과 같이 작성 후에 사용해야 함 (1부터 조건이 적용되기 때문에)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM (
        SELECT ROWNUM R,EMP_ID, EMP_NAME, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC
    )
WHERE R BETWEEN 2 AND 5;


--------------------------------------------------------------------------------
/*
    순서를 매기는 함수 (WINDOW FUNCTION)
    
    - RANK() OVER(정렬기준)       : 동일한 순위 이후의 등수를 동일한 수만큼 건너뛰고 순위 계산  1 2 2 4
    - DENSE_RANK() OVER(정렬기준) : 동일한 순위가 있더라도 그 다음 등수를 +1 해서 순위 계산    1 2 2 3
    
    => SELECT절에서만 사용 가능하다
*/

-- 급여가 높은 순서대로 순위를 매겨서 조회
SELECT EMP_NAME, SALARY,
        RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;
--> 공동 19위 2명이 있고, 그 뒤의 순위는 21위로 표시됨

SELECT EMP_NAME, SALARY,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;
--> 공동 19위 2명이 있고, 그 뒤의 순위는 20위로 표시됨

-- 상위 5명만 조회
SELECT *
FROM (
        SELECT EMP_NAME, SALARY,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
        FROM EMPLOYEE
)
WHERE 순위 <= 5;

-- 상위 3등 ~ 5등 조회
SELECT *
FROM (
        SELECT EMP_NAME, SALARY,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
        FROM EMPLOYEE
)
WHERE 순위 BETWEEN 3 AND 5;


------------------------------------- QUIZ -------------------------------------
-- 1) ROWNUM을 활용하여 급여가 가장 높은 5명을 조회하려 했으나, 제대로 조회되지 않았다
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 문제점(원인) : ROWNUM은 ORDER BY가 실행되기 전에 먼저 값을 부여하기 때문에 급여가 높은 순대로 조회되지 않는다
-- 해결방안(조치내용) : 급여가 높은 순으로 정렬한 결과값을 테이블로서 사용한다
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- 2) 부서별 평균급여가 270만원을 초과하는 부서에 해당하는 부서코드, 부서별 총 급여합,
--      부서별 평균급여, 부서별 사원 수를 조회하려 했으나, 제대로 조회가 되지 않았다.
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 사원수
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 문제점(원인) : WHERE절의 조건을 SALARY > 2700000로 두면 평균 급여가 아닌 개인의 급여가 270만 이상인 부서들이 나옴
-- 해결방안(조치내용) :
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

-- 서브 쿼리 사용 시
SELECT *
FROM (
        SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 사원수
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
      )
WHERE 평균 > 2700000;