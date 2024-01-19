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
