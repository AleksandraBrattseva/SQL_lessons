-- 1. Создание БД
CREATE DATABASE IF NOT EXISTS lesson3; -- Создаем БД, если она не существует 

-- 2. Выбор БД
USE lesson3;

-- 3. Создание таблицы с персоналом
DROP TABLE IF EXISTS staff; -- Удаляю таблицу, если она существует
CREATE TABLE staff
(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    firstname VARCHAR(45),
    lastname VARCHAR(45),
    post VARCHAR(45),
    seniority INT, 
    salary DECIMAL (8,2), -- д-н: от -999 999 до 999 999
    age INT
);

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
 
SELECT *
FROM staff;

-- ORDER BY - сортировка, GROUP BY - группировка
SELECT salary, id
FROM staff
ORDER BY salary; -- ASC (исходный параметр) - по воз-ю 

SELECT salary, id
FROM staff
ORDER BY salary DESC; -- DESC - по убыванию

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
	('Петр', 'Петров', 'Начальник', 8, 70000, 30);

-- Сортировка по нескольким полям (по убыванию в буквах: Я->А)
SELECT lastname, firstname, salary
FROM staff
ORDER BY firstname DESC, lastname DESC, salary DESC;
-- если есть одноименцы, то срабатывает второй фильтр. Если нет, то не срабатывает. Далее работает третий фильтр

-- Ограничение на вывод строк 
SELECT lastname, firstname, salary
FROM staff
ORDER BY firstname DESC, lastname DESC, salary DESC
LIMIT 5; -- Выведет первые 5 строк в отсортированном множестве

SELECT lastname, firstname, salary
FROM staff
ORDER BY firstname DESC, lastname DESC, salary DESC
LIMIT 2, 3; -- пропускаем 2 строки и выводим 3 строки

SELECT lastname, firstname, id
FROM staff
ORDER BY id DESC
LIMIT 3, 2; -- по id сортируем по убыванию, пропускаем 3 строки и выводим след 2 строки

SELECT lastname, firstname, id
FROM staff
ORDER BY id DESC
LIMIT 2 OFFSET 3; -- по id сортируем по убыванию, пропускаем 3 строки и выводим след 2 строки

-- Агрегатные функции 
-- Для каждой должности получим:
-- среднюю ЗП, кол-во сотрудников, суммарную ЗП, разницу между макс и мин ЗП
SELECT 
	post AS "Должность",
    ROUND(AVG(salary), 2) AS "Средняя ЗП по отделу",
    COUNT(salary) AS "Количество сотрудников по отделу",
    SUM(salary) AS "Сумарная ЗП по отделу",
    MAX(salary) AS "Макс ЗП по отделу",
	MIN(salary) AS "Мин ЗП по отделу",
	MAX(salary) - MIN(salary)  AS "Разница между макс и мин ЗП"
FROM staff
WHERE post != "начальник" -- до формирования групп
GROUP BY post
HAVING AVG(salary) > 25000 -- Условие накладывается на сформированные группы
ORDER BY post DESC;


DROP TABLE IF EXISTS activity_staff;
CREATE TABLE activity_staff (
 id INT AUTO_INCREMENT PRIMARY KEY, 
 staff_id INT NOT NULL,
 date_activity DATE,
 count_pages INT,
 FOREIGN KEY (staff_id) REFERENCES staff (id)
);

-- Наполнение данными
INSERT INTO activity_staff (staff_id, date_activity, count_pages)
VALUES
(1, '2022-01-01', 250),
(2, '2022-01-01', 220),
(3, '2022-01-01', 170),
(1, '2022-01-02', 100),
(2, '2022-01-02', 220),
(3, '2022-01-02', 300),
(7, '2022-01-02', 350),
(1, '2022-01-03', 168),
(2, '2022-01-03', 62),
(3, '2022-01-03', 84);

-- Неявное соединение таблиц 
SELECT 
	s.id, 
    a_s.staff_id, 
    s.firstname,
    a_s.count_pages,
    a_s.date_activity
FROM staff s,  activity_staff a_s -- staff = s, a_s = activity_staff
WHERE s.id =  a_s.staff_id
ORDER BY s.id;

RENAME TABLE staff TO people;



