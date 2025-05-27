/* Create tables */

CREATE TABLE trainer(id						char(4),
					 name					varchar(30)		NOT NULL,
					 years_of_exp			varchar(2),
					 specialization			varchar(20),
					 CONSTRAINT trainer_pkey PRIMARY KEY (id)
					);

CREATE TABLE player(id						varchar(4),
					name					varchar(30)		NOT NULL,
					grade_level				varchar(7)		CHECK(grade_level in ('K', '1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th', 'College', 'Pro')),
					skill_level				char(1)			CHECK(skill_level in ('1', '2', '3', '4', '5')),
					CONSTRAINT player_pkey PRIMARY KEY (id)
				   );

CREATE TABLE training_session(time_slot_id					char(10),
							  day  							varchar(1)			CHECK(day in ('M', 'T', 'W', 'R', 'F')),
							  start_time					char(5),	
							  end_time						char(5),
							  location						varchar(20)			CHECK(location in('Eastern University', 'Zachs Gym')),
							  trainer_id					varchar(4), 
							  CONSTRAINT training_session_pkey PRIMARY KEY (time_slot_id),
							  CONSTRAINT training_session_fkey FOREIGN KEY (trainer_id) REFERENCES trainer (id)
					 										   ON DELETE SET NULL
					 										   ON UPDATE CASCADE
							 );

CREATE TABLE drill(id					char(4),
				   name					varchar(30),
				   difficulty			varchar(12)	CHECK(difficulty in ('Beginner', 'Intermediate', 'Pro')),
				   CONSTRAINT drill_pkey PRIMARY KEY (id)
				  );

CREATE TABLE trainer_phone(id				char(4),
						   phone_num		char(14),
						   CONSTRAINT trainer_phone_pkey PRIMARY KEY (id),
						   CONSTRAINT trainer_phone_fkey FOREIGN KEY (id) REFERENCES trainer (id)
						   							     ON DELETE SET NULL
					 									 ON UPDATE CASCADE
						  );

CREATE TABLE player_phone(id				char(4),
						   phone_num		char(14),
						   CONSTRAINT player_phone_pkey PRIMARY KEY (id),
						   CONSTRAINT player_phone_fkey FOREIGN KEY (id) REFERENCES player (id)
						   								ON DELETE SET NULL
					 									ON UPDATE CASCADE
						  );

CREATE TABLE enroll(player_id					char(4),
					time_slot_id				char(10),
					CONSTRAINT enroll_pkey PRIMARY KEY (player_id, time_slot_id),
					CONSTRAINT enroll_fkey1 FOREIGN KEY (player_id) REFERENCES player (id)
											ON DELETE CASCADE
					 						ON UPDATE CASCADE,
					CONSTRAINT enroll_fkey2 FOREIGN KEY (time_slot_id) REFERENCES training_session (time_slot_id)
											ON DELETE CASCADE
					 						ON UPDATE CASCADE
					);

CREATE TABLE participate(player_id				varchar(4),
						 drill_id				varchar(4),
						 CONSTRAINT participate_pkey PRIMARY KEY (player_id, drill_id),
						 CONSTRAINT participate_fkey1 FOREIGN KEY (player_id) REFERENCES player (id)
						 							  ON DELETE CASCADE
					 								  ON UPDATE CASCADE,
						 CONSTRAINT participate_fkey2 FOREIGN KEY (drill_id) REFERENCES drill (id)
						 							  ON DELETE CASCADE
					 								  ON UPDATE CASCADE
						);
CREATE TABLE coach(trainer_id				varchar(4),
					player_id				varchar(4),
					CONSTRAINT trains_pkey PRIMARY KEY (trainer_id, player_id),
					CONSTRAINT trains_fkey1 FOREIGN KEY (trainer_id) REFERENCES trainer (id)
											ON DELETE CASCADE
					 						ON UPDATE CASCADE,
					CONSTRAINT trains_fkey2 FOREIGN KEY (player_id) REFERENCES player (id)
											ON DELETE CASCADE
					 						ON UPDATE CASCADE
				   );

/* Create views */ 

/* This view allows you to see which players have worked with which trainers. It shows you the player's name
   and id as well as the corresponding trainer's name and id. */
CREATE VIEW player_trainers AS
	    SELECT P.name AS player_name, P.id AS player_id, T.name AS trainer_name, T.id AS trainer_id
	    FROM player AS P, trainer AS T, coach as C
		WHERE C.player_id = P.id AND
			  C.trainer_id = T.id;

/* This view allows you to see the name, grade level, and skill level for all high school players */ 
CREATE VIEW high_schoolers AS
		SELECT id AS player_id, name AS player_name, grade_level, skill_level
		FROM player
		WHERE grade_level IN ('9th', '10th', '11th', '12th');
		
/* Create functions */

/* This function allows you to find all trainers of a specific specialization */
CREATE OR REPLACE FUNCTION specialize_in (specialization varchar(20)) 
	RETURNS TABLE (idd char(4),
			name varchar(30),
			years_of_expp varchar(2),
			specializationn varchar(20))
	LANGUAGE plpgsql
	AS
	$$
		BEGIN
			RETURN QUERY
			SELECT id, name, years_of_exp, trainer.specialization
			FROM trainer
			WHERE trainer.specialization = specialize_in.specialization;
		END;
	$$;

/* This function allows you to find all players in a given training session */
CREATE OR REPLACE FUNCTION players_in_session(time_slot_id CHAR(10))
	RETURNS TABLE(player_id char(4), 
			player_name varchar(30), 
			grade_level varchar(7))
	LANGUAGE plpgsql 
	AS
	$$
		BEGIN
    		RETURN QUERY
    		SELECT player.id AS player_id, player.name AS player_name, player.grade_level, player.skill_level
    		FROM enroll, player 
    		WHERE enroll.time_slot_id = player_in_session.time_slot_id;
		END;
	$$;

/* Create Procedure */

/* This procedure allows you to add players to the player table */
CREATE OR REPLACE PROCEDURE add_player(IN id varchar(4),
									   IN name varchar(4),
    								   IN grade_level varchar(7),
    								   IN skill_level char(1)
)
	LANGUAGE plpgsql
	AS
	$$
		BEGIN
    		INSERT INTO player(id, name, grade_level, skill_level)
    		VALUES (id, name, grade_level, skill_level);
		END;
	$$;

/* Create trigger function and trigger */

/* Trigger function creates a function that adds a player and corresponding trainer into the coach table*/
CREATE OR REPLACE FUNCTION link_coach_and_player()
	RETURNS TRIGGER 
	LANGUAGE plpgsql
	AS
	$$
		BEGIN 
    		INSERT INTO coach(trainer_id, player_id)
    		VALUES ((SELECT trainer_id FROM training_session WHERE time_slot_id = NEW.time_slot_id),NEW.player_id);
    RETURN NEW;
END;
$$;

/* Trigger goes into effect when a player is add to the enroll table */
CREATE TRIGGER new_enrollment_trigger
AFTER INSERT ON enroll
FOR EACH ROW 
EXECUTE FUNCTION link_coach_and_player();