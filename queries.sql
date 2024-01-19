--Первый отчет о десятке лучших продавцов. Таблица состоит из трех колонок - данных о продавце, 
--суммарной выручке с проданных товаров и количестве проведенных сделок, и отсортирована по убыванию выручки:
--
--	name — имя и фамилия продавца
--	operations - количество проведенных сделок
--	income — суммарная выручка продавца за все время

SELECT
	concat_ws(' ', e.first_name, e.last_name) AS name,
	count(s.sales_person_id) AS operations,
	floor((sum(s.quantity * p.price))) AS income
FROM sales s
JOIN products p
USING (product_id)
JOIN employees e
ON s.sales_person_id = e.employee_id
GROUP BY e.first_name, e.last_name
ORDER BY income DESC
LIMIT 10;


--Второй отчет содержит информацию о продавцах, чья средняя выручка за сделку меньше средней выручки
--за сделку по всем продавцам. Таблица отсортирована по выручке по возрастанию.
--	
--	name — имя и фамилия продавца
--	average_income — средняя выручка продавца за сделку с округлением до целого

SELECT
	concat_ws(' ', e.first_name, e.last_name) AS name,
	floor((avg(s.quantity * p.price))) AS average_income
FROM sales s
JOIN products p
USING (product_id)
JOIN employees e
ON s.sales_person_id = e.employee_id
GROUP BY e.first_name, e.last_name
HAVING floor((avg(s.quantity * p.price))) < (
	SELECT
		floor((avg(s.quantity * p.price)))
	FROM sales s
	JOIN products p 
	USING (product_id)
)
ORDER BY average_income ASC;


--Третий отчет содержит информацию о выручке по дням недели. Каждая запись содержит имя и фамилию продавца,
--день недели и суммарную выручку. Отсортируйте данные по порядковому номеру дня недели и name
--
--	name — имя и фамилия продавца
--	weekday — название дня недели на английском языке
--	income — суммарная выручка продавца в определенный день недели, округленная до целого числа

WITH raw AS (
	SELECT
		concat_ws(' ', e.first_name, e.last_name) AS name,
		EXTRACT(isodow FROM s.sale_date) AS num_dof,
		to_char(s.sale_date, 'day') AS weekday,
		floor((sum(s.quantity * p.price))) AS income
	FROM sales s
	JOIN products p
	USING (product_id)
	JOIN employees e 
	ON s.sales_person_id = e.employee_id
	GROUP BY e.first_name, e.last_name, s.sale_date
)
SELECT name, weekday, sum(income) AS income
FROM raw
GROUP BY name, weekday, num_dof
ORDER BY num_dof, name;