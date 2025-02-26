#!/usr/bin/env python
# coding=utf-8
import pika

# Устанавливаем соединение с RabbitMQ
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

# Объявляем очередь 'hello'
channel.queue_declare(queue='hello')

# Функция-обработчик для входящих сообщений
def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)

# Подписываемся на очередь 'hello' и указываем функцию-обработчик
channel.basic_consume(queue='hello', on_message_callback=callback, auto_ack=True)

# Запускаем бесконечный цикл ожидания сообщений
channel.start_consuming()