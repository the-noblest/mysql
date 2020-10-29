-- 1.1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
created_at DATETIME,  
updated_at DATETIME
);

INSERT users VALUES (NOW(), NOW());
SELECT * FROM users;


-- 1.2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

DROP TABLE IF EXISTS users1;
CREATE TABLE users1 (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
created_at VARCHAR(20),
updated_at VARCHAR(20)
);

INSERT users1 (created_at, updated_at) VALUES
('2020-10-29 14:20', '2020-10-29 14:20'),
('2020-10-29 14:21', '2020-10-29 14:21'),
('2020-10-29 14:22', '2020-10-29 14:22'),
('2020-10-29 14:23', '2020-10-29 14:23');
DESC users1;
SELECT * FROM users1;

ALTER TABLE users1 MODIFY COLUMN created_at DATETIME NOT NULL;
ALTER TABLE users1 MODIFY COLUMN updated_at DATETIME NOT NULL;
DESC users1;
SELECT * FROM users1;


-- 1.3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
value INTEGER
);

INSERT storehouses_products (value) VALUES (0), (2500), (0), (30), (500), (1);
SELECT * FROM storehouses_products ORDER BY value = 0, value;


-- 1.5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
  
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


DROP TABLE IF EXISTS users2;
CREATE TABLE users2 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users2 (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

-- 1.4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august).
SELECT * FROM users2 WHERE MONTHNAME(birthday_at) IN ('May', 'August');

-- 2.1. Подсчитайте средний возраст пользователей в таблице users.
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) FROM users2;

-- 2.2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT DAYNAME(birthday_at) AS dayname, COUNT(birthday_at) AS count FROM users2 GROUP BY (dayname);


-- 2.3. Подсчитайте произведение чисел в столбце таблицы.

DROP TABLE IF EXISTS test_values;
CREATE TABLE test_values (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
value INTEGER
);

INSERT test_values (value) VALUES (1), (2), (3), (4), (5);
SELECT ROUND(EXP(SUM(LN(value)))) FROM test_values;