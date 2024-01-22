### Hexlet tests and linter status:
[![Actions Status](https://github.com/digitalsequences/data-analytics-project-92/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/digitalsequences/data-analytics-project-92/actions)

# Описание проекта "Продажи"
Анализ данных торговой площадки:
1. Работа с базой данных
2. Визуализация выборок данных в Preset
3. Презентация результатов

Стек: `PostgreSQL`, `DBeaver`, `Apache Superset`

## Работа с базой данных
![База данных торговой площадки]([https://www.example.com/image.jpg](https://cdn2.hexlet.io/derivations/image/original/eyJpZCI6ImI1MzkzN2Q5ZTNjNDgwM2UzZWMxZDUyY2E3NjU1YjYyLnBuZyIsInN0b3JhZ2UiOiJjYWNoZSJ9?signature=18b7b5104b672fea80e6cd5e1adf0e5c84d2404d0c571b4bad4bdc77f88ff2d3)https://cdn2.hexlet.io/derivations/image/original/eyJpZCI6ImI1MzkzN2Q5ZTNjNDgwM2UzZWMxZDUyY2E3NjU1YjYyLnBuZyIsInN0b3JhZ2UiOiJjYWNoZSJ9?signature=18b7b5104b672fea80e6cd5e1adf0e5c84d2404d0c571b4bad4bdc77f88ff2d3)

База данных состоит из четырех таблиц.

1. **customers** — таблица покупателей.
Колонки:
- customer_id — ID покупателя
- first_name — имя
- middle_initial — инициал отчества
- last_name — фамилия

2. **employees** — таблица сотрудников отдела продаж:
- employee_id — ID сотрудника
- first_name — имя
- middle_initial — инициал отчества
- last_name — фамилия

3. **products** — таблица товаров:
- product_id — ID товара
- name — название
- price — цена

4. **sales** — таблица с данными о проданных товарах:
- sales_id
- sales_person_id — ID сотрудника, продавшего товар
- customer_id — ID покупателя
- product_id — ID товара
- quantity — количество
- sale_date — дата продажи

\queries.sql

## Визуализация выборок данных в Preset
![Текст с описанием картинки](/images/picture.jpg)

## Презентация результатов
\presentation.pdf
