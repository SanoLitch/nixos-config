#!/usr/bin/env bash

# Получаем события на сегодня
# --day-format "" убирает заголовки дат
# --format задает формат самого события
events=$(khal list now tomorrow --format "{start-time} {title}" --day-format "")

# Убираем пустые строки
clean_events=$(echo "$events" | grep -v "^$")

if [ -z "$clean_events" ]; then
    echo '{"text": "", "tooltip": "No events today", "class": "empty"}'
else
    # Берем первое событие (ближайшее)
    next_event_full=$(echo "$clean_events" | head -n 1)
    
    # Извлекаем время и заголовок
    event_time=$(echo "$next_event_full" | awk '{print $1}')
    event_title=$(echo "$next_event_full" | cut -d' ' -f2-)
    
    # Обрезаем заголовок до 20 символов
    MAX_LENGTH=20
    if (( ${#event_title} > MAX_LENGTH )); then
        event_title_trimmed="${event_title:0:MAX_LENGTH}..."
    else
        event_title_trimmed="$event_title"
    fi
    
    # Формируем текст для Waybar
    next_event_display="$event_time $event_title_trimmed"

    # Формируем тултип из всех событий (экранируем кавычки и добавляем \n)
    tooltip=$(echo "$clean_events" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
    
    # Вывод JSON
    echo "{\"text\": \"| $next_event_display |\", \"tooltip\": \"$tooltip\", \"class\": \"has-events\"}"
fi
