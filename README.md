# Тестове завдання: "Гра - Розстав кораблі"

## Опис
Це частина гри "Морський бій", функціонал розміщення кораблів на ігровому полі.

## Функціонал:
- Розстановка кораблів через Drag & Drop.
- Перевірка на перетин кораблів.
- Відображення кнопки "Почати гру" після завершення розстановки.

## Запуск:
1. Клонуйте репозиторій.
2. Запустіть `flutter pub get`.
3. Запустіть додаток за допомогою `flutter run`.


## Повне ТЗ
### Тема:
Спрощена версія гри "Морський бій", яка зосереджується на UI, базовій логіці розміщення елементів та перевірці коректності дій користувача.

### Опис завдання
**Головний екран:**  
Логотип гри: Відобразити логотип "Морський бій".

**Меню:**
- Кнопка «Грати» (перехід до екрану розстановки кораблів).
- Кнопка «Вихід» (закриває гру).
- Простий фон морської тематики.
- 
**Екран розстановки кораблів:**
- Ігрове поле: Грід 10x10 (прямокутник із квадратів).
- Кораблі для розміщення:
  - 1 чотирипалубний корабель.
  - 2 трипалубні кораблі.
  - 3 двопалубні кораблі.
  - 4 однопалубні кораблі.

**Функціональність:**
- Drag & Drop для розміщення кораблів на полі (горизонтально).
- Перевірка на перетин кораблів.
- Кнопка «Почати гру» стає активною лише після завершення розстановки.
- Підсвічування клітинок під час Drag & Drop.

**Додаткові (необов’язкові) завдання:**
- [x] Обертання кораблів (горизонтально/вертикально).
- [ ] Автоматична розстановка кораблів (кнопка "Авто").

**Технічні вимоги**
- State Management: Provider \ Riverpod \ bloc.
- Ігрове поле: Використовувати багатовимірний масив для відображення стану поля.
- Drag & Drop: Реалізація через GestureDetector або Draggable.
- Логіка перевірки: Перевірка коректності розташування кораблів (не перетинаються, в межах поля).
- Чистий код: Розділення логіки та UI (MVVM або інша структура).

**Очікуваний результат**
Вихідний код:  
Код у репозиторії GitHub із README.  
README:
- Опис завдання.
- Інструкція з запуску.

### Що перевіряє це завдання?
- UI: Знання роботи з грідами та базова адаптація.
- Drag & Drop: Взаємодія з користувачем.
- Базова логіка: Перевірка коректності розміщення елементів.
- State Management: Уміння працювати зі станами.

### Посилання на фото з кораблями:**
- [https://ibb.co/PWxPDWg](https://ibb.co/PWxPDWg)
- [https://ibb.co/GFpK0Sk](https://ibb.co/GFpK0Sk)
- [https://ibb.co/W6zKqgD](https://ibb.co/W6zKqgD)
- [https://ibb.co/PzWb5rC](https://ibb.co/PzWb5rC)

### Посилання на перегляд прикладу:**
- [https://ibb.co/rvPMCKS](https://ibb.co/rvPMCKS)