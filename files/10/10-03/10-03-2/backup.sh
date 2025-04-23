#!/bin/bash

# Директории
SOURCE_DIR="$HOME/"
DEST_DIR="/tmp/backup"

# Лог файл
# Лог файл
LOG_DIR="/home/rose/log"
LOG_FILE="$LOG_DIR/backup.log"

# Проверка и создание директории для лог-файла
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
fi

# Выполнение rsync
rsync -av --delete --checksum --exclude='.*' "$SOURCE_DIR" "$DEST_DIR" >> "$LOG_FILE" 2>&1

# Проверка статуса выполнения команды rsync
if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup successful" >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup failed" >> "$LOG_FILE"
fi
