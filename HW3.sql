CREATE DATABASE IF NOT EXISTS hw3;

USE hw3;

-- 0. Creating new tables 'SALESPEOPLE', 'CUSTOMERS', ORDERS and filling them
CREATE TABLE IF NOT EXISTS salespeople (
	snum INT PRIMARY KEY NOT NULL UNIQUE, 
	sname VARCHAR(45) NOT NULL, 
	city VARCHAR(45) NOT NULL, 
	comm DECIMAL(3, 2) NOT NULL
);

INSERT INTO 
	salespeople(snum, sname, city, comm) 
VALUES 
	(1001, "Peel", "London", 0.12), 
	(1002, "Serres", "San Jose", 0.13), 
	(1004, "Motika", "London", 0.11), 
	(1007, "Rifkin", "Barcelona", 0.15), 
	(1003, "Axelrod", "New York", 0.10);
  
CREATE TABLE IF NOT EXISTS customers (
	cnum INT PRIMARY KEY NOT NULL UNIQUE, 
	cname VARCHAR(45) NOT NULL, 
	city VARCHAR(45) NOT NULL, 
	rating INT, 
	snum INT, 
	FOREIGN KEY (snum) REFERENCES salespeople(snum)
);

INSERT INTO 
	customers(cnum, cname, city, rating, snum) 
VALUES 
	(2001, "Hoffman", "London", 100, 1001), 
	(2002, "Giovanni", "Rome", 200, 1003), 
	(2003, "Liu", "SanJose", 200, 1002), 
	(2004, "Grass", "Berlin", 300, 1002), 
	(2006, "Clemens", "London", 100, 1001), 
	(2008, "Cisneros", "SanJose", 300, 1007), 
	(2007, "Pereira", "Rome", 100, 1004);
  
CREATE TABLE IF NOT EXISTS orders (
	onum INT PRIMARY KEY NOT NULL UNIQUE, 
	amt DECIMAL(10, 2), 
	odate VARCHAR(45), 
	cnum INT, 
		FOREIGN KEY (cnum) REFERENCES customers(cnum), 
	snum INT, 
		FOREIGN KEY (snum) REFERENCES salespeople(snum)
);

INSERT INTO 
	orders(onum, amt, odate, cnum, snum) 
VALUES 
	(3001, 18.69, '10/03/1990', 2008, 1007), 
	(3003, 767.19, '10/03/1990', 2001, 1001), 
	(3002, 1900.10, '10/03/1990', 2007, 1004), 
	(3005, 5160.45, '10/03/1990', 2003, 1002), 
	(3006, 1098.16, '10/03/1990', 2008, 1007), 
	(3009, 1713.23, '10/04/1990', 2002, 1003), 
	(3007, 75.75, '10/04/1990', 2004, 1002), 
	(3008, 4723.00, '10/05/1990', 2006, 1001), 
	(3010, 1309.95, '10/06/1990', 2004, 1002), 
	(3011, 9891.88, '10/06/1990', 2006, 1001);
  
  
-- 1. Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm. (к первой или второй таблице, используя SELECT) 
SELECT 
	city, 
	sname, 
	snum, 
	comm 
FROM 
	salespeople;


-- 2. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе SanJose. (“заказчики”)
SELECT 
	cname, 
	rating 
FROM 
	customers 
WHERE 
	city = 'SanJose';
  

-- 3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”)
SELECT 
	DISTINCT snum 
FROM 
	orders;
  

-- 4. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. Используется оператор "LIKE": (“заказчики”)
SELECT 
	* 
FROM 
	customers 
WHERE 
	cname LIKE "G%";
  

-- 5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt” - сумма)
SELECT 
	* 
FROM 
	orders 
WHERE 
	amt > 1000;
  

-- 6. Напишите запрос который выбрал бы наименьшую сумму заказа. (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
SELECT 
	MIN(amt) AS "Наименьшая сумма заказа" 
FROM 
	orders;
  

-- 7. Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они находятся не в Риме.
SELECT 
	* 
FROM 
	customers 
WHERE 
	rating > 100 
	AND city != 'Rome';
  

-- 8.0. Creating new table 'staff' and filling it
CREATE TABLE IF NOT EXISTS staff (
	id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT, 
	name VARCHAR(45) NOT NULL, 
	surname VARCHAR(45) NOT NULL, 
	specialty VARCHAR(45) NOT NULL, 
	seniority INT UNSIGNED NOT NULL, 
	salary INT UNSIGNED NOT NULL, 
	age TINYINT NOT NULL
);

INSERT INTO 
	staff (name, surname, specialty, seniority, salary, age) 
VALUES 
	('Вася', 'Васькин', 'начальник', 40, 100000, 60), 
	('Петя', 'Петькин', 'начальник', 8, 70000, 30), 
	('Катя', 'Каткина', 'инженер', 2, 70000, 25), 
	('Саша', 'Сашкин', 'инженер', 12, 50000, 35), 
	('Иван', 'Иванов', 'рабочий', 40, 30000, 59), 
	('Петр', 'Петров', 'рабочий', 20, 25000, 40), 
	('Сидор', 'Сидоров', 'рабочий', 10, 20000, 35), 
	('Антон', 'Антонов', 'рабочий', 8, 19000, 28), 
	('Юра', 'Юркин', 'рабочий', 5, 15000, 25), 
	('Максим', 'Воронин', 'рабочий', 2, 11000, 22), 
	('Юра', 'Галкин', 'рабочий', 3, 12000, 24), 
	('Люся', 'Люськина', 'уборщик', 10, 10000, 49);
  

-- 8.1.1. Отсортируйте поле “зарплата” в порядке убывания
SELECT 
	* 
FROM 
	staff 
ORDER BY 
	salary DESC;
  

-- 8.1.2. Отсортируйте поле “зарплата” в порядке возрастания
SELECT 
	* 
FROM 
	staff 
ORDER BY 
	salary;
  

-- 8.2. Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой
SELECT 
	salary
FROM 
	(SELECT
		salary 
	FROM 
		staff 
	GROUP BY 
		salary 
	ORDER BY 
		salary DESC 
	LIMIT 5) top
ORDER BY 
	salary ASC;
  

-- 8.3. Выполните группировку всех сотрудников по специальности, суммарная зарплата которых превышает 100000
SELECT 
	GROUP_CONCAT(CONCAT (name, ' ', surname) SEPARATOR '; ') AS workers_group, 
	specialty, 
	SUM(salary) AS group_salary 
FROM 
	staff 
GROUP BY 
	specialty 
HAVING 
	group_salary > 100000;