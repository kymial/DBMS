# DML 명령어 정리
# : Data Manipulation Language
# : 데이터 관리 언어 (데이터를 조회, 삽입, 수정, 삭제 기능)

create database `company`;
use `company`;
create table example01 (
	name varchar(100),
    age int,
    major varchar(100)
);

# 삽입(insert)
# : 테이블에 행 데이터를 입력하는 기본적인 SQL문
# 기본형식
# insert into 테이블명 [(열1, 열2, ....)]
# values (값1, 값2, ...);
# - 열 이름을 생략할 경우 values 다음에 나오는 값들의 순서는, 테이블 정의 시 지정한 열의 순서와 개수와 동일해야한다.

-- 컬럼명 지정하지 않은 경우 (테이블 생성 시와 맞춰야 한다)
insert into `example01`
values("정영종", 33, "전공A");

-- insert into `example01`
-- values("한바다", "전공B", 32); - Error 값이 잘못 됨

-- 칼럼명을 지정하는 경우
insert into `example01` (age, major, name)
values(32, "전공B", "한바다");

# 데이터 삽입 시 데이터의 값을 입력하지 않은 경우
# 1. null 허용 - 생략된 칼럼에 null 값이 지정
# 2. not null 지정 - 오류

# auto_increment 
# : 열을 정의할 때 1부터 증가하는 값을 입력
# : insert에서는 해당 열이 없다고 가정하고 입력
# : 해당 컬럼은 반드시 primary key로 지정

create table example02 (
	id int auto_increment primary key,
    name varchar(100)
);

insert into example02 values (null, "정영종");
insert into example02 values (null, "한바다");
insert into example02 values (null, "키미엘");

# 현재 어느 숫자까지 증가되었는지 확인
select last_insert_id();

# 시작 값 변경
alter table example02 auto_increment=100;
insert into example02 value (null, "ABC");

# 다른 테이블의 데이터를 한번에 입력하는 구문
# : 다른 테이블에 지정된 데이터를 가지고 올 경우
# insert into ~ select
create table example03 (
	city_name char(35),
    population int
);

insert into example03
select name, population from world.city;

# count(*) : * 전체 테이블 열의 개수를 세는 기능
select count(*) from world.city;
select count(*) from example03;

# 데이터베이스가 선택 안되어있으면 데이터베이스.테이블 이런식으로 입력해야함


# 수정(update)
# : 테이블의 내용을 수정하기 위한 SQL 명령어
# 기본형태
#! update 테이블명
# set 열1=값1, 열2=값2, ....
# where 조건;

update company.example03
set population = 0;

update company.example03
set population = 100, city_name = "카불"
where city_name = "Kabul";
-- 여러 데이터 값을 한번에 설정하고자하는 경우
-- 콤마(,)로 분리하여 여러 개의 열을 변경


# 삭제(delete)
# : 테이블의 데이터를 삭제하기 위한 SQL 명령어
# 기본 형태
# delete from 데이터베이스.테이블명
# where 조건;

delete from company.example03;
insert into company.example03
values ("대한민국", 100000000);
insert into company.example03
values ("미국", 100000);

delete from company.example03
where city_name = "미국";

# delete vs truncate vs drop
# : 대용량 테이블의 삭제

create table big1(select * from world.city, sakila.country);
create table big2(select * from world.city, sakila.country);
create table big3(select * from world.city, sakila.country);

delete from big1; -- 가장 오래걸림 / 테이블 삭제하지 않는다.
drop table big2;  -- 가장 빠름 / 테이블 자체를 삭제
truncate table big3; -- 빠름 / 테이블 삭제하지 않는다.

# delete
# 테이블의 틀을 남기면서 적은 용량의 데이터를 삭제

# drop
# 빠른 속도로 테이블 자체를 삭제

# truncate
# 테이블의 틀을 남기면서 대용량의 데이터를 삭제