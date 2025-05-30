# "Базы данных, их типы" - `Родионов Сергей`

## Задание 1. СУБД

### Кейс
Крупная строительная компания, которая также занимается проектированием и девелопментом, решила создать 
правильную архитектуру для работы с данными. Ниже представлены задачи, которые необходимо решить для
каждой предметной области. 

Какие типы СУБД, на ваш взгляд, лучше всего подойдут для решения этих задач и почему? 
 
---

#### **1.1. Бюджетирование проектов, финансовые отчёты и прогнозирование рисков**
**Тип СУБД:** Реляционная СУБД (например, **PostgreSQL**, **MySQL**, **Microsoft SQL Server**).

**Почему:**
- Реляционные СУБД обеспечивают чёткую структуру данных, что важно для финансовых отчётов и бюджетирования.
- Они поддерживают ACID-транзакции, что гарантирует целостность данных.
- Подходят для сложных запросов, агрегации данных и аналитики.

**1.1.* Ускорение хеширования:**
- Для ускорения хеширования можно использовать специализированные API или библиотеки, такие как **Redis** (для кэширования) или **FastAPI** (для быстрой обработки запросов).
- Также можно использовать встроенные функции СУБД (например, индексацию или материализованные представления) для оптимизации запросов.

---

#### **1.2. Лендинги и CRM**
**Тип СУБД:**
- Для лендингов: **NoSQL СУБД** (например, **MongoDB** или **Firebase**).
- Для CRM: **Реляционная СУБД** (например, **PostgreSQL** или **Microsoft SQL Server**).

**Почему:**
- Лендинги требуют гибкости и быстрой обработки данных, что хорошо обеспечивают NoSQL СУБД.
- CRM требует структурированных данных и сложных запросов, что лучше реализуется в реляционных СУБД.

**1.2.* Использование одной СУБД:**
- Да, можно использовать **PostgreSQL** с поддержкой JSONB для гибкости (лендинги) и реляционной структурой для CRM.
- Альтернатива: **MongoDB** с её гибкостью, но для CRM потребуется дополнительная настройка.

---

#### **1.3. База корпоративных норм и правил**
**Тип СУБД:** Реляционная СУБД (например, **PostgreSQL**, **MySQL**).

**Почему:**
- Простая и понятная структура данных.
- Лёгкость в управлении и поддержке.

**1.3.* Использование существующей СУБД:**
- Да, можно использовать ту же СУБД, что и для бюджетирования (например, **PostgreSQL**).
- Реализация: создать отдельную схему или таблицы для корпоративных норм, чтобы изолировать данные.

---

#### **1.4. Логистика и маршруты доставки**
**Тип СУБД:** Графовая СУБД (например, **Neo4j**) или реляционная СУБД с поддержкой геоданных (например, **PostgreSQL** с расширением **PostGIS**).

**Почему:**
- Графовые СУБД идеальны для работы со связями (маршруты, узлы, распределение курьеров).
- Реляционные СУБД с поддержкой геоданных также подходят для маршрутизации.

**1.4.* Подключение отдела закупок:**
- Да, можно использовать ту же СУБД (например, **PostgreSQL**), создав отдельные таблицы или схемы для закупок.
- Альтернатива: интеграция через API между СУБД логистики и закупок.

---

#### **1.5.* Универсальное решение для всех задач**
**Можно ли использовать одну СУБД?**
- Да, можно использовать **PostgreSQL**.
- Почему:
  - Поддерживает реляционные данные (бюджетирование, CRM, нормы).
  - Имеет расширения для работы с геоданными (PostGIS для логистики).
  - Поддерживает JSONB для гибкости (лендинги).
  - Масштабируема и надёжна.

**Реализация:**
- Создать отдельные схемы или базы данных для каждой предметной области.
- Использовать расширения (например, PostGIS, pg_partman для партиционирования).
- Настроить роли и доступы для разных отделов.

---

#### **Итоговые рекомендации:**
1. **PostgreSQL** — универсальное решение для большинства задач.
2. **MongoDB** — для лендингов, если требуется высокая гибкость.
3. **Neo4j** — для логистики, если акцент на графовые связи.
4. **Redis** — для кэширования и ускорения работы.

Если компания стремится к простоте и унификации, **PostgreSQL** с её расширениями и гибкостью станет оптимальным выбором для всех задач.

---

## Задание 2. Транзакции

2.1. Пользователь пополняет баланс счёта телефона, распишите пошагово, какие действия должны произойти для того, чтобы 
транзакция завершилась успешно. Ориентируйтесь на шесть действий.

2.1.* Какие действия должны произойти, если пополнение счёта телефона происходило бы через автоплатёж?

### 2.1. Пошаговые действия для успешного пополнения баланса счёта телефона:

1. **Инициация транзакции**:  
   Пользователь выбирает способ пополнения (например, через банковскую карту, электронный кошелёк или терминал) и вводит необходимые данные (номер телефона, сумму пополнения).

2. **Проверка данных**:  
   Система проверяет корректность введённых данных (номер телефона, сумма, реквизиты платежа). Если данные верны, процесс продолжается.

3. **Авторизация платежа**:  
   Платежная система запрашивает подтверждение у банка или платёжного сервиса (например, через 3D-Secure для банковских карт). Пользователь может получить код подтверждения на телефон или в приложение банка.

4. **Списание средств**:  
   После успешной авторизации средства списываются с источника (карты, кошелька или счёта) и резервируются для перевода на счёт телефона.

5. **Зачисление средств на счёт телефона**:  
   Оператор связи получает информацию о платеже и зачисляет средства на баланс указанного номера телефона.

6. **Подтверждение успешного пополнения**:  
   Пользователь получает уведомление (SMS, push-уведомление или email) о успешном пополнении баланса. Также может быть предоставлен чек или квитанция.

---

### 2.1.* Действия при пополнении счёта телефона через автоплатёж:

1. **Настройка автоплатежа**:  
   Пользователь заранее настраивает автоплатёж, указывая номер телефона, сумму пополнения, периодичность (например, ежемесячно) и источник средств (карта или счёт).

2. **Автоматическая проверка данных**:  
   В назначенную дату система автоматически проверяет корректность данных (наличие средств на источнике, активность номера телефона).

3. **Авторизация платежа**:  
   Система автоматически запрашивает авторизацию у банка или платёжного сервиса (если требуется).

4. **Списание средств**:  
   Средства автоматически списываются с указанного источника (карты или счёта).

5. **Зачисление средств на счёт телефона**:  
   Оператор связи получает информацию о платеже и зачисляет средства на баланс телефона.

6. **Уведомление пользователя**:  
   Пользователь получает уведомление (SMS, email или push) о успешном выполнении автоплатежа.

---

## Задание 3. SQL vs NoSQL

3.1. Напишите пять преимуществ SQL-систем по отношению к NoSQL. 

3.1.* Какие, на ваш взгляд, преимущества у NewSQL систем перед SQL и NoSQL.

### 3.1. Пять преимуществ SQL-систем по отношению к NoSQL:

1. **Стандартизация и универсальность**:
   - SQL-системы используют стандартизированный язык запросов (SQL), который широко поддерживается и изучается. Это делает их универсальными и удобными для работы с различными реляционными базами данных.
   - NoSQL-системы, напротив, часто используют свои уникальные языки запросов или API, что усложняет миграцию между системами.

2. **Целостность данных**:
   - SQL-системы поддерживают ACID-транзакции (Atomicity, Consistency, Isolation, Durability), что обеспечивает высокую надежность и целостность данных.
   - NoSQL-системы часто жертвуют ACID в пользу производительности и масштабируемости, что может привести к проблемам с согласованностью данных.

3. **Сложные запросы и аналитика**:
   - SQL-системы позволяют выполнять сложные запросы с использованием JOIN, подзапросов, агрегатных функций и других возможностей SQL. Это делает их идеальными для аналитики и работы со структурированными данными.
   - NoSQL-системы часто ограничены в поддержке сложных запросов, особенно если данные распределены между несколькими узлами.

4. **Зрелость и экосистема**:
   - SQL-системы существуют десятилетия, имеют развитую экосистему инструментов, библиотек и интеграций. Это делает их более предсказуемыми и надежными.
   - NoSQL-системы, хотя и быстро развиваются, все еще могут уступать в зрелости и стабильности.

5. **Структурированные данные**:
   - SQL-системы идеально подходят для работы с четко структурированными данными, где заранее известна схема данных. Это упрощает проектирование и управление базой данных.
   - NoSQL-системы лучше подходят для работы с полуструктурированными или неструктурированными данными, но могут быть менее эффективны для строго структурированных данных.

---

### 3.1.* Преимущества NewSQL систем перед SQL и NoSQL:

NewSQL — это современный класс систем управления базами данных, который сочетает в себе преимущества SQL и NoSQL. Вот их основные преимущества:

1. **Масштабируемость**:
   - NewSQL системы, как и NoSQL, поддерживают горизонтальное масштабирование, что позволяет эффективно работать с большими объемами данных и высокой нагрузкой.
   - В отличие от традиционных SQL-систем, которые часто ограничены вертикальным масштабированием.

2. **Поддержка ACID-транзакций**:
   - NewSQL сохраняет поддержку ACID-транзакций, что обеспечивает надежность и целостность данных, в отличие от многих NoSQL-систем, которые жертвуют этим ради производительности.

3. **Высокая производительность**:
   - NewSQL системы оптимизированы для работы с большими объемами данных и высокой нагрузкой, что делает их более производительными по сравнению с традиционными SQL-системами.

4. **Гибкость**:
   - NewSQL системы поддерживают как структурированные данные (как SQL), так и полуструктурированные данные (как NoSQL), что делает их более универсальными.

5. **Современная архитектура**:
   - NewSQL системы используют современные подходы к распределенным вычислениям, такие как шардирование и репликация, что позволяет им эффективно работать в распределенных средах.

6. **Упрощенная миграция**:
   - Для разработчиков, уже знакомых с SQL, переход на NewSQL проще, чем на NoSQL, так как NewSQL сохраняет поддержку SQL-синтаксиса.

Таким образом, NewSQL системы предлагают лучшее из двух миров: масштабируемость и производительность NoSQL с надежностью и стандартизацией SQL.

---

## Задание 4. Кластеры

Необходимо производить большое количество вычислений при работе с огромным количеством данных, под эту задачу 
выделено 1000 машин. 

На основе какого критерия будете выбирать тип СУБД и какая модель *распределённых вычислений* 
здесь справится лучше всего и почему?

При выборе типа СУБД и модели распределённых вычислений для работы с большим объёмом данных на 1000 машинах, необходимо учитывать следующие критерии:

### Критерии выбора СУБД:
1. **Масштабируемость**:
   - Система должна легко масштабироваться горизонтально (добавление новых машин для увеличения производительности).
   - Поддержка распределённого хранения и обработки данных.

2. **Производительность**:
   - Возможность эффективно выполнять параллельные вычисления.
   - Минимизация задержек при обработке запросов.

3. **Тип данных и workload**:
   - Если данные структурированы и требуют сложных запросов, подойдут реляционные СУБД (например, распределённые версии PostgreSQL или MySQL).
   - Если данные полуструктурированы или неструктурированы (например, JSON, документы, графы), лучше использовать NoSQL СУБД (например, MongoDB, Cassandra, Redis).
   - Для аналитических запросов и больших данных подойдут колоночные СУБД (например, Apache HBase, Amazon Redshift).

4. **Отказоустойчивость и надёжность**:
   - Поддержка репликации данных и автоматического восстановления после сбоев.
   - Гарантии согласованности данных (например, CAP-теорема: выбор между согласованностью, доступностью и устойчивостью к разделению).

5. **Экономическая эффективность**:
   - Стоимость лицензий, поддержки и инфраструктуры.
   - Возможность использования open-source решений (например, Apache Hadoop, Apache Spark).

---

### Модель распределённых вычислений:
Для работы с большим объёмом данных на 1000 машинах лучше всего подойдут следующие модели:

1. **MapReduce**:
   - Модель, используемая в Hadoop, идеально подходит для пакетной обработки больших данных.
   - Разделяет задачи на два этапа: Map (распределённая обработка) и Reduce (агрегация результатов).
   - Преимущества: простота, отказоустойчивость, масштабируемость.
   - Недостатки: высокая задержка, не подходит для real-time обработки.

2. **Apache Spark**:
   - Использует in-memory вычисления, что значительно ускоряет обработку данных по сравнению с Hadoop.
   - Поддерживает различные workload: пакетная обработка, потоковая обработка, машинное обучение, графовые вычисления.
   - Преимущества: высокая производительность, поддержка множества языков (Python, Scala, Java), богатый набор библиотек.
   - Недостатки: требует больших объёмов оперативной памяти.

3. **Dataflow-модель (например, Apache Flink)**:
   - Оптимизирована для потоковой обработки данных с низкой задержкой.
   - Поддерживает как потоковую, так и пакетную обработку.
   - Преимущества: высокая производительность, минимальные задержки, поддержка сложных сценариев обработки.
   - Недостатки: более сложная настройка и управление.

4. **MPI (Message Passing Interface)**:
   - Используется для высокопроизводительных вычислений (HPC), где требуется низкая задержка и высокая пропускная способность.
   - Подходит для задач, требующих интенсивного обмена данными между узлами.
   - Преимущества: высокая производительность для узкоспециализированных задач.
   - Недостатки: сложность программирования и управления.

---

### Рекомендации:
- Если задача связана с пакетной обработкой больших данных, выбирайте **Apache Hadoop** или **Apache Spark**.
- Если требуется потоковая обработка с низкой задержкой, используйте **Apache Flink**.
- Для аналитических запросов и работы с большими объёмами структурированных данных рассмотрите колоночные СУБД (например, **Apache HBase** или **Amazon Redshift**).
- Если данные неструктурированы или полуструктурированы, выбирайте NoSQL СУБД (например, **Cassandra** или **MongoDB**).

---

### Итог:
Для большинства задач, связанных с обработкой больших данных на 1000 машинах, **Apache Spark** является оптимальным выбором благодаря своей универсальности, производительности и поддержке различных workload. Если требуется потоковая обработка, дополнительно рассмотрите **Apache Flink**. Выбор СУБД зависит от типа данных и workload, но для масштабируемости и отказоустойчивости предпочтение стоит отдать распределённым NoSQL или колоночным СУБД.