-- 수학 함수

-- abs: 절대값
select abs(1), abs(-1) from dual;

-- ceil: 올림
select ceil(3.14), ceiling(3.14) from dual;

-- floor: 버림
select floor(3.14) from dual;

-- mod: 나머지 연산
select mod(10, 3), 10 % 3 from dual;

-- round: 반올림
-- round(x): x에 가장 근접한 정수
-- round(x, d): x의 소수점 아래 d 자리에 가장 근접한 실수
select round(1.498), round(1.498, 1), round(1.498, 0) from dual;

-- power(x, y), pow(x, y) = x의 y승
select power(2, 10), pow(2, 10) from dual;

-- sign: 양수:1, 음수:-1, 0:0
select sign(20), sign(-100), sign(0) from dual;

-- greatest(x, y, ...), least(x, y, ...)
select greatest(10, 40, 20, 50), least(10, 40, 20, 50) from dual;
select greatest('b', 'A', 'C', 'D'), least('hello', 'hella', 'hell') from dual;