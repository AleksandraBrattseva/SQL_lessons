USE lesson4;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT INTO cars
VALUES
	(1, 'Audi', 52642),
    (2, 'Mercedes', 57127 ),
    (3, 'Skoda', 9000 ),
    (4, 'Volvo', 29000),
	(5, 'Bentley', 350000),
    (6, 'Citroen', 21000 ), 
    (7, 'Hummer', 41400), 
    (8, 'Volkswagen', 21600);

SELECT * FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE OR REPLACE VIEW view_cars AS
SELECT name, cost
FROM cars
WHERE cost < 25000;

SELECT * FROM view_cars;

-- 2. Изменить в существующем представлении порог для стоимости: 
-- пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

ALTER VIEW view_cars AS
SELECT name, cost
FROM cars
WHERE cost < 30000;

SELECT * FROM view_cars;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE OR REPLACE VIEW some_cars AS
SELECT *
FROM cars
WHERE name IN ('Skoda', 'Audi');

SELECT * FROM some_cars;

-- 4. Добавьте новый столбец под названием «время до следующей станции»

CREATE TABLE train
(
	train_id INT,
    station VARCHAR(20),
    station_time TIME
);

INSERT train
VALUES
	(110, "San Francisco", "10:00:00"),
    (110, "Redwood City", "10:54:00"),
    (110, "Palo Alto", "11:02:00"),
    (110, "San Jose", "12:35:00"),
	(120, "San Francisco", "11:00:00"),
    (120, "Palo Alto", "12:49:00"), 
    (120, "San Jose", "13:30:00");
 
SELECT * FROM train; 

SELECT *,
CASE
	WHEN TIMEDIFF(LEAD(station_time) OVER(), station_time) < 0
		THEN NULL
	ELSE TIMEDIFF(LEAD(station_time) OVER(), station_time)
END AS 'time_to_next_station'
FROM train;