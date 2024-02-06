### bsaeball_league를 사용한 조언 예제 ###

use baseball_league;

# 1. 내부 조인
# 타자인 선수와 해당 선수가 속한 팀 이름 가져오기
select players.name, teams.name from players
inner join teams on players.team_id = teams.team_id
where players.position = "타자";

# 1990년 이후 창단된 팀의 선수 목록 가져오기
select T.name as team_name, P.name as player_name from `players` P
inner join `teams` T on P.`team_id` = T.`team_id`
where T.`founded_year` > 1990;


# 2. 외부 조인
# 모든 팀과 그 팀에 속한 선수 목록 가져오기
select T.name as team_name, P.name as player_name
from teams T
left join Players P on T.team_id = P.team_id;

# 모든 선수와 해당 선수가 속한 팀 이름 가져오기
select P.name as player_name, T.name as team_name
from players P
left join teams T on P.team_id = T.team_id;

# 모든 팀과 해당 팀에 속한 타자 목록 가져오기
select T.name team_name, P.name player_name
from teams T
left join players P on T.team_id = P.team_id and P.position = "타자";

# 내부 쿼리 문제
# 가장 많은 선수를 보유한 팀의 정보를 출력
# : 선수의 수를 계산 >> 그 중에서 가장 많은 선수를 보유한 팀의 정보를 출력

-- select T.name as tame_name, count(P.player_id) as player_count
-- from teams T
-- left join players P on T.team_id = P.teamd_id
-- group by T.name
-- 					# 선수의 수가 가장 큰 팀을 찾기
-- having count(P.player_id) = ( 
-- 							# 서브 쿼리 : players 테이블에서 팀별 선수 수를 계산하고 최대값
-- 	select
-- 		max(player_count)
-- 	from(
-- 							# 서브 쿼리 : 팀별 선수 수를 계산 tame_id, player_count를 반환
--         select team_id, count(P.player_id) as player_count
--         from teams T
--         inner join players P on T.team_id = P.teamd_id
--         group by T.team_id
--         ) as player_counts
-- 	);

# 평균 생년월일이 가장 어린 팀의 정보를 출력
# inner join, 내부 쿼리, avg(), year()
# group by, having