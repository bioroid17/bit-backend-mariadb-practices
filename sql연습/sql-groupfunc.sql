--
-- 1) 집계(통계) 쿼리
-- select 절에 그룹(통계, 집계) 함수가 projection 된 쿼리
-- 그룹 함수: avg, max, min, count, sum, stddev, variance
--

-- 2) select 절에 그룹 함수가있는 경우, 어떤 컬럼도 select 절에 올 수 없다!
-- 오류
-- emp_no는 아무 의미가 없다.
select emp_no, sum(salary) from salaries;	-- Oracle에서 써보면 에러가 날 것이다.