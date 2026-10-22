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
top_word=$(tr -cs '[:alnum:]' '\n' < "$file" \
  | tr '[:upper:]' '[:lower:]' \
  | sed '/^$/d' \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -n 1)

echo "Файл: $file"
echo "Строк: $lines"
echo "Слов: $words"
echo "Символов: $chars"

if [[ -n "$top_word" ]]; then
  echo "Самое частое слово: $top_word"
else
  echo "Самое частое слово: нет данных"
fi
