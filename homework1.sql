USE lesson1;

-- 1.Создайте таблицу с мобильными телефонами и заполните БД данными
CREATE TABLE IF NOT EXISTS mobil_phone 
(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    product_name VARCHAR(45),
    manufacturer VARCHAR(45), 
    product_count INT,
    price INT
); 

INSERT mobil_phone (product_name, manufacturer, product_count, price)
VALUES 
	("iPhone X", "Apple", 3, 76000), 
	("iPhone 8", "Apple", 2, 51000), 
    ("Galaxy S9", "Samsung", 2, 56000), 
    ("Galaxy S8", "Samsung",1, 41000), 
    ("P20 Pro", "Huawei", 5, 36000); 
  
SELECT * 
FROM mobil_phone;  

-- 2.Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT product_name, manufacturer, price
FROM mobil_phone
WHERE product_count > 2;
 
 -- 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT *
FROM mobil_phone
WHERE manufacturer = "Samsung";    

-- 4.Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000
SELECT * 
FROM mobil_phone
WHERE price*product_count BETWEEN 100000 AND 145000; 

-- 4.*** С помощью регулярных выражений найти (можно использовать операторы “LIKE”, “RLIKE” для 4.3 ):
-- 4.1. Товары, в которых есть упоминание "Iphone"
SELECT *
FROM mobil_phone
WHERE product_name LIKE "%iphone%";

-- 4.2. "Galaxy"
SELECT *
FROM mobil_phone
WHERE product_name LIKE "%galaxy%";

-- 4.3. Товары, в которых есть ЦИФРЫ
SELECT *
FROM mobil_phone
WHERE product_name RLIKE "[0-9]";

-- 4.4.  Товары, в которых есть ЦИФРА "8"
SELECT *
FROM mobil_phone
WHERE product_name LIKE "%8%";



 

    
    
    