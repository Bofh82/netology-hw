# Домашнее задание к занятию «Работа с данными (DDL/DML)» - Родионов Сергей
## Задание 1
1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

2. Создайте учётную запись sys_temp. 
```sql
CREATE USER 'sys_temp'@'localhost' IDENTIFIED BY 'password';
```
3. Выполните запрос на получение списка пользователей в базе данных. (скриншот)
```sql
SELECT user, host FROM mysql.user;
```
![](\files\12\12-02\12-02-01-1.png)

4. Дайте все права для пользователя sys_temp. 
```sql
GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'localhost';
FLUSH PRIVILEGES;
```
5. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)
```sql
SHOW GRANTS FOR 'sys_temp'@'localhost';
```
![](files\12\12-02\12-02-01-2.png)

6. Переподключитесь к базе данных от имени sys_temp.

Для смены типа аутентификации с sha2 используйте запрос: 
```sql
ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
7. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

8. Восстановите дамп в базу данных.

9. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)
```sql
USE sakila;
SHOW TABLES;
```
![](files\12\12-02\12-02-01-3.png)

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*

## Задание 2
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот/текст)
```
Название таблицы | Название первичного ключа
customer         | customer_id
```
```sql
SELECT 
    t.TABLE_NAME AS 'Название таблицы',
    IFNULL(
        (SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION SEPARATOR ', ')
         FROM INFORMATION_SCHEMA.COLUMNS c
         WHERE c.TABLE_SCHEMA = t.TABLE_SCHEMA
           AND c.TABLE_NAME = t.TABLE_NAME
           AND c.COLUMN_KEY = 'PRI'),
        'Нет первичного ключа (VIEW)'
    ) AS 'Название первичного ключа'
FROM 
    INFORMATION_SCHEMA.TABLES t
WHERE 
    t.TABLE_SCHEMA = 'sakila'
ORDER BY 
    t.TABLE_NAME;
```
Результат запроса:
![](files\12\12-02\12-02-02-1.png)
