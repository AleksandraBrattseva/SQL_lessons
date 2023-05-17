USE lesson3;

SELECT *
FROM staff;

-- Создание процедуры, которая будет выводить статус человека по ЗП
-- ЗП от 0 до 49 999 - "Средн-ая ЗП"
-- ЗП от 50 000 до 69 999- "ЗП выше средней"
-- ЗП 70+ - "Высокая"
-- Номер сотрудника (id), статус по ЗП сохраняем в переменную 
SELECT @res_out := 5;
DROP PROCEDURE IF EXISTS get_status;
DELIMITER $$
CREATE PROCEDURE get_status
(
	IN staff_number INT, -- Номер сотрудника (id)
    OUT staff_status VARCHAR(45) -- Запись статуса конкретного человека
)
BEGIN
	DECLARE salary_limit DOUBLE; -- NULL
    SELECT salary INTO salary_limit
    FROM staff
    WHERE staff_number = id;
    SELECT staff_number, salary_limit; -- При id = 4, зп = 70 000 (у меня)
    IF salary_limit BETWEEN 0 AND 49999 THEN
		SET staff_status = "Средн-ая ЗП";
	ELSEIF salary_limit BETWEEN 50000 AND 69999 THEN
		SET staff_status = "ЗП выше средней";
	ELSEIF salary_limit >= 70000 THEN
		SET staff_status =  "Высокая";
	END IF;
END $$
-- Вызов процедуры
CALL get_status(4, @res_out);
SELECT @res_out;

-- Функция воспринимает 2 параметра: текущую дату и время и дату рождения человека
SELECT NOW(); -- DATETIME "YYYY-MM-DD HH:MM:SS" => 2023-04-28 20:41:28
DROP FUNCTION IF EXISTS get_age;
CREATE FUNCTION get_age
(
	date_bith DATE, -- "YYYY-MM-DD" = "2001-04-28"
    current_t DATETIME -- "YYYY-MM-DD HH:MM:SS" => 2023-04-28 20:41:28
)
RETURNS INT
DETERMINISTIC
RETURN (YEAR(current_t) - YEAR(date_bith)); -- 2023 - 2001 = 22 

SELECT get_age("2001-04-28", NOW()) AS "Возраст человека"; 

-- Реализовать цикл, который печатает цифры от числа N до 1 включительно
-- N = 5: "5, 4, 3, 2, 1"
DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER $$
CREATE PROCEDURE print_numbers
(
	IN inp_number INT -- N
)
BEGIN
	DECLARE n INT; -- NULL, но позже n = inp_number
    DECLARE result VARCHAR(45) DEFAULT "";
    SET n = inp_number;
    
    REPEAT
		SET result = CONCAT(result, n, " ");
        SET n = n - 1;
		UNTIL n <= 0 -- Условие выхода из цикла: n - отрицательное или равное 0 число    
	END REPEAT;
    SELECT result;
END $$
 
-- Вызов процедуры
CALL print_numbers(7);
ъ
DROP TABLE IF EXISTS bankaccounts;
CREATE TABLE bankaccounts
(
	accountno varchar(20) PRIMARY KEY NOT NULL,
    funds decimal(8,2)
);


INSERT INTO bankaccounts VALUES("ACC1", 1000);
INSERT INTO bankaccounts VALUES("ACC2", 1000);
SELECT * FROM bankaccounts;
-- Изменим баланс на аккаунтах: списать со счета ACC1 500 рублей и перевести их на счет ACC2

START TRANSACTION; 
	SELECT "На счет ACC1 имеется блокировка";
    SAVEPOINT error_1;
    
	UPDATE bankaccounts SET funds=funds-500 WHERE accountno='ACC1'; 
    SELECT "Получатель не имеет карту нужного банка ";
    SAVEPOINT error_2; -- Получатель не имеет карту нужного банка 
	UPDATE bankaccounts SET funds=funds+500 WHERE accountno='ACC2'; 
ROLLBACK TO SAVEPOINT error_1; -- COMMIT = Сохранение результатов транзакции 

SELECT * FROM bankaccounts;