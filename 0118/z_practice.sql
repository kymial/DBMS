# 데이터베이스 생성
# 1. 야구 팀 관리 데이터를 저장하는 데이터베이스 : baseball_league;

# 2. 데이터베이스 선택

# 3. 테이블 생성
# >> a. 팀 테이블 생성 : teams(team_id, name, city, founded_year)

# >> b. 선수 테이블 생성 : players(player_id, name, position)

# 4. 각 테이블 구조 확인

# 5. 테이블 구조 수정
# : players 테이블에 birth_date 칼럼 추가

# 6. 테이블 삭제
# : 테이블이 존재한다면 테이블 삭제

create database baseball_league;

use baseball_league;

create table teams (
	team_id int,
    name varchar(100),
    city varchar(100),
    founded_year year  -- 날짜형 중 연도 데이터만 저장하는 타입 'YYYY'
    );
    
create table players (
	player_id int,
    name varchar(100),
    position enum('타자','투수','내야수','외야수')
    );
    
desc teams;
desc players;

alter table players
add birth_date date;
    
drop table if exists games;

drop table if exists players;

# 7. 데이터 베이스 삭제

drop database baseball_league;