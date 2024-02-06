#! 제약조건(Constraint)
# : 데이터의 정화성, 일관성, 신뢰성, 무결성을 유지하기 위해
# : 데이터베이스 시스템에 의해 강제되는 규칙

#! 제약조건의 종류
# Primary Key, Foreign Key, Unique, check,
# default, null허용

#! 기본 키 제약조건(Primary Key = PK)
# : 테이블의 각 행을 고유하게 식벽하는 열, 식별자
# 예) 학생테이블에 학번, 회사테이블에 사번

# 1. 중복될 수 없다.
# 2. null 값이 될 수 없다.
# 3. 하나의 테이블 당 기본 키 1개만 지정 가능
# > 테이블의 특성을 가장 잘 반영한 열 선택을 권장한다.
# 예) members > members_id, posts > posts_id
#    첵 - ISBN 번호(고유번호)

# 샘플 데이터 베이스 생성

create database `examle`;

use `examle`;

-- PK키 지정 테이블 생성

create table `Students` (
	-- 제약 조건 설정(PK) : primary key 키워드 사용
    -- 컬러명 데이터타입 제약조건
	student_id int primary key,
    name varchar(100),
    major varchar(100)
);

-- create table `Students` (
--    제약 조건 설정(PK) : primary key 키워드 사용
-- 	  student_id int primary key,
--    name varchar(100),
--    major varchar(100),
-- 	  제약조건 (설정할 컬럼명)
-- 	  primary key (student_id)
-- );

# 기본 키 설정 테이블에 중복된 값 지정
insert into `Students` (student_id, name, major)
values (1, "정영종", "A전공");

insert into `Students` (student_id, name, major)
values (2, "한바다", "B전공");

-- insert into `Students` (student_id, name, major)
-- values (2, "키미엘", "B전공"); - Error (기본키 충돌)

# 제약 조건 삭제
# : drop 제약조건
alter table `Students`
drop primary key;

# 제약 조건(옵션) 수정 (alter table 테이블명)
# 제약 조건 추가
# : add 제약조건 (열이름)
alter table `Students`
add primary key (student_id);

desc `Students`;

#! 외래 키 제약조건(Foreign Key)
# : 두 테이블 사이의 관계를 연결, 해당 결과 데이터의 무결성을 보장
# : 외래 키가 설정된 열은 반드시 다른 테이블의 기본 키와 연결된다.

# 기본 테이블 : 기본 키가 있는 테이블 (회원 테이블)
# 참조 테이블 : 외래 키가 있는 테이블 (구매 테이블)

# 외래 키 사용 예시
# 고객(Customers) - 주문(Orders)
# : 고객이 실제로 존재하는지 확인, 고객과 주문 간의 관계를 명시

create table `Customers` (
	customer_id int primary key, -- 기본 키
    name varchar(100)
);

create table `Orders` (
	order_id int primary key, -- 기본 키
    order_date date,
    customer_id int,
    -- 외래 키 지정 방식
    -- foreign key (참조 컬럼) references 기본테이블(기본 컬럼)
    foreign key (customer_id) references Customers(customer_id)
);


-- insert into `Orders`
-- value (1, "2024-01-19", 1); - Error(기본테이블 값 누락)

# 외래 키 제약조건 삭제 & 추가
# : 외래 키 제약조건 삭제 주의점
# : 해당 데이터 존재시 삭제 안됨

alter table `Orders`
drop foreign key customer_id;

alter table `Orders`
add constraint
foreign key (customer_id)
references Customers(customer_id);


#! unique 제약 조건
# : 특정 열에 대해 모든 값이 고유해야 함을 보장
# : 한 테이블 내에서 여러개 지정 가능
# 예) 회원의 아이디 - PK, 회원의 이메일, 주민등록번호 - Unique

create table Users (
	user_id int primary key,
    username varchar(100) unique,
    email varchar(100) unique
    );

insert into Users
values (1, '정영종', '1q2w3e4r');

insert into Users
values (2, '한바다', '1q2w3e4');

# check 제약 조건
# : 입력되는 데이터를 점검하는 기능
# : 테이블의 열에 대해 특정하는 조건을 설정,
#	해당 조건을 만족하지 않는 데이터의 입력을 막는 규칙

create table Employees (
	id int primary key,
    name varchar(100),
    age int,
    -- 열의 정의 뒤에 check(조건)
    check (age >= 20)
);

insert into Employees
values (1, "정영종", 32);

insert into Employees
values (2, "한바다", 27);

# not null 제약조건
# : 특정 열에 null 값을 허용하지 않는 규칙
# : 비워져있지 않도록 설정

create table `Contacts` (
	id int primary key,
    name varchar(100) not null,
    email varchar(100)
);

-- insert into `Contacts`
-- values (1, null, "1q2w3e"); - Error(널 값 허용 하지 않음)

insert into `Contacts`
values (1, "정영종", "1q2w3e");

# default 제약조건
# : 테이블의 열에 값이 명시적으로 제공되지 않을 때 사용되는 기본값
# : 선택적이 필드에 대해 기본값 설정 > 데이터의 무결성을 유지시키는데 도움을 준다.

#(주문)조회 테이블
create table `Inquiry` (
	order_id int primary key,
    product_name varchar(100),
    -- default 제약조건 설정 방법
    -- 컬럼명 데이터타입 default 기본값
    quantity int default 1
);

-- 테이블의 전체 컬럼에 데이터 삽입 시 컬럼명 지정하지 않아도 됨

insert into `Inquiry`
values (1, "노트북", 3);

-- 테이블의 전체 컬럼의 개수와 삽입되는 데이터의 수가 다를 경우 반드시 컬럼명 지정
insert into `Inquiry` (order_id, product_name)
values (2, "스마트폰");

drop database `examle`;