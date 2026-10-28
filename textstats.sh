import sys
import os
import re
from collections import Counter
from datetime import datetime

def main():
    # 1. Проверка аргументов командной строки
    if len(sys.argv) != 2:
        print(f"Использование: {sys.argv[0]} FILE.txt", file=sys.stderr)
        sys.exit(1)

    file_path = sys.argv[1]

    # 2. Проверка, существует ли файл
    if not os.path.isfile(file_path):
        print(f"Файл не найден: {file_path}", file=sys.stderr)
        sys.exit(1)

    # 3. Чтение файла
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Ошибка при чтении файла: {e}", file=sys.stderr)
        sys.exit(1)

    # 4. Подсчет статистики
    lines_count = len(content.splitlines())
    words_count = len(content.split())
    chars_count = len(content)

    # 5. Поиск Топ-3 частых слов
    # re.findall ищет все слова (буквы и цифры), игнорируя знаки препинания
    words = re.findall(r'\w+', content.lower())
    word_counts = Counter(words)
    top_3_words = word_counts.most_common(3)

    # 6. Красивый вывод
    print("===================================")
    print(" ОТЧЕТ О ФАЙЛЕ")
    print(f" Сгенерировано: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("===================================")
    print(f"Файл: {file_path}")
    print(f"Строк: {lines_count}")
    print(f"Слов: {words_count}")
    print(f"Символов: {chars_count}")
    print("-----------------------------------")

    if top_3_words:
        print("Топ-3 самых частых слов:")
        for word, count in top_3_words:
            print(f"  - {word} (встречается {count} раз)")
    else:
        print("Самое частое слово: нет данных")
    print("===================================")

if __name__ == "__main__":
    main()
