select version(), current_date, now()
	from dual;
    
-- 수학함수, 사칙 연산도 한다.
select sin(pi()/4), 1 + 2 * 3 - 4 / 5
	from dual;

-- 대소문자 구분이 없다.
seLect VERsion(), current_DAte(), nOW()
	frOm DUAL;
    
-- table 생성: ddl
create table pet(
	name varchar(100),
    owner varchar(20),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- schema 확인
describe pet;
desc pet;

-- insert: DML(C)
insert
	into pet
values('성탄이', '안대혁', 'dog', 'm', '2008-12-15', null);

-- select: DML(R)
select *
	from pet;
    
-- update: DML(U)
update pet
	set name='sungtanee'
where name='성탄이';

-- delete: DML(D)
delete
	from pet
where name = 'sungtanee';

-- load data
load data local infile 'c:\\pet.txt' into table pet;

update pet
	set death = null
where name != 'bowser';

-- select 연습
-- date 형도 비교 연산 가능
select name, species
	from pet
where name = 'bowser';

-- date 형도 비교 연산 가능
select name, species, birth
	from pet
where birth >= '1998-01-01';

-- and 연산
select name, species, gender
	from pet
where species='dog'
	and gender='f';

-- or 연산
select name, species
	from pet
where species='snake'
	or species='bird';

-- order by
-- 오름차순(기본값)
select name, birth
	from pet
order by birth asc;

-- 내림차순
select name, birth
	from pet
order by birth desc;

-- where 절에서 null 값 비교
select name, birth, death
	from pet
where death is not null;

-- 문자열 like 연
-- b로 시작하는 이름
select name
	from pet
where name like 'b%';

-- fy로 끝나는 이름
select name
	from pet
where name like '%fy';

-- w가 포함된 이름
select name
	from pet
where name like '%w%';

-- 글자 수가 총 6글자
select name
	from pet
where name like '______';

-- b로 시작하고 글자 수가 총 6글자
select name
	from pet
where name like 'b_____';

-- 집계함수
select count(death)
	from pet;