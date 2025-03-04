/*
    GROUP BY절
    : 그룹 기준을 제시할 수 있는 구문
    : 여러 개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/
-- 전체 사원 총 급여 조회
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 부서별 총 급여
SELECT DEPT_CODE, SUM(SALARY) -- 3
FROM EMPLOYEE                 -- 1
GROUP BY DEPT_CODE;           -- 2

-- 부서 별 사원 수
SELECT DEPT_CODE, COUNT(*)      -- 3
FROM EMPLOYEE                   -- 1
GROUP BY DEPT_CODE;             -- 2

-- D6, D1, D9 총 급여
SELECT DEPT_CODE, SUM(SALARY), COUNT(*) -- 4
FROM EMPLOYEE                           -- 1
WHERE DEPT_CODE IN ('D1', 'D6', 'D9')   -- 2
GROUP BY DEPT_CODE                      -- 3
ORDER BY DEPT_CODE;                     -- 5

-- 각 직급별 총 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저 급여, 최고 급여
-- 단, 직급코드 오름차순으로 정렬
SELECT JOB_CODE, COUNT(*), COUNT(BONUS)"보너스 받는 사원 수", 
        SUM(SALARY) "급여 합", ROUND(AVG(SALARY)) "평균 급여", 
        MIN(SALARY) "최저 급여", MAX(SALARY) "최고 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 남자 사원수, 여자 사원수 조회 -> 주민번호 컬럼
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 성별 , COUNT(*) "사원 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- 부서 내에 직급별 사원수, 급여 총합
SELECT DEPT_CODE, JOB_CODE, COUNT(*) "사원 수", SUM(SALARY) "급여 총합"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE    -- 부서 코드 기준으로 그룹화를 하고, 그룹 내에서 직급코드 기준으로 세부그룹화 함
ORDER BY DEPT_CODE;

-------------------------------------------------------------------------------
/*
    HAVING절 : 그룹에 대한 조건을 제시할 때 사용하는 구분
    (보통, 그룹함수식을 사용하여 조건을 작성함)
*/
-- 부서별 평균 급여 조회
SELECT ROUND(AVG(SALARY)) "평균 급여"
FROM EMPLOYEE
GROUP BY DPET_CODE;

-- 각 부서별 평균 급여가 300만원 이상인 부서만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)) "평균 급여"    -- 4
FROM EMPLOYEE                       -- 1
WHERE SALARY >= 3000000             -- 2 => 사원의 급여가 300만원 이상
GROUP BY DEPT_CODE;                 -- 3

SELECT DEPT_CODE, ROUND(AVG(SALARY)) "평균 급여"    -- 4
FROM EMPLOYEE                       -- 1
GROUP BY DEPT_CODE                  -- 2
HAVING AVG(SALARY) >= 3000000;      -- 3 => 부서별 평균 급여가 300만원 이상r

-- 부서별 보너스를 받는 사원이 없는 부서의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

SELECT BONUS FROM EMPLOYEE WHERE DEPT_CODE = 'D2';










