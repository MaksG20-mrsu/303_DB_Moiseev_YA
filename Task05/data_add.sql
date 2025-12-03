-- Лабораторная работа 5: Добавление новых данных
-- Автор: Ян Моисеев

-- 1. Добавление 5 новых пользователей (себя и 4 соседей по группе)

-- 1.1. Ян Моисеев (я)
INSERT INTO users (name, email, gender, occupation_id) VALUES
('Ян Моисеев', 'yan.moiseev@student.mrsu.ru', 'M', 
 (SELECT id FROM occupations WHERE name = 'студент'));

-- 1.2. Руслан Леонтьев
INSERT INTO users (name, email, gender, occupation_id) VALUES
('Руслан Леонтьев', 'ruslan.leontiev@student.mrsu.ru', 'M',
 (SELECT id FROM occupations WHERE name = 'студент'));

-- 1.3. София Лосева
INSERT INTO users (name, email, gender, occupation_id) VALUES
('София Лосева', 'sofiya.loseva@student.mrsu.ru', 'F',
 (SELECT id FROM occupations WHERE name = 'студент'));

-- 1.4. Александр Мулюгин
INSERT INTO users (name, email, gender, occupation_id) VALUES
('Александр Мулюгин', 'alexander.mulyugin@student.mrsu.ru', 'M',
 (SELECT id FROM occupations WHERE name = 'студент'));

-- 1.5. Дмитрий Кечемайкин
INSERT INTO users (name, email, gender, occupation_id) VALUES
('Дмитрий Кечемайкин', 'dmitry.kechemaykin@student.mrsu.ru', 'M',
 (SELECT id FROM occupations WHERE name = 'студент'));

-- 2. Добавление 3 новых фильмов разных жанров

-- 2.1. Люси (2014)
INSERT INTO movies (title, year) VALUES ('Люси', 2014);

-- Добавление жанров для фильма "Люси"
INSERT INTO movie_genres (movie_id, genre_id) VALUES
((SELECT id FROM movies WHERE title = 'Люси'), 
 (SELECT id FROM genres WHERE name = 'Боевик')),
((SELECT id FROM movies WHERE title = 'Люси'), 
 (SELECT id FROM genres WHERE name = 'Фантастика')),
((SELECT id FROM movies WHERE title = 'Люси'), 
 (SELECT id FROM genres WHERE name = 'Триллер'));

-- 2.2. Сознание (2023)
INSERT INTO movies (title, year) VALUES ('Сознание', 2023);

-- Добавление жанров для фильма "Сознание"
INSERT INTO movie_genres (movie_id, genre_id) VALUES
((SELECT id FROM movies WHERE title = 'Сознание'), 
 (SELECT id FROM genres WHERE name = 'Фантастика')),
((SELECT id FROM movies WHERE title = 'Сознание'), 
 (SELECT id FROM genres WHERE name = 'Триллер')),
((SELECT id FROM movies WHERE title = 'Сознание'), 
 (SELECT id FROM genres WHERE name = 'Драма'));

-- 2.3. Тихое место (2022)
INSERT INTO movies (title, year) VALUES ('Тихое место', 2022);

-- Добавление жанров для фильма "Тихое место"
INSERT INTO movie_genres (movie_id, genre_id) VALUES
((SELECT id FROM movies WHERE title = 'Тихое место'), 
 (SELECT id FROM genres WHERE name = 'Ужасы')),
((SELECT id FROM movies WHERE title = 'Тихое место'), 
 (SELECT id FROM genres WHERE name = 'Триллер')),
((SELECT id FROM movies WHERE title = 'Тихое место'), 
 (SELECT id FROM genres WHERE name = 'Драма'));

-- 3. Добавление 3 новых отзывов о добавленных фильмах от меня (Ян Моисеев)

-- 3.1. Отзыв о фильме "Люси"
INSERT INTO ratings (user_id, movie_id, rating) VALUES
((SELECT id FROM users WHERE name = 'Ян Моисеев'), 
 (SELECT id FROM movies WHERE title = 'Люси'), 4.3);

-- 3.2. Отзыв о фильме "Сознание"
INSERT INTO ratings (user_id, movie_id, rating) VALUES
((SELECT id FROM users WHERE name = 'Ян Моисеев'), 
 (SELECT id FROM movies WHERE title = 'Сознание'), 4.7);

-- 3.3. Отзыв о фильме "Тихое место"
INSERT INTO ratings (user_id, movie_id, rating) VALUES
((SELECT id FROM users WHERE name = 'Ян Моисеев'), 
 (SELECT id FROM movies WHERE title = 'Тихое место'), 4.9);

-- 4. Добавление тегов от меня к этим фильмам

-- 4.1. Тег к фильму "Люси"
INSERT INTO tags (user_id, movie_id, tag) VALUES
((SELECT id FROM users WHERE name = 'Ян Моисеев'), 
 (SELECT id FROM movies WHERE title = 'Люси'), 'Мозг на 100%');

-- 4.2. Тег к фильму "Сознание"
INSERT INTO tags (user_id, movie_id, tag) VALUES
((SELECT id FROM users WHERE name = 'Ян Моисеев'), 
 (SELECT id FROM movies WHERE title = 'Сознание'), 'Искусственный интеллект');

-- 4.3. Тег к фильму "Тихое место"
INSERT INTO tags (user_id, movie_id, tag) VALUES
((SELECT id FROM users WHERE name = 'Ян Моисеев'), 
 (SELECT id FROM movies WHERE title = 'Тихое место'), 'Тишина убивает');
