--
-- subquery
--

--
-- 1) select 절, insert 절의 values(...)의 서브쿼리
--
select (select 1+1 from dual) from dual;

--
-- 2) from 절의 서브쿼리
--
select a.n, a.s, a.r
from (select now() as n, sysdate() as s, 3 + 1 as r from dual) a;

--
-- 3) where 절 또는 having 절의 서브쿼리
--
-- 예제) 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요. 

-- subquery 미사용
select b.dept_no
from employees a, dept_emp b
where a.emp_no=b.emp_no
	and b.to_date='9999-01-01'
    and concat(first_name, ' ', last_name) = 'Fai Bale';
    
-- d004
select a.emp_no, a.first_name
from employees a, dept_emp b
where a.emp_no=b.emp_no
	and b.to_date='9999-01-01'
    and b.dept_no='d004';
    
-- subquery 사용
select a.emp_no, a.first_name
from employees a, dept_emp b
where a.emp_no=b.emp_no
	and b.to_date='9999-01-01'
    and b.dept_no=(select b.dept_no
	from employees a, dept_emp b
	where a.emp_no=b.emp_no
	and b.to_date='9999-01-01'
    and concat(first_name, ' ', last_name) = 'Fai Bale');
    
-- where 절 서브쿼리는 결과 row가 한 개보다 많으면 에러가 발생한다는 문제가 있다.

-- 3-1) 단일 행 연산자: =, >, <, >= <=, <>, !=
-- 실습 문제 1:
-- 현재, 전체 사원의 평균 연봉보다 적은 연봉을 받는 이름과 급여를 출력 하세요.
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no=b.emp_no
	and b.to_date='9999-01-01'
    and b.salary < (select avg(salary) from salaries where to_date='9999-01-01')
order by b.salary desc;

-- 실습 문제 2:
-- 현재 가장 적은 평균 급여의 직책과 그 평균 급여를 구하세요 
-- 1) 직책별 평균 급여 
select a.title as t, avg(b.salary) as avg_salary
from titles a, salaries b
where a.emp_no=b.emp_no
    and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
group by a.title
order by avg_salary;

-- 2) 가장 적은 직책별 평균 급여
select min(avg_salary)
from (select a.title as t, avg(b.salary) as avg_salary
		from titles a, salaries b
		where a.emp_no=b.emp_no
			and a.to_date='9999-01-01'
			and b.to_date='9999-01-01'
		group by a.title
		order by avg_salary) d;

-- 3) solution: subquery
-- 이 쪽이 표준 방식
select a.title as t, avg(b.salary) as avg_salary
from titles a, salaries b
where a.emp_no=b.emp_no
    and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
group by a.title
having avg_salary = (select min(avg_salary)
					from (select a.title as t, avg(b.salary) as avg_salary
							from titles a, salaries b
							where a.emp_no=b.emp_no
								and a.to_date='9999-01-01'
								and b.to_date='9999-01-01'
							group by a.title
							order by avg_salary) d);
                            
-- 4) solution 2: top-k
-- 이건 mysql에서만 가능한 것임. 표준이 아니다.
select a.title as t, avg(b.salary) as avg_salary
from titles a, salaries b
where a.emp_no=b.emp_no
    and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
group by a.title
order by avg_salary asc
limit 0, 1; -- limit은 오직 출력용. 메모리에는 전부 올라간다. 즉, 딱히 메모리를 덜 먹진 않음

-- 3-2) 복수행 연산자: in, not in, (=, <>, >, <, >=, <=)any, (=, <>, >, <, >=, <=)all

-- any 사용법
-- 1. =any: in
-- 2. >any, >=any: 최솟값 구하기
-- 3. <any, <=any: 최댓값 구하기
-- 4. <>any, !=any: not in

-- all 사용법
-- 1. =all: 그런건 없다.
-- 2. >all, >=all: 최댓값 구하기
-- 3. <all, <=all: 최솟값 구하기
-- 4. <>all, !=all

-- 실습 문제 3
-- 현재, 급여가 50000 이상인 직원의 이름과 급여를 출력하세요.
-- 둘리 55000
-- 또치 60000

-- solution 1: join
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no=b.emp_no
	and b.to_date = '9999-01-01'
    and b.salary > 50000
order by b.salary asc;

-- solution 2: subquery
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
	and to_date = '9999-01-01'
	and (a.emp_no, b.salary) =any (select emp_no, salary
									from salaries
									where to_date = '9999-01-01'
										and salary > 50000)
order by b.salary asc;

-- sol3: subquery
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
	and to_date = '9999-01-01'
	and (a.emp_no, b.salary) in (	select emp_no, salary
									from salaries
									where to_date = '9999-01-01'
										and salary > 50000)
order by b.salary asc;   
    
-- 실습 문제 4: 현재, 각 부서별로 최고 연봉을 받고 있는 부서 이름, 직원 이름, 연봉을 출력하세요.
-- 총무 둘리 1000
-- 영업 또치 2000

select a. dept_no, max(b.salary)
from dept_emp a, salaries b
where a.emp_no=b.emp_no
	and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
group by a.dept_no;

-- solution 1: where절 subquery & in
select c.dept_name, a.first_name, d.salary
from employees a, dept_emp b, departments c, salaries d
where a.emp_no=b.emp_no
	and a.emp_no=d.emp_no
    and b.dept_no=c.dept_no
    and b.to_date='9999-01-01'
    and d.to_date='9999-01-01'
    and (b.dept_no, d.salary) in (	select a. dept_no, max(b.salary)
									from dept_emp a, salaries b
									where a.emp_no=b.emp_no
										and a.to_date='9999-01-01'
										and b.to_date='9999-01-01'
									group by a.dept_no)
order by d.salary desc;

-- solution 2: from절 subquery & join
select c.dept_name, a.first_name, d.salary
from employees a,
	dept_emp b,
    departments c,
    salaries d,
    (select a. dept_no, max(b.salary) as max_salary
	from dept_emp a, salaries b
	where a.emp_no=b.emp_no
		and a.to_date='9999-01-01'
		and b.to_date='9999-01-01'
	group by a.dept_no) e
where a.emp_no = b.emp_no
	and a.emp_no=d.emp_no
    and b.dept_no=c.dept_no
    and b.dept_no=e.dept_no
    and b.to_date='9999-01-01'
    and d.to_date='9999-01-01'
    and d.salary=e.max_salary
order by d.salary desc;