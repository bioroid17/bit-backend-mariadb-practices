drop table member;

create table member(
	no int not null auto_increment,
    email varchar(200) not null,
    password varchar(64) not null,
    name varchar(100) not null,
    department varchar(100),
    primary key(no)
);
desc member;

alter table member add column juminbunho char(13) not null;
desc member;

alter table member drop column juminbunho;
desc member;

alter table member add column juminbunho char(13) not null after email;
desc member;

alter table member change column department dept varchar(100);
desc member;

alter table member add column self_intro text;
desc member;

alter table member drop column juminbunho;
desc member;

-- insert
insert
into member
values(null, 'kickscar@gmail.com', password('123'), '안대혁', '개발팀', null);

insert
into member(email, password, name, dept)
values('kickscar2@gmail.com', password('1234'), '안대혁2', '개발팀');

insert
into member(name, password, dept, email)
values('안대혁2', password('1234'), '개발팀', 'kickscar2@gmail.com');

-- update
update member
set email='kickscar3@gmail.com', password=password('5678')
where no=2;

-- delete
delete
from member
where no = 2;

-- transction
select @@autocommit;
set autocommit=0;

insert
into member(name, password, dept, email)
values('안대혁3', password('1234'), '개발팀', 'kickscar3@gmail.com');

commit;

-- select
select * from member;