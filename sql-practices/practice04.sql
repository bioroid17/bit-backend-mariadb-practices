-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(emp_no)
from salaries a, (select avg(salary) as avg_salary
					from salaries
					where to_date='9999-01-01') b
where a.salary > b.avg_salary
	and a.to_date='9999-01-01';

-- 문제2. (x)
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요.
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요
-- join이 더 좋은 방식일 듯?
select a.emp_no, concat(a.first_name, ' ', a.last_name), c.salary
from employees a, dept_emp b, salaries c, (select a.dept_no as dno, avg(b.salary) as avg_salary
from dept_emp a, salaries b
where a.emp_no=b.emp_no
    and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
group by a.dept_no) ds
where a.emp_no=b.emp_no
	and a.emp_no=c.emp_no
    and ds.dno=b.dept_no
    and b.to_date='9999-01-01'
    and c.to_date='9999-01-01'
    and c.salary > ds.avg_salary;
    
-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no, concat(a.first_name, ' ', a.last_name), c.man_name, b.dept_name
from employees a,
	departments b,
    (select dm.dept_no as man_dept_no, concat(e.first_name, ' ', e.last_name) as man_name
		from dept_manager dm join employees e using(emp_no)
	where dm.to_date='9999-01-01') c,
    dept_emp d
where a.emp_no=d.emp_no
	and d.dept_no=c.man_dept_no
    and b.dept_no=d.dept_no
    and d.to_date='9999-01-01'
order by a.emp_no asc;

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select aa.emp_no, aa.emp_name, aa.title, aa.salary
from (select a.emp_no, concat(a.first_name, ' ', a.last_name) as emp_name, b.title, c.salary, d.dept_no
	from employees a, titles b, salaries c, dept_emp d
	where a.emp_no=b.emp_no
		and b.emp_no=c.emp_no
		and a.emp_no=d.emp_no
		and b.to_date='9999-01-01'
		and c.to_date='9999-01-01'
		and d.to_date='9999-01-01') aa
	join
    (select a.dept_no
	from dept_emp a, salaries b
	where a.emp_no=b.emp_no
		and a.to_date='9999-01-01'
		and b.to_date='9999-01-01'
	group by a.dept_no
	having avg(b.salary)=(select max(ds.avg_salary)
						from (select a.dept_no as dno, avg(b.salary) as avg_salary
						from dept_emp a, salaries b
						where a.emp_no=b.emp_no
							and a.to_date='9999-01-01'
							and b.to_date='9999-01-01'
						group by a.dept_no) ds)) bb
	using(dept_no)
order by aa.salary desc;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
-- 부서 이름, 평균 연봉
select b.dept_name as dept, avg(c.salary) as avg_salary
from dept_emp a, departments b, salaries c
where a.dept_no=b.dept_no
	and a.emp_no=c.emp_no
    and a.to_date='9999-01-01'
    and c.to_date='9999-01-01'
group by b.dept_name
having avg_salary=(select max(dds.avg_salary)
					from(select b.dept_name as dept, avg(c.salary) as avg_salary
					from dept_emp a, departments b, salaries c
					where a.dept_no=b.dept_no
						and a.emp_no=c.emp_no
						and a.to_date='9999-01-01'
						and c.to_date='9999-01-01'
					group by b.dept_name) dds);

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
-- 직책 이름, 평균 연봉
select b.title as title, avg(c.salary) as avg_salary
from employees a, titles b, salaries c
where a.emp_no=b.emp_no
	and a.emp_no=c.emp_no
    and b.to_date='9999-01-01'
    and c.to_date='9999-01-01'
group by b.title
having avg_salary=(select max(ets.avg_salary)
					from(select b.title as dept, avg(c.salary) as avg_salary
					from employees a, titles b, salaries c
					where a.emp_no=b.emp_no
						and a.emp_no=c.emp_no
						and b.to_date='9999-01-01'
						and c.to_date='9999-01-01'
					group by b.title) ets);

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select man.man_dept as dept, emp.emp_name, emp.emp_salary, man.man_name, man.man_salary
from (select d.dept_name as man_dept, concat (a.first_name, ' ', a.last_name) as man_name, b.salary as man_salary
	from employees a, salaries b, dept_manager c, departments d
	where c.dept_no=d.dept_no
		and a.emp_no=b.emp_no
		and b.emp_no=c.emp_no
		and b.to_date='9999-01-01'
		and c.to_date='9999-01-01') man
    join
	(select d.dept_name as emp_dept, concat (a.first_name, ' ', a.last_name) as emp_name, b.salary as emp_salary
	from employees a, salaries b, dept_emp c, departments d
	where c.dept_no=d.dept_no
		and a.emp_no=b.emp_no
		and b.emp_no=c.emp_no
		and b.to_date='9999-01-01'
		and c.to_date='9999-01-01') emp
	on man.man_dept=emp.emp_dept
where man.man_salary < emp.emp_salary;