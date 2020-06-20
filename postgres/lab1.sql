--LAB1A

CREATE TABLE users(
id SERIAL PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100) NOT NULL,
password VARCHAR(100) NOT NULL,
created_at TIMESTAMP,
updated_at TIMESTAMP
);


CREATE TABLE status(
id SERIAL PRIMARY KEY,
description VARCHAR(100) NOT NULL,
created_at TIMESTAMP,
updated_at TIMESTAMP
);


CREATE TABLE inventory(
id SERIAL PRIMARY KEY,
status_id integer NOT NULL,
description VARCHAR(100) NOT NULL,
created_at TIMESTAMP,
updated_at TIMESTAMP,
CONSTRAINT inventory_status_id_fkey FOREIGN KEY (status_id) REFERENCES status (id) MATCH SIMPLE
);

CREATE TABLE transactions(
id SERIAL PRIMARY KEY,
user_id int NOT NULL,
inventory_id int,
checkout_time TIMESTAMP,
scheduled_checkin_time TIMESTAMP,
actual_checkin_time TIMESTAMP,
created_at TIMESTAMP,
updated_at TIMESTAMP,
CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id) MATCH FULL,
CONSTRAINT inventory_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES inventory (id) MATCH FULL
);



INSERT INTO users (first_name,last_name,email,password,created_at, updated_at)
VALUES ('sally', 'johnson', 's.johnson@uis.edu', 'abc', '2018-05-01 09:30', '2019-01-01 09:30'),
('joe', 'smith', 'j.smith@uis.edu', 'def', '2018-09-01 09:30', '2019-02-01 10:30'),
('jackie', 'brown', 'j.brown@uis.edu', 'ghi', '2018-10-01 09:30', '2019-03-01 11:30'),
('matt', 'hanson', 'm.hanson@uis.edu', 'jkl', '2018-11-01 09:30', '2019-01-30 08:30'),
('gary', 'lopez', 'g.lopez@uis.edu', 'mno', '2018-07-01 09:30', '2019-03-30 07:30')
;


INSERT INTO status (description,created_at,updated_at)
VALUES ('Available', '2018-10-01 15:30', '2019-05-01 15:30'),
('Checked Out', '2018-07-01 15:30','2019-04-01 16:30'),
('Overdue', '2018-11-01 15:30','2019-02-15 11:30'),
('Unavailable', '2018-07-01 15:30', '2019-01-15 09:30'),
('Under Repair','2018-06-01 15:30','2019-03-01 06:30')
;


INSERT INTO inventory (status_id,description,created_at,updated_at)
VALUES (1, 'Laptop1', '2019-04-01 07:30', '2019-05-01 12:30'),
(1, 'Laptop2', '2019-02-01 11:30', '2019-04-01 15:30'),
(3, 'Webcam1', '2019-03-01 12:30', '2019-03-01 14:30'),
(4, 'TV1', '2019-02-01 09:30', '2019-02-01 11:30'),
(5, 'Microphone1', '2019-01-01 08:30', '2019-01-01 09:30')
;


INSERT INTO transactions (user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at)
VALUES (1, 1, '2019-01-01 08:30', '2019-06-01 09:30', '2019-01-06 08:30', '2019-01-01 09:30','2019-01-07 09:30'),
(3, 3, '2019-01-05 08:30', '2019-01-09 09:30', '2019-01-08 08:30', '2019-03-05 09:30', '2019-01-08 09:30'),
(1, 5, '2019-01-06 08:30', '2019-07-01 09:30', '2019-01-01 08:30', '2019-01-15 09:30', '2019-01-10 09:30')
;

UPDATE inventory
SET status_id=2
WHERE id =1 OR id =3 OR id =5;


ALTER TABLE users ADD COLUMN signed_agreement BOOLEAN DEFAULT FALSE;


SELECT * FROM transactions 
LEFT JOIN inventory on inventory.id=transactions.inventory_id
WHERE status_id = 2
ORDER BY scheduled_checkin_time DESC;

SELECT * FROM transactions
WHERE scheduled_checkin_time > '2019-05-31 00:00';


SELECT COUNT(inventory.id) FROM transactions
LEFT JOIN inventory on inventory.id=transactions.inventory_id
WHERE user_id=1
AND status_id=2;


--LAB1B

--View
--Insert new rows into transactions where items are checked in late
INSERT INTO transactions (user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at)
VALUES (2, 2, '2019-01-01 08:30', '2019-06-01 09:30', '2019-06-02 08:30', '2019-01-01 09:30','2019-01-07 09:30'),
(4, 4, '2019-01-05 08:30', '2019-01-09 09:30', '2019-01-10 08:30', '2019-03-05 09:30', '2019-01-08 09:30'),
(2, 5, '2019-01-06 08:30', '2019-07-01 09:30', '2019-07-02 08:30', '2019-01-15 09:30', '2019-01-10 09:30')
;

--Create late checkins view
CREATE VIEW late_checkins AS
SELECT
user_id, transactions.inventory_id, description,COUNT(*) FROM transactions
LEFT JOIN inventory on inventory.id=transactions.inventory_id
WHERE actual_checkin_time>scheduled_checkin_time
GROUP BY user_id, transactions.inventory_id, description
;

--Test checkins view
SELECT * FROM late_checkins;


--Trigger Procedures
--View all currently available items
select * from inventory where status_id=1;


--Procedure to replace status_id with 'Checked Out' in the inventory table
CREATE OR REPLACE FUNCTION update_status()
RETURNS trigger AS
$$
BEGIN
UPDATE inventory
SET status_id =2
WHERE id=NEW.id;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

--Trigger to execute update_status() after row insertion
CREATE TRIGGER trigger_update_status
AFTER INSERT
ON inventory
FOR EACH ROW
EXECUTE PROCEDURE update_status(); 



--Insert new rows to test trigger
INSERT INTO inventory (status_id,description,created_at,updated_at)
VALUES (5, 'Laptop1', '2019-04-01 07:30', '2019-05-01 12:30');

--Query inventory table
SELECT * FROM inventory;