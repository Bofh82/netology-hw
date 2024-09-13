### Запустить новую сессию shell с привилегиями суперпользователя
```$ sudo -s```
---
### Установить репозиторий Zabbix
```
# wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb
# dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb
# apt update
```
---
### Установить Zabbix сервер, веб-интерфейс и агент
```
# apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent
```
---
### Создать базу данных
1. Установить и запустить сервер базы данных.
2. Выполнить следующие комманды на хосте, где расположена база данных.
```
# sudo -u postgres createuser --pwprompt zabbix
# sudo -u postgres createdb -O zabbix zabbix
```
3. На хосте Zabbix сервера импортировать начальную схему и данные.
```
# zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```
---
### Настроть базу данных для Zabbix сервера
Отредактировать файл */etc/zabbix/zabbix_server.conf*
```
DBPassword=password
```
---
### Запустить процессы Zabbix сервера и агента
```
# systemctl restart zabbix-server zabbix-agent apache2
# systemctl enable zabbix-server zabbix-agent apache2
```
---
### Открыть веб-интерфейс Zabbix UI
URL по умолчанию для интерфейса Zabbix при использовании веб-сервера Apache: http://host/zabbix

---