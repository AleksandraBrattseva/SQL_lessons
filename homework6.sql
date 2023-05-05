-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP DATABASE IF EXISTS lesson6;
CREATE DATABASE IF NOT EXISTS lesson6;
USE lesson6;

DELIMITER // 
CREATE FUNCTION sec_parser(sec INT )
RETURNS VARCHAR (50)
DETERMINISTIC
BEGIN
	DECLARE res VARCHAR(50) DEFAULT "";
	DECLARE min_ INT DEFAULT 0;
	DECLARE hour_ INT DEFAULT 0;
	DECLARE day_ INT DEFAULT 0;
	SET day_ = sec / (3600 * 24);
	SET hour_ = (sec - day_ * 3600 * 24) / 3600;
	SET min_ = (sec - (day_ * 3600 * 24) - (hour_ * 3600)) / 60;
	SET sec = sec % 60;
	SET res = CONCAT(res, day_, " days, ", hour_, " hours, ", min_, " minutes, ", sec, " seconds.");
RETURN (res);
END//
SELECT sec_parser(123456) AS "Результат перерасчета";


-- Выведите только четные числа от 1 до 10.
-- Пример: 2,4,6,8,10


DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER //
CREATE PROCEDURE print_numbers
(
	IN inp_number INT 
)
BEGIN
	DECLARE i INT;
    DECLARE n VARCHAR(5);
    DECLARE result VARCHAR(145) DEFAULT "";
    SET i = 1;
    SET n = 1;
    WHILE i <= inp_number DO
		SET n = IF(i%2 = 0, i, ' ');        
        SET result = CONCAT(result, n );        
        SET i = i + 1;
                 
	END WHILE;
    SELECT result;
END; //

CALL print_numbers(10); 