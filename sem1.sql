# Комментарий 
-- После "--" ставится обязательно пробел
/*
	Многострочный
    комментарий
	Стили:
    PascalCase: PrintArray
    camelCase: firstNumber
    kebab-case" first-number
    
    В SQL лучше всего использовать:
    snake_case: first_number (+)
*/

-- 1. Создание БД
DROP DATABASE IF EXISTS lesson1; -- Удалить БД lesson1, если она существует
CREATE DATABASE IF NOT EXISTS lesson1; -- Создаем БД lesson1, если до этого такой БД не существовло

-- 2. Выбираем активную БД
USE lesson1;

-- 3. Создание таблицы со студентами
CREATE TABLE IF NOT EXISTS student 
(
	-- Столбцы таблицы
    -- Формула столбца: имя_столбца тип_данных ограничения
    id INT PRIMARY KEY AUTO_INCREMENT, -- PK = NOT NULL  , UNIQUE
    name_student VARCHAR(45),
    email VARCHAR(45), -- Строчка на 45 символов
    phone_number VARCHAR(20) -- У последнего столбца запятая не ставится
);

-- 4. Заполнение таблицы значениями
-- INSERT INTO table_name(столбец1, столбец2) VALUES (значение1,значение2)
INSERT student (name_student, email, phone_number)
VALUES 
	("Антон", "ant@gmail.com", "+7-999-888-77-66"), -- id = 1
	("Александр", "alex@gmail.com", "+7-999-888-66-55"), -- id = 2
    ("Андрей", "andrey@gmail.com", "+7-999-888-66-55"), -- id = 3
    ("Артем", "art@gmail.com", "+7-888-888-66-55"), -- id = 4
    ("Виктор", "vic@gmail.com", "+7-978-888-66-55"), -- id = 5
    ("Владимир", "vlad@gmail.com", "+7-888-888-66-55"); -- id = 6

-- 5. Вывести содержимое таблицы student
SELECT * # "дурный" тон 
FROM student;

-- 6. Вывести имя студента и его почту
SELECT name_student, email
FROM student;

-- 7. Вывести инфо о студенте (почту и имя) для Антона
SELECT name_student, email
FROM student
WHERE name_student = "Антон";

-- 8. Вывести инфо о студентах (почту и имя), исключив Антона
SELECT name_student, email
FROM student
WHERE name_student != "Антон"; -- <> и != одно и то же - проверка на неравенство

-- 9. Выведем информацию о студентах, имена которых начинаются с буквы "А", % много символов, либо _ - только один символ
SELECT name_student, email
FROM student
WHERE name_student LIKE "А%";

-- 10. Студенты, имена которых начинаются на "А" и имеют букву "р" на любой позиции после буквы "А"
SELECT name_student, email
FROM student
WHERE name_student LIKE "А%р%";


