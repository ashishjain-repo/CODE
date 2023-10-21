USE film;
-- Inserting Data into Genre Table.
INSERT INTO genre (genre_name) VALUES 
('Action'),('Adventure'),('Animated'),('Comedy'),('Drama'),('Family'),('Music'),('Musical'),('Romance'),('Sci Fi');

-- Inserting Data into Price Table.
INSERT INTO price (price_id,price_cost) VALUES
(1,19.95),(2,24.95),(3,35.00);

-- Inserting Data into Studio Table.
INSERT INTO studio (studio_name) VALUES
('20th Century Fox'), ('Apple TV+'), ('MGM'), ('Pixar'),('Warner Bros');

-- Inserting Data into Media Table.
INSERT INTO media (media_type) VALUES
('4k'),('blu-ray'),('DVD'),('Streaming');

-- Inserting Data into Special Table (Feature).
INSERT INTO special (special_type) VALUES
('actor interviews'),('bloopers'),('cut scenes'),('Deleted scenes'),('Special Effects'),('Trailers');


INSERT INTO actor(actor_fname,actor_mname,actor_lname) VALUES
('Annie',NULL,'Potts'),('Carrie',NULL,'Fisher'),('Cyd',NULL,'Charisse'),('Emillia',NULL,'Jones'),('Gene',NULL,'Kelly'),('Harrison',NULL,'Ford'),('Jason',NULL,'Momoa'),
('John',NULL,'Ratzenberger'),('Mark',NULL,'Hamill'),('Marlee',NULL,'Matlin'),('Oscar',NULL,'Isaac'),('Rebecca',NULL,'Ferguson'),('Tim',NULL,'Allen'),
('Timothee',NULL,'Chalamet'),('Tom',NULL,'Hanks'),('Troy',NULL,'Kotsur'),('Van',NULL,'Johnson'),('Zendaya',NULL,NULL);

INSERT INTO title (title_name, title_year, title_rating, studio_id) VALUES
('Brigadoone','1954','G',3),('Coda','2021','PG-13',2),('Dune','2021','PG-13',5),('The Empire Strikes Back','1977','PG',1),
('Toy Story','1995','G',4),('Toy Story 2','1999','G',4);
-- SELECT * FROM genre; -- SELECT * FROM price; -- SELECT * FROM studio; -- SELECT * FROM actor; -- SELECT * FROM special; -- SELECT * FROM title;

-- Linking Tables

INSERT INTO title_actor(title_id, actor_id) VALUES
(1,5),(1,3),(1,17),(2,4),(2,10),(2,16),(3,14),(3,12),(3,18),(3,11),(3,7),(4,6),(4,2),(4,9),(5,15),(5,13),(5,1),(5,8),(6,13),(6,15),(6,8),(6,1);

INSERT INTO title_genre(title_id,genre_id) VALUES
(1,8),(1,9),(2,4),(2,5),(2,7),(3,1),(3,2),(3,5),(4,10),(5,6),(5,3),(6,6),(6,3);

INSERT INTO title_media(title_id,media_id,price_id) VALUES
(1,3,1),(2,4,NULL),(3,1,2),(3,2,1),(4,2,3),(5,3,1),(6,3,2);

INSERT INTO title_special(title_id,special_id) VALUES
(2,6),(3,6),(3,4),(3,5),(4,3),(4,2),(5,2),(6,1);


SELECT 
    t.title_name AS Title,
    s.studio_name AS Studio,
    GROUP_CONCAT(DISTINCT m.media_type) AS Media,
    t.title_year AS 'Year Released',
    GROUP_CONCAT(DISTINCT g.genre_name) AS Genre,
    GROUP_CONCAT(DISTINCT CONCAT(a.actor_fname, ' ', COALESCE(a.actor_mname, ''), ' ', COALESCE(a.actor_lname, ''))) AS Actors,
    GROUP_CONCAT(DISTINCT sp.special_type) AS 'Special Features',
    t.title_rating AS Rating,
    p.price_cost AS Price 
FROM 
    film.title t
    JOIN film.studio s ON t.studio_id = s.studio_id
    LEFT JOIN film.title_genre tg ON t.title_id = tg.title_id
    LEFT JOIN film.genre g ON tg.genre_id = g.genre_id
    LEFT JOIN film.title_special ts ON t.title_id = ts.title_id
    LEFT JOIN film.special sp ON ts.special_id = sp.special_id
    LEFT JOIN film.title_actor ta ON t.title_id = ta.title_id
    LEFT JOIN film.actor a ON ta.actor_id = a.actor_id
    LEFT JOIN film.title_media tm ON t.title_id = tm.title_id
    LEFT JOIN film.media m ON tm.media_id = m.media_id
    LEFT JOIN film.price p ON tm.price_id = p.price_id
GROUP BY 
    t.title_id, t.title_name, t.title_year, t.title_rating, s.studio_name, p.price_cost;