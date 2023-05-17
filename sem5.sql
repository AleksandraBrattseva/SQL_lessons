USE lesson3;

SELECT * FROM staff;

-- Ранжирование 
-- Вывести список всех сотрудников, отсортировав по зарплате (от макс - к мин)
-- и указать мсто сотрудника в рейтинге по ЗП 
SELECT
    post,
    CONCAT(firstname, " ", lastname) AS "Фамилия и имя",
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS `DENSE_RANK`,
    RANK() OVER(ORDER BY salary DESC) AS `RANK`
    -- буква ё на англ. раскладке, `имя_столбца`
FROM staff;

-- Вывести список всех сотрудников, отсортировав по зарплате (от макс - к мин)
-- и указать место сотрудника в рейтинге по ЗП для каждой специальности 
SELECT
    post,
    CONCAT(firstname, " ", lastname) AS "Фамилия и имя",
    salary,
    DENSE_RANK() OVER (PARTITION BY post ORDER BY salary DESC) AS `rank`
FROM staff;

-- Выведем список самых высокооплачиваемых сотрудников 
-- rank = 1(Если ранг равен 1, то ЗП внутри должности максимальна)

SELECT     
	post,
    salary, 	-- rank_salary: post,CONCAT(firstname, " ", lastname) AS "Фамилия и имя",salary, rank
    `rank`
FROM (
SELECT
    post,
    salary,
    DENSE_RANK() OVER (PARTITION BY post ORDER BY SUM(salary) DESC) AS `rank`
FROM staff) rank_salary -- вернул таблицу с рангами по должностям и сортировка по убыванию
WHERE `rank` = 1;

-- Агрегация 
-- Вывести список всех сотрудников в рамках должности и посчитаем
-- суммарная зп для сп-ти  (1)
-- процентное соотношение каждой ЗП от общей суммы по должности  (2)
-- среднюю зп для сп-ти  (3)
-- процентное соотношение каждой ЗП к средней ЗП по должности  (4)
SELECT
	post,
    salary,
    SUM(salary) OVER w AS sum_salary, -- 1
    ROUND(salary * 100 / SUM(salary) OVER w, 3) AS "Процент от сумм зп", -- 2
    ROUND(AVG(salary) OVER w, 3) AS "Средняя зп по должности", -- 3
	ROUND(salary * 100 / AVG(salary) OVER w, 3) AS "Процент от средней зп" -- 4
FROM staff
WINDOW w AS (PARTITION BY post); -- w = (PARTITION BY post)


SELECT
	post,
    salary,
    SUM(salary) OVER (PARTITION BY post) AS sum_salary, -- 1
    ROUND(salary * 100 / SUM(salary) OVER (PARTITION BY post), 3) AS "Процент от сумм зп", -- 2
    ROUND(AVG(salary) OVER (PARTITION BY post), 3) AS "Средняя зп по должности", -- 3
	ROUND(salary * 100 / AVG(salary) OVER w, 3) AS "Процент от средней зп" -- 4
FROM staff;
    
-- Представления 
-- назв спец-тов и их количество
SELECT
	post, 
    COUNT(*)
FROM staff
GROUP BY post
ORDER BY COUNT(*); -- Сортировка по во-ю (от меньшего - к большему)


CREATE OR REPLACE VIEW count_staff AS
SELECT
	post, 
    COUNT(*)
FROM staff
WHERE post != "Уборщик"
GROUP BY post
ORDER BY COUNT(*); -- Сортировка по во-ю (от меньшего - к большему)

INSERT staff (post)
VALUES ("Тест");

SELECT * -- count_staff: 	post, COUNT(*)
FROM count_staff;

SHOW FULL TABLES 
WHERE Table_type = 'VIEW'; -- Просмотр списка представлений в БД lesson3

SHOW FULL TABLES 
WHERE Table_type = 'BASE TABLE'; -- Просмотр списка таблиц в БД lesson3
