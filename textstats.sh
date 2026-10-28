import re
from collections import Counter
from datetime import datetime

# Имитируем текст файла, который хотел проанализировать друг
text_content = """Это тестовый текст для проверки программы.
Здесь есть повторяющиеся слова: текст, текст, программа.
А еще цифры 123 и разные знаки препинания!
Программа должна посчитать строки, слова и символы.
И найти самые частые слова."""

def main():
    # 1. Считаем статистику
    lines_count = len(text_content.splitlines())
    words_count = len(text_content.split())
    chars_count = len(text_content)

    # 2. Ищем Топ-3 частых слов (улучшение)
    # \w+ находит только слова (буквы и цифры), отбрасывая запятые и точки
    words = re.findall(r'\w+', text_content.lower())
    word_counts = Counter(words)
    top_3_words = word_counts.most_common(3)

    # 3. Красивый вывод (улучшение)
    print("===================================")
    print(" ОТЧЕТ О ФАЙЛЕ")
    print(f" Сгенерировано: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("===================================")
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
