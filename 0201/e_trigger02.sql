# 트리거 활용 #

# market_db 고객 테이블(member)에, 입력된 회원의 정보가 변경될 때
# - 변경한 사용자, 시간, 변경 전의 데이터를 기록하는 트리거

use market_db;

create table singer (
	select mem_id, mem_name, mem_number, addr from member
    );

-- 백업 테이블
create table backup_singer (
	mem_id char(8) not null,
    mem_name varchar(10) not null,
    mem_number int not null,
    addr char(2) not null,
    modType char(2), -- 변경된 타입 (수정|삭제)
    modDate date, -- 변경된 날짜
    modUser  varchar(30) -- 변경된 사용자
    );

# 변경(update)가 발생했을 때 작동하는 트리거
drop trigger if exists singer_updateTrg;
delimiter $$
create trigger singer_updateTrg -- 트리거이름
	after update -- 변경 후에 작동하도록 지정
		on singer -- 트리거를 부착할 테이블
			for each row
begin
	insert into backup_singer
		values (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr,
			'수정', curdate(), current_user());
end $$
delimiter ;

# OLD 테이블
# : update 나 delete가 수행 될 때, 변경되기 전의 데이터가 잠깐 저장되는 임시 테이블
# >> mySQL 내부에서 제공되는 테이블

# curdate() : 현재 날짜
# current_user () : 현재 작업 중인 사용자

update singer set addr = '영국' where mem_id = 'BLK';

select * from backup_singer;

# 삭제가 발생했을때 작동하는 트리거
# singer_deleteTrg


drop trigger if exists singer_deleteTrg;
delimiter $$
create trigger singer_deleteTrg -- 트리거이름
	after delete -- 변경 후에 작동하도록 지정
		on singer -- 트리거를 부착할 테이블
			for each row
begin
	insert into backup_singer
		values (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr,
			'삭제', curdate(), current_user());
end $$
delimiter ;

delete from singer where mem_number >=7;
select * from backup_singer;