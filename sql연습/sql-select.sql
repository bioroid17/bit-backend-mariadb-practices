--
-- select 기본
--

-- 예제 1: deaprtments 테이블의 모든 데이터를 출력
select *
  from departments;

-- 프로젝션(projection)
-- 예제 2: departments 테이블에서 부서의 이름, 부서 번호를 출력
select dept_name, dept_no
	from departments;

-- as(alias, 생략 가능)
-- 예제 3: employees 테이블에서 직원의 이름, 성별, 입사일을 출력
select first_name as '이름',
		last_name as '성',
		gender as '성별',
		hire_date as '입사일'
from employees; 
  
SELECT 
    CONCAT(first_name, ' ', last_name) AS '이름',
    gender AS '성별',
    hire_date AS '입사일'
FROM
    employees
LIMIT 0 , 1000;
    
-- distinct
-- 예제 4-1: titles 테이블에서 모든 직급의 이름 출력
select title from titles;

-- 예제 4-2: titles 테이블에서 직급 이름을 중복 없이 출력
-- distinct는 메모리에 조건에 맞는 모든 행을 적재하고, 출력 시 중복을 제거한다.
-- 즉, 딱히 distinct라고 메모리를 덜 쓰지 않는다.
select distinct(title) from titles;

--
-- where 절
--

-- 비교 연산자
-- 예제 1: employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select concat(first_name, ' ', last_name) as '이름',
		gender as '성별',
        hire_date as '입사일'
	from employees
where hire_date < '1991-01-01';

-- 논리 연산자
-- 예제 2: employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
select concat(first_name, ' ', last_name) as '이름',
		gender as '성별',
        hire_date as '입사일'
	from employees
where gender='f'
	and hire_date < '1989-01-01';

-- in 연산자
-- 예제 3: dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
select emp_no, dept_no
	from dept_emp
where dept_no='d005'
	or dept_no='d009';

select emp_no, dept_no
	from dept_emp
where dept_no in ('d005', 'd009');

-- like 연산자
-- 예제 4: employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력
select first_name, hire_date
	from employees
where hire_date between '1989-01-01' and '1989-12-31';

select first_name, hire_date
	from employees
where hire_date like '1989%';

--
-- order by
--
-- 예제 1: employees 테이블에서 직원의 전체이름,  성별, 입사일을  입사일 순으로 출력
select first_name, gender, hire_date
	from employees
order by hire_date asc;

-- 예제 2: salaries 테이블에서 2001년 월급을 가장 높은순으로 사번, 월급순으로 출력
select emp_no, salary
	from salaries
where from_date like '2001%'
order by salary desc;