# Домашнее задание к занятию «Базы данных» - Родионов Сергей

## Легенда
Заказчик передал вам [файл в формате Excel](img/12/12-01/hw-12-1.xlsx), в котором сформирован отчёт.

На основе этого отчёта нужно выполнить следующие задания.

---

## Задание 1

Опишите не менее семи таблиц, из которых состоит база данных:

* какие данные хранятся в этих таблицах;
* какой тип данных у столбцов в этих таблицах, если данные хранятся в PostgreSQL.

Приведите решение к следующему виду:

Сотрудники (
* идентификатор, первичный ключ, serial,
* фамилия varchar(50),
* ...
* идентификатор структурного подразделения, внешний ключ, integer).

---
### Описание таблиц базы данных

1. **Сотрудники**  
   - **Описание**: Хранит информацию о сотрудниках компании.  
   - **Структура**:  
     - `идентификатор` (первичный ключ, `serial`),  
     - `фамилия` (`varchar(50)`),  
     - `имя` (`varchar(50)`),  
     - `отчество` (`varchar(50)`),  
     - `оклад` (`numeric(10, 2)`),  
     - `идентификатор_должности` (внешний ключ, `integer`),  
     - `идентификатор_подразделения` (внешний ключ, `integer`),  
     - `дата_найма` (`date`),  
     - `идентификатор_проекта` (внешний ключ, `integer`).  

2. **Должности**  
   - **Описание**: Содержит наименования должностей сотрудников.  
   - **Структура**:  
     - `идентификатор` (первичный ключ, `serial`),  
     - `наименование_должности` (`varchar(100)`).  

3. **Типы подразделений**  
   - **Описание**: Хранит типы подразделений (например, "Отдел", "Группа", "Департамент").  
   - **Структура**:  
     - `идентификатор` (первичный ключ, `serial`),  
     - `тип_подразделения` (`varchar(50)`).  

4. **Структурные подразделения**  
   - **Описание**: Содержит информацию о структурных подразделениях компании.  
   - **Структура**:  
     - `идентификатор` (первичный ключ, `serial`),  
     - `наименование_подразделения` (`varchar(100)`),  
     - `идентификатор_типа_подразделения` (внешний ключ, `integer`),  
     - `идентификатор_филиала` (внешний ключ, `integer`).  

5. **Филиалы**  
   - **Описание**: Хранит данные о филиалах компании.  
   - **Структура**:  
     - `идентификатор` (первичный ключ, `serial`),  
     - `адрес_филиала` (`varchar(200)`),  
     - `регион` (`varchar(100)`),  
     - `город` (`varchar(50)`).  

6. **Проекты**  
   - **Описание**: Содержит информацию о проектах, на которые назначены сотрудники.  
   - **Структура**:  
     - `идентификатор` (первичный ключ, `serial`),  
     - `наименование_проекта` (`varchar(200)`).  

7. **Даты найма**  
   - **Описание**: Хранит даты найма сотрудников в формате, пригодном для обработки.  
   - **Структура**:  
     - `идентификатор` (первичный ключ, `serial`),  
     - `дата_найма` (`date`),  
     - `идентификатор_сотрудника` (внешний ключ, `integer`).  

---
