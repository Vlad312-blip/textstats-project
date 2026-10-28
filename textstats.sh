#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Использование: $0 FILE.txt" >&2
  exit 1
fi

file="$1"

if [[ ! -f "$file" ]]; then
  echo "Файл не найден: $file" >&2
  exit 1
fi

lines=$(wc -l < "$file")
words=$(wc -w < "$file")
chars=$(wc -m < "$file")

# УЛУЧШЕНИЕ 1: Получаем не 1, а ТОП-3 слова (head -n 3)
top_words=$(tr -cs '[:alnum:]' '\n' < "$file" \
  | tr '[:upper:]' '[:lower:]' \
  | sed '/^$/d' \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -n 3)

# УЛУЧШЕНИЕ 2: Красивое оформление и дата
echo "==================================="
echo " ОТЧЕТ О ФАЙЛЕ"
echo " Сгенерировано: $(date '+%Y-%m-%d %H:%M:%S')"
echo "==================================="
echo "Файл: $file"
echo "Строк: $lines"
echo "Слов: $words"
echo "Символов: $chars"
echo "-----------------------------------"

# УЛУЧШЕНИЕ 3: Красивый вывод Топ-3 через awk
if [[ -n "$top_words" ]]; then
  echo "Топ-3 самых частых слов:"
  echo "$top_words" | awk '{print "  - " $2 " (встречается " $1 " раз)"}'
else
  echo "Самое частое слово: нет данных"
fi
echo "==================================="
