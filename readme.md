![Petrovich](https://raw.github.com/rocsci/petrovich/master/petrovich.png)

Склонение падежей русских имён, фамилий и отчеств.

Портированная версия с [Ruby](https://github.com/petrovich/petrovich-ruby) на Dart

Лицензия MIT

##Установка

Добавьте в `pubspec.yaml` новую зависимость:

```yaml
petrovich: any
```

### Использование

```php
import 'package:petrovich/petrovich.dart;

Petrovich petrovich = new Petrovich(Petrovich.GENDER_MALE);

String firstname = "Александр";
String middlename = "Сергеевич";
String lastname = "Пушкин";

print(Petrovich.detectGender("Петровна"));	// Petrovich.GENDER_FEMALE (см. пункт Пол)

print(petrovich.firstName(firstname, Petrovich.CASE_GENITIVE)); //	Александра
print(petrovich.middlename(middlename, Petrovich.CASE_GENITIVE)); //	Сергеевича
print(petrovich.lastname(lastname, Petrovich.CASE_GENITIVE)); //	Пушкина
```

## Падежи
Названия суффиксов для методов образованы от английских названий соответствующих падежей.
Полный список поддерживаемых падежей приведён в таблице ниже.

| Суффикс метода | Падеж        | Характеризующий вопрос |
|----------------|--------------|------------------------|
| CASE_NOMENATIVE| именительный | Кто? Что?            |
| CASE_GENITIVE  | родительный  | Кого? Чего?            |
| CASE_DATIVE    | дательный    | Кому? Чему?            |
| CASE_ACCUSATIVE| винительный  | Кого? Что?             |
| CASE_INSTRUMENTAL   | творительный | Кем? Чем?              |
| CASE_PREPOSITIONAL  | предложный   | О ком? О чём?          |

## Пол
Метод ```Petrovich.detectGender``` возвращает пол, на основе отчества. Возвращаемое значение не зависит от пола, переданного в конструктор.
Для полов определены следующие константы
* GENDER_ANDROGYNOUS - пол не определен;
* GENDER_MALE - мужской пол;
* GENDER_FEMALE - женский пол.