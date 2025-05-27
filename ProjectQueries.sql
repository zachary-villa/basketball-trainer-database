/* Create queries */

-- 1. Get the number of players enrolled in each training session.
SELECT TS.time_slot_id, COUNT(E.player_id) AS number_of_players
FROM training_session AS TS, enroll AS E 
WHERE E.time_slot_id = TS.time_slot_id
GROUP BY TS.time_slot_id;

-- 2. Show's every player and what drills they did if they participated in a drill. 
SELECT PA.id, PA.name, D.id, D.name 
FROM player AS PA, drill AS D, participate AS P 
WHERE PA.id = P.player_id AND
	  D.id = P.drill_id;

-- 3. Show all trainers and their phone number's. 
SELECT trainer.name, trainer_phone.phone_num
FROM trainer NATURAL JOIN trainer_phone; 

-- 4. Show all players and their phone number's.
SELECT player.name, player_phone.phone_num
FROM player NATURAL JOIN player_phone; 

-- 5. Shows number of drills per difficulty level.
SELECT difficulty, COUNT(difficulty) AS num_drills
FROM drill
GROUP BY difficulty; 

-- 6. Finds average skill level of players in a training session.
SELECT E.time_slot_id, ROUND(AVG(CAST(P.skill_level AS integer)), 2) AS avg_skill_level
FROM player AS P, enroll AS E
WHERE P.id = E.player_id
GROUP BY E.time_slot_id;

-- 7. This query allows you to see all of the trainers who work on defense. 
SELECT * 
FROM trainer
WHERE specialization = 'Defense';

-- 8. This query shows all drills grouped by their difficulty
SELECT id, name, difficulty
FROM drill
WHERE difficulty = 'Pro';
