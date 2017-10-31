-- 1. Create Table

CREATE TABLE months (id int, name varchar(10), days int);


-- 2. Insert Rows

INSERT INTO months (id,name,days) 
VALUES (3, "March", 31);


-- 3. Select

SELECT name, weapon, hobby
FROM "characters"


-- 4. Where

SELECT * 
FROM "characters" 
WHERE weapon = "pistol";


-- 5. AND / OR

SELECT * 
FROM albums 
WHERE genre = 'rock' AND sales_in_millions <= 50 
ORDER BY released


-- 6. In/Between/Like

SELECT * 
FROM albums 
WHERE genre IN ('pop','soul');


-- 7. Functions

    -- COUNT() - returns the number of rows
    -- SUM() - returns the total sum of a numeric column
    -- AVG() - returns the average of a set of values
    -- MIN() / MAX() - gets the minimum/maximum value from a column

SELECT MAX(released) FROM albums;


-- 8. Nested Select

SELECT artist,album,released 
FROM albums 
WHERE released = (
 SELECT MIN(released) FROM albums
);


-- 9. Joining Tables

SELECT video_games.name, video_games.genre, game_developers.name, game_developers.country 
FROM video_games 
INNER JOIN game_developers 
ON video_games.developer_id = game_developers.id;


-- 10. Aliases

SELECT games.name, games.genre, devs.name AS developer, devs.country 
FROM video_games AS games 
INNER JOIN game_developers AS devs 
ON games.developer_id = devs.id;


-- 11. Update

UPDATE tv_series 
SET genre = 'drama' 
WHERE id = 2;