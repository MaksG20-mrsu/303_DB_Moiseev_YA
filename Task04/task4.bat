#!/bin/bash
chcp 65001

sqlite3 movies_rating.db < db_init.sql

echo "1. Найти все пары пользователей, оценивших один и тот же фильм. Устранить дубликаты, проверить отсутствие пар с самим собой. Для каждой пары должны быть указаны имена пользователей и название фильма, который они ценили. В списке оставить первые 100 записей."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT DISTINCT 
    u1.name AS user1, 
    u2.name AS user2, 
    m.title AS movie_title
FROM ratings r1
JOIN ratings r2 ON r1.movie_id = r2.movie_id AND r1.user_id < r2.user_id
JOIN users u1 ON r1.user_id = u1.id
JOIN users u2 ON r2.user_id = u2.id
JOIN movies m ON r1.movie_id = m.id
ORDER BY m.title, u1.name, u2.name
LIMIT 100;"
echo " "

echo "2. Найти 10 самых старых оценок от разных пользователей, вывести названия фильмов, имена пользователей, оценку, дату отзыва в формате ГГГГ-ММ-ДД."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT DISTINCT
    m.title AS movie_title,
    u.name AS user_name,
    r.rating,
    date(r.timestamp, 'unixepoch') AS review_date
FROM ratings r
JOIN movies m ON r.movie_id = m.id
JOIN users u ON r.user_id = u.id
ORDER BY r.timestamp ASC
LIMIT 10;"
echo " "

echo "3. Вывести в одном списке все фильмы с максимальным средним рейтингом и все фильмы с минимальным средним рейтингом. Общий список отсортировать по году выпуска и названию фильма. В зависимости от рейтинга в колонке 'Рекомендуем' для фильмов должно быть написано 'Да' или 'Нет'."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "WITH avg_ratings AS (
    SELECT 
        m.id,
        m.title,
        m.year,
        AVG(r.rating) AS avg_rating
    FROM movies m
    JOIN ratings r ON m.id = r.movie_id
    GROUP BY m.id, m.title, m.year
),
min_max AS (
    SELECT 
        MIN(avg_rating) AS min_rating,
        MAX(avg_rating) AS max_rating
    FROM avg_ratings
)
SELECT 
    ar.title AS 'Название фильма',
    ar.year AS 'Год выпуска',
    ROUND(ar.avg_rating, 2) AS 'Средний рейтинг',
    CASE 
        WHEN ar.avg_rating = (SELECT max_rating FROM min_max) THEN 'Да'
        ELSE 'Нет'
    END AS 'Рекомендуем'
FROM avg_ratings ar
WHERE ar.avg_rating = (SELECT min_rating FROM min_max) 
   OR ar.avg_rating = (SELECT max_rating FROM min_max)
ORDER BY ar.year, ar.title;"
echo " "

echo "4. Вычислить количество оценок и среднюю оценку, которую дали фильмам пользователи-мужчины в период с 2011 по 2014 год."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT 
    COUNT(*) AS 'Количество оценок',
    ROUND(AVG(r.rating), 2) AS 'Средняя оценка'
FROM ratings r
JOIN users u ON r.user_id = u.id
WHERE u.gender = 'M'
AND CAST(strftime('%Y', date(r.timestamp, 'unixepoch')) AS INTEGER) BETWEEN 2011 AND 2014;"
echo " "

echo "5. Составить список фильмов с указанием средней оценки и количества пользователей, которые их оценили. Полученный список отсортировать по году выпуска и названиям фильмов. В списке оставить первые 20 записей."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT 
    m.title AS 'Название фильма',
    m.year AS 'Год выпуска',
# Создать task4.bat с SQL-запросами для лабораторной работы 4
cat > task4.bat << 'EOF'
#!/bin/bash
chcp 65001

sqlite3 movies_rating.db < db_init.sql

echo "1. Найти все пары пользователей, оценивших один и тот же фильм. Устранить дубликаты, проверить отсутствие пар с самим собой. Для каждой пары должны быть указаны имена пользователей и название фильма, который они ценили. В списке оставить первые 100 записей."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT DISTINCT 
    u1.name AS user1, 
    u2.name AS user2, 
    m.title AS movie_title
FROM ratings r1
JOIN ratings r2 ON r1.movie_id = r2.movie_id AND r1.user_id < r2.user_id
JOIN users u1 ON r1.user_id = u1.id
JOIN users u2 ON r2.user_id = u2.id
JOIN movies m ON r1.movie_id = m.id
ORDER BY m.title, u1.name, u2.name
LIMIT 100;"
echo " "

echo "2. Найти 10 самых старых оценок от разных пользователей, вывести названия фильмов, имена пользователей, оценку, дату отзыва в формате ГГГГ-ММ-ДД."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT DISTINCT
    m.title AS movie_title,
    u.name AS user_name,
    r.rating,
    date(r.timestamp, 'unixepoch') AS review_date
FROM ratings r
JOIN movies m ON r.movie_id = m.id
JOIN users u ON r.user_id = u.id
ORDER BY r.timestamp ASC
LIMIT 10;"
echo " "

echo "3. Вывести в одном списке все фильмы с максимальным средним рейтингом и все фильмы с минимальным средним рейтингом. Общий список отсортировать по году выпуска и названию фильма. В зависимости от рейтинга в колонке 'Рекомендуем' для фильмов должно быть написано 'Да' или 'Нет'."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "WITH avg_ratings AS (
    SELECT 
        m.id,
        m.title,
        m.year,
        AVG(r.rating) AS avg_rating
    FROM movies m
    JOIN ratings r ON m.id = r.movie_id
    GROUP BY m.id, m.title, m.year
),
min_max AS (
    SELECT 
        MIN(avg_rating) AS min_rating,
        MAX(avg_rating) AS max_rating
    FROM avg_ratings
)
SELECT 
    ar.title AS 'Название фильма',
    ar.year AS 'Год выпуска',
    ROUND(ar.avg_rating, 2) AS 'Средний рейтинг',
    CASE 
        WHEN ar.avg_rating = (SELECT max_rating FROM min_max) THEN 'Да'
        ELSE 'Нет'
    END AS 'Рекомендуем'
FROM avg_ratings ar
WHERE ar.avg_rating = (SELECT min_rating FROM min_max) 
   OR ar.avg_rating = (SELECT max_rating FROM min_max)
ORDER BY ar.year, ar.title;"
echo " "

echo "4. Вычислить количество оценок и среднюю оценку, которую дали фильмам пользователи-мужчины в период с 2011 по 2014 год."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT 
    COUNT(*) AS 'Количество оценок',
    ROUND(AVG(r.rating), 2) AS 'Средняя оценка'
FROM ratings r
JOIN users u ON r.user_id = u.id
WHERE u.gender = 'M'
AND CAST(strftime('%Y', date(r.timestamp, 'unixepoch')) AS INTEGER) BETWEEN 2011 AND 2014;"
echo " "

echo "5. Составить список фильмов с указанием средней оценки и количества пользователей, которые их оценили. Полученный список отсортировать по году выпуска и названиям фильмов. В списке оставить первые 20 записей."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT 
    m.title AS 'Название фильма',
    m.year AS 'Год выпуска',
    ROUND(AVG(r.rating), 2) AS 'Средняя оценка',
    COUNT(DISTINCT r.user_id) AS 'Количество оценок'
FROM movies m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title, m.year
ORDER BY m.year, m.title
LIMIT 20;"
echo " "

echo "6. Определить самый распространенный жанр фильма и количество фильмов в этом жанре. Отдельную таблицу для жанров не использовать, жанры нужно извлекать из таблицы movies."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "WITH genre_counts AS (
    SELECT 
        trim(genre) AS single_genre,
        COUNT(*) AS genre_count
    FROM (
        SELECT 
            m.id,
            CASE 
                WHEN m.genres LIKE '%|%' THEN substr(m.genres, 1, instr(m.genres, '|') - 1)
                ELSE m.genres
            END AS genre
        FROM movies m
        UNION ALL
        SELECT 
            m.id,
            CASE 
                WHEN m.genres LIKE '%|%' THEN substr(m.genres, instr(m.genres, '|') + 1)
                ELSE NULL
            END AS genre
        FROM movies m
        WHERE m.genres LIKE '%|%'
    )
    WHERE genre IS NOT NULL AND trim(genre) != ''
    GROUP BY trim(genre)
)
SELECT 
    single_genre AS 'Самый распространенный жанр',
    genre_count AS 'Количество фильмов'
FROM genre_counts
ORDER BY genre_count DESC
LIMIT 1;"
echo " "

echo "7. Вывести список из 10 последних зарегистрированных пользователей в формате 'Фамилия Имя|Дата регистрации' (сначала фамилия, потом имя)."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT 
    substr(name, instr(name, ' ') + 1) || ' ' || substr(name, 1, instr(name, ' ') - 1) || '|' || register_date AS 'Фамилия Имя|Дата регистрации'
FROM users
ORDER BY register_date DESC
LIMIT 10;"
echo " "

echo "8. С помощью рекурсивного CTE определить, на какие дни недели приходился ваш день рождения в каждом году."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "WITH RECURSIVE years(year) AS (
    VALUES(2000)
    UNION ALL
    SELECT year + 1 FROM years WHERE year < 2024
)
SELECT 
    year AS 'Год',
    CASE 
        WHEN strftime('%w', year || '-01-01') = '0' THEN 'Воскресенье'
        WHEN strftime('%w', year || '-01-01') = '1' THEN 'Понедельник'
        WHEN strftime('%w', year || '-01-01') = '2' THEN 'Вторник'
        WHEN strftime('%w', year || '-01-01') = '3' THEN 'Среда'
        WHEN strftime('%w', year || '-01-01') = '4' THEN 'Четверг'
        WHEN strftime('%w', year || '-01-01') = '5' THEN 'Пятница'
        WHEN strftime('%w', year || '-01-01') = '6' THEN 'Суббота'
    END AS 'День недели дня рождения'
FROM years
ORDER BY year;"
