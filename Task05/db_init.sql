-- Лабораторная работа 5: Нормализация БД и поддержка логической целостности
-- Автор: Ян Моисеев

-- Удаление таблиц в правильном порядке (из-за внешних ключей)
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS movie_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS occupations;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;

-- 1. Таблица occupations (справочник профессий)
CREATE TABLE occupations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- 2. Таблица users (пользователи)
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    gender TEXT CHECK(gender IN ('M', 'F')) NOT NULL,
    register_date TEXT DEFAULT (datetime('now', 'localtime')),
    occupation_id INTEGER,
    FOREIGN KEY (occupation_id) REFERENCES occupations(id) ON DELETE SET NULL
);

-- 3. Таблица movies (фильмы)
CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    year INTEGER CHECK(year >= 1888 AND year <= CAST(strftime('%Y', 'now') AS INTEGER)),
    created_at TEXT DEFAULT (datetime('now', 'localtime'))
);

-- 4. Таблица genres (справочник жанров)
CREATE TABLE genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- 5. Таблица movie_genres (связь фильмов и жанров, многие-ко-многим)
CREATE TABLE movie_genres (
    movie_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- 6. Таблица ratings (рейтинги фильмов)
CREATE TABLE ratings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    rating REAL CHECK(rating >= 0 AND rating <= 5) NOT NULL,
    timestamp INTEGER DEFAULT (CAST(strftime('%s', 'now') AS INTEGER)),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE RESTRICT
);

-- 7. Таблица tags (теги фильмов)
CREATE TABLE tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    tag TEXT NOT NULL,
    timestamp INTEGER DEFAULT (CAST(strftime('%s', 'now') AS INTEGER)),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- Заполнение справочника профессий
INSERT INTO occupations (name) VALUES 
('студент'),
('инженер'),
('преподаватель'),
('врач'),
('программист'),
('дизайнер'),
('менеджер'),
('бухгалтер');

-- Заполнение справочника жанров
INSERT INTO genres (name) VALUES 
('Боевик'),
('Драма'),
('Комедия'),
('Триллер'),
('Ужасы'),
('Фантастика'),
('Мелодрама'),
('Приключения'),
('Детектив'),
('Фэнтези');

-- Вставка тестовых данных для проверки
INSERT INTO users (name, email, gender, occupation_id) VALUES 
('Тестовый Пользователь', 'test@example.com', 'M', 
 (SELECT id FROM occupations WHERE name = 'студент'));

INSERT INTO movies (title, year) VALUES 
('Тестовый Фильм', 2020);

INSERT INTO movie_genres (movie_id, genre_id) VALUES
(1, (SELECT id FROM genres WHERE name = 'Драма'));

-- Создание индексов для оптимизации запросов
CREATE INDEX idx_users_name ON users(name);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_movies_title ON movies(title);
CREATE INDEX idx_movies_year ON movies(year);
CREATE INDEX idx_ratings_user_id ON ratings(user_id);
CREATE INDEX idx_ratings_movie_id ON ratings(movie_id);
CREATE INDEX idx_ratings_rating ON ratings(rating);
CREATE INDEX idx_tags_user_id ON tags(user_id);
CREATE INDEX idx_tags_movie_id ON tags(movie_id);
CREATE INDEX idx_movie_genres_movie_id ON movie_genres(movie_id);
CREATE INDEX idx_movie_genres_genre_id ON movie_genres(genre_id);

-- Проверочные ограничения
CREATE TRIGGER check_unique_email 
BEFORE INSERT ON users
BEGIN
    SELECT CASE
        WHEN EXISTS (SELECT 1 FROM users WHERE email = NEW.email) THEN
            RAISE(ABORT, 'Email уже существует')
    END;
END;

CREATE TRIGGER check_movie_deletion
BEFORE DELETE ON movies
BEGIN
    SELECT CASE
        WHEN EXISTS (SELECT 1 FROM ratings WHERE movie_id = OLD.id) THEN
            RAISE(ABORT, 'Нельзя удалить фильм, у которого есть рейтинги')
    END;
END;
