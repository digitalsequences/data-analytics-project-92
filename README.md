### Hexlet tests and linter status:
[![Actions Status](https://github.com/digitalsequences/data-analytics-project-92/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/digitalsequences/data-analytics-project-92/actions)

# Описание проекта "Продажи"
Анализ данных торговой площадки:
1. Работа с базой данных
2. Визуализация выборок данных в Preset
3. Презентация результатов

Стек: `PostgreSQL`, `DBeaver`, `Apache Superset`

## Работа с базой данных
![База данных торговой площадки](/img/db.png)

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
![Дашборд](/img/dashboard.jpg)

## Презентация результатов
\presentation.pdf
