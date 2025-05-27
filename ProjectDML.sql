/* Insert statements */

-- trainer 
INSERT INTO trainer(id, name, years_of_exp, specialization)
VALUES('0001', 'Zach', '18', 'Shooting');

INSERT INTO trainer(id, name, years_of_exp, specialization)
VALUES('0002', 'Kaleb', '17', 'Dribbling');

INSERT INTO trainer(id, name, years_of_exp, specialization)
VALUES('0003', 'Evan', '14', 'Shot Creating');

INSERT INTO trainer(id, name, years_of_exp, specialization)
VALUES('0004', 'Kenny', '14', 'Finishing');

INSERT INTO trainer(id, name, years_of_exp, specialization)
VALUES('0005', 'Caden', '4', 'Defense');

-- player
INSERT INTO player(id, name, grade_level, skill_level)
VALUES('1000', 'LeBron', 'Pro', '5');

INSERT INTO player(id, name, grade_level, skill_level)
VALUES('2000', 'Kyrie', 'Pro', '5');

INSERT INTO player(id, name, grade_level, skill_level)
VALUES('3000', 'Luka', 'Pro', '5');

INSERT INTO player(id, name, grade_level, skill_level)
VALUES('4000', 'Giannis', 'Pro', '5');

INSERT INTO player(id, name, grade_level, skill_level)
VALUES('5000', 'Draymond', 'Pro', '5');

-- training_session
INSERT INTO training_session(time_slot_id, day, start_time, end_time, location, trainer_id)
VALUES('M2000-2200', 'M', '20:00', '22:00', 'Zachs Gym', '0001');

INSERT INTO training_session(time_slot_id, day, start_time, end_time, location, trainer_id)
VALUES('T1800-2000', 'T', '18:00', '20:00', 'Zachs Gym', '0002');

INSERT INTO training_session(time_slot_id, day, start_time, end_time, location, trainer_id)
VALUES('W1600-1800', 'W', '16:00', '18:00', 'Zachs Gym', '0003');

INSERT INTO training_session(time_slot_id, day, start_time, end_time, location, trainer_id)
VALUES('R2000-2200', 'R', '20:00', '22:00', 'Eastern University', '0004');

INSERT INTO training_session(time_slot_id, day, start_time, end_time, location, trainer_id)
VALUES('F2000-2300', 'F', '20:00', '23:00', 'Zachs Gym', '0005');

-- drill
INSERT INTO drill(id, name, difficulty)
VALUES('0000', 'Form Shooting', 'Beginner');

INSERT INTO drill(id, name, difficulty)
VALUES('1111', 'Tennis Ball Dribbling', 'Pro');

INSERT INTO drill(id, name, difficulty)
VALUES('2222', 'Kobe Drill', 'Pro');

INSERT INTO drill(id, name, difficulty)
VALUES('3333', 'Euro Step', 'Intermediate');

INSERT INTO drill(id, name, difficulty)
VALUES('4444', 'ZigZag Drill', 'Beginner');

-- trainer_phone 
INSERT INTO trainer_phone(id, phone_num)
VALUES('0001', '(210)-502-7640');

INSERT INTO trainer_phone(id, phone_num)
VALUES('0002', '(210)-205-0467');

INSERT INTO trainer_phone(id, phone_num)
VALUES('0003', '(502)-210-4076');

INSERT INTO trainer_phone(id, phone_num)
VALUES('0004', '(610)-341-1737');

INSERT INTO trainer_phone(id, phone_num)
VALUES('0005', '(610)-341-5820');

-- player_phone
INSERT INTO player_phone(id, phone_num)
VALUES('1000', '(213)-626-2003');

INSERT INTO player_phone(id, phone_num)
VALUES('2000', '(123)-342-2034');

INSERT INTO player_phone(id, phone_num)
VALUES('3000', '(737)-533-2000');

INSERT INTO player_phone(id, phone_num)
VALUES('4000', '(501)-342-3423');

INSERT INTO player_phone(id, phone_num)
VALUES('5000', '(444)-444-4444');

-- enroll 
INSERT INTO enroll(player_id, time_slot_id)
VALUES('1000', 'M2000-2200');

INSERT INTO enroll(player_id, time_slot_id)
VALUES('2000', 'T1800-2000');

INSERT INTO enroll(player_id, time_slot_id)
VALUES('3000', 'W1600-1800');

INSERT INTO enroll(player_id, time_slot_id)
VALUES('4000', 'R2000-2200');

INSERT INTO enroll(player_id, time_slot_id)
VALUES('5000', 'F2000-2300');

-- participate
INSERT INTO participate(player_id, drill_id)
VALUES('1000', '0000');

INSERT INTO participate(player_id, drill_id)
VALUES('2000', '1111');

INSERT INTO participate(player_id, drill_id)
VALUES('3000', '2222');

INSERT INTO participate(player_id, drill_id)
VALUES('4000', '3333');

INSERT INTO participate(player_id, drill_id)
VALUES('5000', '4444');

-- coach 

/*These values are automatically populated via the trigger in my DDL file. 
  I commented them out so the file would run without error, but these are values that would be in the table. */

/*
INSERT INTO coach(trainer_id, player_id)
VALUES('0001', '1000');

INSERT INTO coach(trainer_id, player_id)
VALUES('0002', '2000');

INSERT INTO coach(trainer_id, player_id)
VALUES('0003', '3000');

INSERT INTO coach(trainer_id, player_id)
VALUES('0004', '4000');

INSERT INTO coach(trainer_id, player_id)
VALUES('0005', '5000');
*/

/* Update statements */
UPDATE trainer
SET years_of_exp = '5'
WHERE id = '0005';

UPDATE player
SET skill_level = '4'
WHERE id = '2000';

UPDATE training_session
SET location = 'Eastern University'
WHERE time_slot_id = 'F2000-2300';

UPDATE drill
SET difficulty = 'Pro'
WHERE id = '3333';

UPDATE trainer_phone 
SET phone_num = '(210)-392-2767'
WHERE id = '0001';

UPDATE player_phone 
SET phone_num = '(325)-752-6932'
WHERE id = '2000';

UPDATE enroll 
SET time_slot_id = 'T1800-2000'
WHERE player_id = '4000';

UPDATE participate
SET drill_id = '1111'
WHERE player_id = '1000';

UPDATE coach
SET trainer_id = '0001'
WHERE player_id = '1000';

/* Delete statements */
DELETE 
FROM participate
WHERE player_id = '1000';

DELETE 
FROM enroll
WHERE player_id = '1000';

DELETE 
FROM player_phone
WHERE id = '1000';

DELETE 
FROM player
WHERE id = '1000';

DELETE 
FROM trainer_phone
WHERE id = '0001';

DELETE
FROM training_session 
WHERE trainer_id = '0001';

DELETE 
FROM trainer
WHERE id = '0001';

DELETE 
FROM drill 
WHERE id = '4444';

DELETE 
FROM coach 
WHERE trainer_id = '0001';