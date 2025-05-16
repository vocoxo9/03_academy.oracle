/** 아래 테이블 및 컬럼은 존재한다고 가정하고 쿼리문을 작성해보자 **/
/***
    DDL : 데이터 정의 언어
    --> 객체를 생성(CREATE), 수정(ALTER), 삭제(DROP)
***/

-- EMP 테이블에 DEPT_ID 컬럼을 추가하면서 기본값을 100으로 설정
-- 또한, DEPARTMENT 테이블의 DEPT_ID 컬럼을 참조하는 외래키를 설정하되
-- 부모 키가 삭제될 경우 해당 값을 NULL로 설정
ALTER TABLE EMP
            ADD DEPT_ID NUMBER DEFAULT 100
            ADD CONSTRAINT FK_EMP_ID FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT (DEPT_ID) ON DELETE SET NULL;
            
-- EMP 테이블의 EMP_NAME 컬럼의 데이터 타입을 VARCHAR2(100)으로 변경
ALTER TABLE EMP MODIFY EMP_NAME VARCHAR2(100);
            
/*** DML : 데이터 조작 언어
    --> 데이터를 추가(INSERT), 수정(UPDATE), 삭제(DELETE)        
***/

-- EMP 테이블에서 DEPT_ID 값이 'D3'인 직원들의 SALARY 를 10% 인상
UPDATE EMP
SET SALARY = SALARY * 1.1
WHERE DEPT_ID = 'D3';

-- EMP 테이블에서 DEPT_ID 값이 'D99'인 직원들을 삭제
DELETE FROM EMP
WHERE DEPT_ID = 'D99';

/*** DQL : 데이터 질의 언어
    --> 데이터를 조회 (SELECT)
***/

-- EMP 테이블에서 SALARY 값이 가장 높은 직원의 정보를 조회
SELECT *
FROM EMP
WHERE SALARY = (SELECT MAX(SALARY) FROM EMP);

-- EMP 테이블에서 DEPT_ID 별 평균 급여(SALARY)가 4000000 이상인 부서만 부서별 평균 급여 조회
SELECT ROUND(AVG(SALARY))
FROM (
SELECT DEPT_ID, ROUND(AVG(SALARY))
FROM EMP
GROUP BY DEPT_ID
HAVING AVG(SALARY) >= 4000000)
GROUP BY DEPT_ID;
-- WHERE : 전체에 대한 조건 /  HAVING: 그룹에 대한 조건

/*** DCL ***/
-- SAMPLE 계정에게 EMP 테이블에 대한 조회, 수정 권한을 부여
GRANT SELECT, UPDATE ON EMP TO SAMPLE;

-- SAMPLE 계정에게 부여했던 EMP 테이블에 대한 수정 권한 회수
REVOKE UPDATE ON EMP FROM SAMPLE;

/*** TCL ***/
-- EMP 테이블에서 SALARY를 20% 인상한 후 해당 시점을 저장
UPDATE EMP
SET SALARY = SALARY*1.2;
SAVEPOINT SP;

-- 이전 저장 시점으로 롤백
ROLLBACK TO SP;

-- 현재까지의 모든 변경 사항을 적용
COMMIT;