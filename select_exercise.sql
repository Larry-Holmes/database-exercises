SHOW DATABASES;

USE albums_db;

SHOW tables;
-- a. There are 31 rows in the albums table
SELECT * FROM albums;
-- b. There are 23 unique artist names in the albums table
SELECT DISTINCT artist FROM albums;
-- c. id is the primary key for the albums table
DESCRIBE albums;
-- d. 1967 is the oldest release date for any album and 2011 is the most recent release date
SELECT DISTINCT release_date FROM albums WHERE release_date > 2000;
-- 4a. Albums by Pink Floyd are The Dark Side of the Moon and The Wall
SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- 4b. The year the album was released was 1967
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- 4c. The genre that Nevermind belongs to is Grunge, Alternative rock
SELECT genre FROM albums WHERE name = "Nevermind";
/* 4d. The albums The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love
Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, and Supernatural
were released in the 90's */
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;
-- 4e. The primary key for the albums table is id.
DESCRIBE albums;
/* 4f. Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A., and Supernatural are all Rock.
These query results do not include albums with a genre of "Hard rock" or "Progressive rock" because those are unique
values. */
SELECT DISTINCT genre FROM albums;
SELECT name FROM albums WHERE genre = 'Rock';



