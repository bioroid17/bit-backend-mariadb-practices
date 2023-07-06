-- 날짜 함수

-- curdate(), current_date
select curdate(), current_date from dual;

-- curtime(), current_time
select curtime(), current_time from dual;

-- now() vs sysdate()
select now(), sysdate() from dual;
select now(), sleep(2), now() from dual;	-- sleep로 인해 2초 후에 출력
select sysdate(), sleep(2), sysdate() from dual;

-- date_format
select date_format(now(), "%Y년 %m월 %d일 %h시 %i분 %s초");
select date_format(now(), "%d %b \'%y");

-- period_diff
-- 포맷팅(YYMM, YYYYMM)
-- 예) 근무 개월 수
select emp_no,
		hire_date,
        period_diff(date_format(curdate(), "%y%m"), date_format(hire_date, "%y%m")) as month
from employees;

-- date_add(=adddate), date_sub(subdate)
-- 시간을 date 타입의 컬럼이나 값에 type(year, month, day)의 표현식으로 더하거나 뺄 수 있다.
-- 예) 각 사원의 근속 년 수가 5년이 되는 날에 휴가를 보내 준다면 각 사원의 근속 휴가 날짜는?
select first_name,
		hire_date,
        date_add(hire_date, interval 5 year)
from employees;

-- cast
select '12345' + 10, cast('12345' as int) + 10 from dual;
select date_format(cast('2023-07-06' as date), '%Y년 %m월 %d일') from dual;

select cast(cast(1-2 as unsigned) as signed) from dual;
select cast(cast(1-2 as unsigned) as int) from dual;
select cast(cast(1-2 as unsigned) as integer) from dual;

-- type
-- 문자: varchar, char, text, CLOB(Character Large Object)
	-- char(5): 항상 고정적으로 5바이트 공간을 잡는다. 문자열이 고정 크기일 때 사용한다.
	-- varchar(5): 최대 5바이트의 공간을 잡는다. 만약 데이터가 3바이트면 3바이트만 잡는 식. 문자열이 가변 크기일 때 사용한다.
	-- varchar에 넣을 수 있는 바이트 최대 수는 4096. 이 이상은 text로 받는다.
-- 정수: tinyint, medium int, int(signed, integer), unsigned, bigint
-- 실수: float, double
-- 시간: date, datetime
-- LOB: CLOB, BLOB(Binary Large Object)