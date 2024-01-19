--4--
--Подсчет общего количества покупателей из таблицы customers

SELECT count(c.customer_id) AS customers_count
FROM customers AS c;


--5--
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


--6--
--Первый отчет - количество покупателей в разных возрастных группах: 16-25, 26-40 и 40+. 
--Итоговая таблица должна быть отсортирована по возрастным группам и содержать следующие поля:
--
--	age_category - возрастная группа
--	count - количество человек в группе

SELECT '16-25' AS age_category, count(age) AS count
FROM customers c
WHERE age BETWEEN 16 AND 25
UNION
SELECT '26-40' AS age_category, count(age) AS count
FROM customers c
WHERE age BETWEEN 26 AND 40
UNION
SELECT '40+' AS age_category,count(age) AS count
FROM customers c
WHERE age > 40
ORDER BY age_category;


--Во втором отчете предоставьте данные по количеству уникальных покупателей и выручке, 
--которую они принесли. Сгруппируйте данные по дате, которая представлена в числовом виде ГОД-МЕСЯЦ.
--Итоговая таблица должна быть отсортирована по дате по возрастанию и содержать следующие поля:
--
--	date - дата в указанном формате
--	total_customers - количество покупателей
--	income - принесенная выручка

SELECT
	to_char(s.sale_date, 'YYYY-MM') AS date,
	count(customer_id) AS total_customers,
	floor(sum(s.quantity * p.price)) AS income
FROM sales s
JOIN customers c
	USING (customer_id)
JOIN products p
	USING (product_id)
GROUP BY date
ORDER BY date;


--Третий отчет следует составить о покупателях, первая покупка которых была в ходе проведения акций
--(акционные товары отпускали со стоимостью равной 0). Итоговая таблица должна быть отсортирована 
--по id покупателя. Таблица состоит из следующих полей:
--
--	customer - имя и фамилия покупателя
--	sale_date - дата покупки
--	seller - имя и фамилия продавца

SELECT
	concat_ws(' ', c.first_name, c.last_name) AS customer,
	s.sale_date AS sale_date,
	concat_ws(' ', e.first_name, e.last_name) AS seller
FROM sales s
JOIN products p	USING (product_id)
JOIN customers c USING (customer_id)
JOIN employees e ON s.sales_person_id = e.employee_id
WHERE s.sales_id IN (
					SELECT 
						DISTINCT ON (_s.customer_id)
						FIRST_VALUE(_s.sales_id) OVER (PARTITION BY _s.customer_id ORDER BY _s.sale_date)
						AS promotion_sales_id
					FROM sales _s
					JOIN products _p
						USING (product_id)
					WHERE _p.price = 0
)
ORDER BY s.customer_id;