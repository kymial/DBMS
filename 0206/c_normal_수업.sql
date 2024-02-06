# 주문에 대한 테이블

create database `normalization`;

use normalization;

# 1. 비정규화 상태
# 하나의 필드 (상품, 수량, 단가)에 여러 값이 존재
# : 데이터의 중복

create table normalization.orders_unnormalized(
	order_id int,
    customer_name varchar(100),
    customer_address varchar(255),
    order_date date, 
    products varchar(255), -- 상품의 수량이 혼합된 상태
    quantities varchar(255), -- 단가의 상품에 대한 단가
    prices varchar(255)
    );
    
select * from normalization.orders_unnormalized;

# 제 1정규형
# : 테이블의 모든 필드 값이 원자값을 가짐
# : 각 필드에는 반복되는 그룹이나 여러 값이 포함되지 않는다.

CREATE TABLE normalization.orders_1nf (
	order_id INT,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255),
    order_date DATE,
    product VARCHAR(100),
    quantity INT,
    price INT
);

SELECT * FROM normalization.orders_1nf;

# >> 위의 제1정규형 테이블의 경우 제2 정규형을 만족
# (모든 비주요 속성이 주요 키에 대한 완전히 함수적으로 종속)

# 비주요 속성 : 주요 키를 구성하는 컬럼이 아닌 모든 다른 컬럼
# 완전히 함수적으로 종속 : 테이블의 모든 비주요 속성이 테이블의 주요 키 전체에 대해서만 종속
# 복합 키(두 개 이상의 컬럼으로 구성된 키)를 가진 테이블에서 일부 컬럼이 키의 전체가 아닌 일부에만 종속되는 경우

# 제3정규형(3NF)
# : 기본 키가 아닌 모든 필드가 서로 독립적인 상태

CREATE TABLE normalization.customers (
	custom_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255)
);

CREATE TABLE normalization.orders_3nf (
	order_id INT,
    customer_id INT,
    order_date DATE,
    product VARCHAR(100),
    quantity INT,
    price INT,
    FOREIGN KEY (customer_id) REFERENCES normalization.customers(custom_id)
    );
