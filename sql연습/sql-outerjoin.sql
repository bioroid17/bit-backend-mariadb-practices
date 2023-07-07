-- Outer Join

-- insert into dept values(null, '총무');
-- insert into dept values(null, '영업');
-- insert into dept values(null, '개발');
-- insert into dept values(null, '기획');

select * from dept;

-- insert into emp values(null, '둘리', 1);
-- insert into emp values(null, '마이콜', 2);
-- insert into emp values(null, '또치', 3);
-- insert into emp values(null, '길동', null);

select * from emp;

-- 원치 않는 결과
-- inner join으로는 사장인 길동이 select 되지 않는다.
select a.name, b.name
	from emp a join dept b on a.dept_no=b.no;

-- left join
select  ifnull(a.name, '없음') as '사원', ifnull(b.name, '없음') as '부서'
	from emp a left join dept b on a.dept_no=b.no;
    
-- right join
select  ifnull(a.name, '없음') as '사원', ifnull(b.name, '없음') as '부서'
	from emp a right join dept b on a.dept_no=b.no;
    
-- full join
-- mysql은 지원 안 함