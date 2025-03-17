/*
* DQL (Data Query Language) - 데이터 검색 언어
  - [SELECT] 명령어 사용
  - 표현법 및 실행 순서 표시
		키워드 => FROM ORDER BY SELECT WHERE
        SELECT 컬럼명, 연산식, 함수식, *
        FROM 테이블명
        WHERE 조건식
        ORDER BY 정렬 기준이 되는 컬럼
        FROM -> WHERE -> SELECT -> ORDER BY 절 순으로 진행

        *ORDER BY 절의 정렬 기본값은 오름차순(ASC), NULLS LAST
                                내림차순(DESC), NULLS FIRST

* 함수 (FUNCTION)
	- [단일행함수] : N개의 값으로 N개의 결과값을 반환 (매 행마다 함수 실행 결과 반환)
	- [그룹합수] : N개의 값으로 1개의 결과값을 반환 (그룹으로 묶어 함수 실행 결과 반환)  
  
*/  
---------------------------------------------
-- === 아래 내용을 조회할 수 있는 SQL문을 작성 ===
-- 사원 정보 중 사원번호, 이름, 월급을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 부서코드가 'D9'인 사원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 연락처의 4번째자리가 7인 직원의 이름, 연락처 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
--WHERE SUBSTR(PHONE, 4, 1) = '7';
WHERE PHONE LIKE '___7%';

-- 직급코드가 'J7'인 직원 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' AND SALARY >= 2000000;

-- 전체 사원 정보를 최근 입사일 기준으로 정렬하여 조회
SELECT *
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

-- 여사원들중 60년대생 직원들의 이름, 주민번호, 이메일, 연락처 조회
-- (단, 주민번호의 경우 7자리까지만 표시하고 나머지는 *로 표시)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8),14, '*') EMP_NO, EMAIL, PHONE
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%' AND SUBSTR(EMP_NO, 8,1) IN('2' ,'4');
-- WHERE SUBSTR(EMP_NO, 1, 2) BETWEEN 60 AND 69;
-- 자동으로 형변환 됨

-- 사원들 중 입사한 달에 생일인 사원의 사번, 사원명, 고용일, 생년월일을 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SUBSTR(EMP_NO, 1, 6) BIRTH
FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = SUBSTR(EMP_NO, 3, 2)
-- 9 = '09'