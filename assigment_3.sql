create database assignment_1;
use assignment_1;
CREATE TABLE IPL_Players (
    Player_ID INT PRIMARY KEY,
    Player_Name VARCHAR(50),
    Team_Name VARCHAR(50),
    Matches_Played INT,
    Runs_Scored INT,
    Role VARCHAR(20)
);

INSERT INTO IPL_Players VALUES
(1, 'Virat Kohli', 'RCB', 250, 7500, 'Batsman'),
(2, 'MS Dhoni', 'CSK', 230, 5000, 'Wicketkeeper'),
(3, 'Rohit Sharma', 'MI', 240, 7300, 'Batsman'),
(4, 'Hardik Pandya', 'GT', 120, 2100, 'All-rounder'),
(5, 'Rashid Khan', 'GT', 100, 500, 'Bowler'),
(6, 'KL Rahul', 'LSG', 130, 4500, 'Batsman'),
(7, 'David Warner', 'DC', 150, 6000, 'Batsman'),
(8, 'Jasprit Bumrah', 'MI', 110, 100, 'Bowler'),
(9, 'Shubman Gill', 'GT', 80, 2800, 'Batsman'),
(10, 'Andre Russell', 'KKR', 120, 1900, 'All-rounder'),
(11, 'Suresh Raina', 'CSK', 200, 5500, 'Batsman'),
(12, 'Yuzvendra Chahal', 'RR', 115, 50, 'Bowler'),
(13, 'Ben Stokes', 'CSK', 50, 800, 'All-rounder'),
(14, 'Faf du Plessis', 'RCB', 140, 4200, 'Batsman'),
(15, 'Dinesh Karthik', 'RCB', 220, 4100, 'Wicketkeeper'),
(16, 'Sunil Narine', 'KKR', 130, 950, 'All-rounder'),
(17, 'Glenn Maxwell', 'RCB', 90, 2500, 'All-rounder'),
(18, 'Mohammed Shami', 'GT', 110, 60, 'Bowler'),
(19, 'Sanju Samson', 'RR', 130, 3600, 'Wicketkeeper'),
(20, 'Kane Williamson', 'SRH', 95, 2100, 'Batsman');


select* from IPL_Players;

-- 🔸 Find players who scored more runs than the average runs of all players.
select * from IPL_Players
where runs_scored >(
select avg (runs_scored)
from IPL_Players
);
-- 🔸 Find the team with the highest run scorer.
select * 
from IPL_Players
where runs_scored= (
select max(runs_scored)
from IPL_Players
);


-- 🔸 List players who played more matches than MS Dhoni.
select player_name 
from ipl_players
where matches_played >
(
select matches_played
from ipl_players 
where player_name="ms dhoni"
);

-- 🔸 Find all players from the team with the most total runs.
select player_name 
from ipl_players 
where team_name=(
select team_name 
from ipl_players
group by team_name
order by sum(runs_scored)desc
limit 1
);
select* from IPL_Players;

-- 🔸 Find all bowlers who played fewer matches than the average of all players.
select *
from IPL_Players
where role = "Bowler" and matches_played<(
select avg(matches_played)
from ipl_players
);
-- 🔸 Find all players whose run count is within the top 5 highest.
select * from IPL_Players
order by runs_scored desc
limit 5;

-- 🔸 Count number of players in each role.
select role, count(*) as total_player
from IPL_Players
group by role;

-- 🔸 Find teams with more than 3 players
select* from IPL_Players;
-- 🔸 Find average runs scored by role.
select role, avg(runs_scored) as runs_avg
from IPL_Players
group by role;

-- 🔸 List teams where total runs are more than 10,000.
select team_name, sum(runs_scored)as total_runs
from IPL_Players
group by team_name
having  sum(runs_scored)>10000;

-- 🔸 Count players per team with average matches over 100.
select team_name, count(*) as player_count, avg(matches_played) as played_matches_avg
from ipl_players
group by team_name
having avg(matches_played)> 100;

select* from IPL_Players;
-- 🔸 Find number of players for each role with more than 1000 runs.
select role, count(*) as total_num_players
from ipl_players 
where runs_scored > 1000
group by role;
 
-- 🔸 Which role has highest total runs?
select role , sum(runs_scored) as total_runs
from ipl_players
group by  role 
order by total_runs desc
limit 1;
-- 🔸 Rank players based on runs scored.
select player_name, runs_scored,rank() over (order by runs_scored desc) as player_rank from ilp_players;

-- 🔸 Find cumulative runs per team.

-- 🔸 Get top scorer per team.
-- 🔸 Add average runs of each role per player.
-- 🔸 Calculate difference between each player's runs and the average in their team.
-- 🔸 Running total of runs scored sorted by matches played.