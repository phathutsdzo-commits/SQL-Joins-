-- Databricks notebook source
-- Creating Users Table
CREATE OR REPLACE TABLE users (
    user_id INT,
    user_name STRING,
    country STRING
);
INSERT INTO users VALUES
(1, 'Nomvula', 'Johannesburg'),
(2, 'David', 'Cape Town'),
(3, 'Anele', 'Durban'),
(4, 'Kabelo', 'Pretoria'),
(5, 'Lerato', 'Port Elizabeth');

select *
from users;

-- Creating Plans Table
CREATE OR REPLACE TABLE plans (
    plan_id INT,
    plan_name STRING,
    monthly_price INT
);

INSERT INTO plans VALUES
(10, 'Basic', 79),
(11, 'Standard', 129),
(12, 'Premium', 199),
(13, 'Family', 249),
(14, 'Mobile', 59);

SELECT * FROM plans;

-- Creating Subscriptions Table
CREATE OR REPLACE TABLE subscriptions (
    subscription_id INT,
    user_id INT,
    plan_id INT,
    start_date DATE
);

INSERT INTO subscriptions VALUES
(501, 1, 10, '2026-01-15'),
(502, 2, 11, '2026-02-01'),
(503, 1, 12, '2026-03-10'),
(504, 6, 11, '2026-03-20'),
(505, 3, 13, '2026-04-05');

SELECT * FROM subscriptions;

-- Creating Shows Table
CREATE OR REPLACE TABLE shows (
    show_id INT,
    show_title STRING,
    genre STRING
);

INSERT INTO shows VALUES
(701, 'Comedy Hour', 'Comedy'),
(702, 'Crime Time', 'Drama'),
(703, 'Tech Tales', 'Documentary'),
(704, 'Cooking Lab', 'Lifestyle'),
(706, 'Wild Earth', 'Documentary');


SELECT * FROM shows;

-- Creating Viewing Sessions Table
CREATE OR REPLACE TABLE viewing_sessions (
    session_id INT,
    user_id INT,
    show_id INT,
    watch_minutes INT
);

INSERT INTO viewing_sessions VALUES
(901, 1, 701, 45),
(902, 2, 703, 30),
(903, 1, 702, 60),
(904, 7, 701, 20),
(905, 3, 705, 90);

SELECT * FROM viewing_sessions;

---Part A  INNER JOIN-----
--Q1--
SELECT A.user_id,A.user_name,B.subscription_id,B.start_date
FROM users AS A
INNER JOIN subscriptions AS B
    ON A.user_id = B.user_id;
---Q2----
SELECT s.plan_id,s.subscription_id,s.user_id,p.plan_name,p.monthly_price,s.start_date
FROM subscriptions AS s
INNER JOIN plans AS p
    ON s.plan_id = p.plan_id;
-----Q3----
SELECT V.session_id, V.user_id, S.show_title, S.genre, V.watch_minutes
FROM viewing_sessions AS V
INNER JOIN shows AS S
    ON V.show_id = S.show_id;
--Q4----
SELECT S.user_name,S. country, V.session_id,V. show_id, V.watch_minutes
FROM users AS S
INNER JOIN viewing_sessions AS V
    ON S.user_id = V.user_id;
---Q5----
SELECT  U.user_name,U.country,P.plan_name,P.monthly_price, S.start_date
FROM users AS U
INNER JOIN subscriptions AS S
    ON U.user_id = S.user_id
    INNER JOIN plans AS P
    ON S.plan_id = P.plan_id;
---- Part B  —  LEFT JOIN-----
---Q6-----
SELECT u.user_id, u.user_name,s.subscription_id,s.plan_id,s.start_date
FROM users AS u
LEFT JOIN subscriptions AS s
    ON u.user_id = s.user_id;

Q7:
SELECT P.plan_id,P.plan_name, S.subscription_id, S.user_id
FROM plans AS P
LEFT JOIN subscriptions AS S
    ON P.plan_id = S.plan_id;
----Q8-----
SELECT S.show_id,  S.show_title, V.session_id, V.watch_minutes
FROM shows AS S
LEFT JOIN viewing_sessions AS V
    ON S.show_id = V.show_id;
----Q9-----
SELECT V.session_id, V.show_id, V.watch_minutes, U.user_id,U.user_name
FROM viewing_sessions AS V
LEFT JOIN users AS U
    ON V.user_id = U.user_id;
---Q10------
SELECT  U.user_name,U.country,P.plan_name,P.monthly_price
FROM users AS U
LEFT JOIN subscriptions AS S
    ON U.user_id = S.user_id
    LEFT JOIN plans AS P
    ON S.plan_id = P.plan_id;
-----Part C  —  FULL OUTER JOIN------
----Q11----
SELECT u.user_id, u.user_name, s.subscription_id, s.start_date
    FROM users AS u
FULL OUTER JOIN subscriptions AS s
    ON u.user_id = s.user_id;
----Q12-----
SELECT P.plan_id,P.plan_name, S.subscription_id, S.user_id
    FROM plans AS P
FULL OUTER JOIN subscriptions AS S
    ON P.plan_id = S.plan_id;
-----Q13------
SELECT S.show_id, S.show_title, V.session_id,V.watch_minutes
    FROM shows AS S
FULL OUTER JOIN viewing_sessions AS V
    ON S.show_id = V.show_id;
-----Q14------
SELECT U.user_id,U.user_name, V.session_id, V.show_id,V.watch_minutes
    FROM users AS U
FULL OUTER JOIN viewing_sessions AS V
    ON U.user_id = V.user_id;
-----Q15-----
SELECT  U.user_id, U.user_name,S. subscription_id, P.plan_id,P. plan_name
FROM users AS U
LEFT JOIN subscriptions AS S
    ON U.user_id = S.user_id
    LEFT JOIN plans AS P
   :param_1 ON S.plan_id = P.plan_id;