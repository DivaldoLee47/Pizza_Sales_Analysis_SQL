-- CHECK FOR MISSING VALUES

SELECT * 
FROM OrderDetails
WHERE quantity IS NULL

SELECT * 
FROM Orders
WHERE date IS NULL

SELECT * 
FROM Pizzas
WHERE price IS NULL

SELECT *
FROM PizzaTypes
WHERE ingredients IS NULL

-- INNER JOIN
SELECT
    OD.order_details_id,
    OD.order_id,
    OD.pizza_id,
    OD.quantity,
    O.date,
    O.time,
    P.pizza_id,
    P.size,
    P.price,
    PT.name
FROM
    OrderDetails OD
INNER JOIN
    Orders O ON OD.order_id = O.order_id
INNER JOIN
    Pizzas P ON OD.pizza_id = P.pizza_id
INNER JOIN
    PizzaTypes PT ON P.pizza_type_id = PT.pizza_type_id;

-- Exploratory Data Analysis
-- 1. How many unique types of pizzas are there on the menu?

SELECT COUNT(DISTINCT name) AS unique_pizza_types
FROM PizzaTypes;

-- 2. Which category (e.g., Chicken, Vegetarian) has the most number of pizza varieties?

WITH CategoryCounts AS (
    SELECT
        PT.category,
        COUNT(PT.pizza_type_id) AS variety_count
    FROM
        PizzaTypes PT
    GROUP BY
        PT.category
)
SELECT
    category,
    variety_count
FROM
    CategoryCounts
WHERE
    variety_count = (SELECT MAX(variety_count) FROM CategoryCounts);

-- 3. How many orders were placed? And how many pizzas were ordered in total?

SELECT COUNT(*) AS total_orders
FROM Orders;

SELECT SUM(OD.quantity) AS total_pizzas_ordered
FROM OrderDetails OD;

--4. What is the average number of pizzas ordered in a single transaction?

WITH SingleTransaction AS(
	SELECT SUM(OD.quantity) AS sum_quantity_per_order_id
	FROM OrderDetails OD
	GROUP BY OD.order_id
)
SELECT AVG(ST.sum_quantity_per_order_id) AS average_pizzas_ordered
FROM SingleTransaction ST

--5. Which pizza has been ordered the most in terms of quantity?

SELECT TOP 1
    OD.pizza_id,
    P.pizza_type_id,
    PT.name AS pizza_name,
    SUM(OD.quantity) AS total_quantity_ordered
FROM
    OrderDetails OD
JOIN
    Pizzas P ON OD.pizza_id = P.pizza_id
JOIN
    PizzaTypes PT ON P.pizza_type_id = PT.pizza_type_id
GROUP BY
    OD.pizza_id, P.pizza_type_id, PT.name
ORDER BY
    total_quantity_ordered DESC;

--6. On which days of the week are the most orders placed?

SELECT
    DATENAME(WEEKDAY, CAST(date AS DATE)) AS day_of_week,
    COUNT(*) AS order_count
FROM
    Orders
GROUP BY
    DATENAME(WEEKDAY, CAST(date AS DATE))
ORDER BY
    order_count DESC

OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

-- 7. What is the distribution of quantity of pizza ordered by pizza size (small, medium, large)?

SELECT
    P.size,
    SUM(OD.quantity) AS total_quantity_ordered
FROM
    Pizzas P
JOIN
    OrderDetails OD ON P.pizza_id = OD.pizza_id
GROUP BY
    P.size
ORDER BY
    P.size;

-- 8. How many orders contain more than one type of pizza?

WITH MultiplePizzaOrders AS (
    SELECT order_id
    FROM OrderDetails
    GROUP BY order_id
    HAVING COUNT(DISTINCT pizza_id) > 1
)

SELECT COUNT(*) AS orders_with_multiple_pizzas
FROM MultiplePizzaOrders;

--9. Can you determine the best and worst month in terms of order volume?

SELECT
	DATENAME(MONTH, CAST(date AS DATE)) AS month_of_week,
	COUNT(DISTINCT order_id) AS total_orders
FROM Orders
GROUP BY DATENAME(MONTH, CAST(date AS DATE))
ORDER BY total_orders desc;	

--10. What is the most popular pizza category (e.g., Chicken, Vegetarian) for each day of the week, based on the total quantity of pizzas ordered?

WITH DayOfWeekPizzaCounts AS (
    SELECT
        DATENAME(dw, CAST(O.date AS DATE)) AS day_of_week,
        PT.category,
        SUM(OD.quantity) AS total_quantity_ordered
    FROM
        Orders O
    JOIN
        OrderDetails OD ON O.order_id = OD.order_id
    JOIN
        Pizzas P ON OD.pizza_id = P.pizza_id
    JOIN
        PizzaTypes PT ON P.pizza_type_id = PT.pizza_type_id
    GROUP BY
        DATENAME(dw, CAST(O.date AS DATE)),
        PT.category
),
RankedPizzaCounts AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY day_of_week ORDER BY total_quantity_ordered DESC) AS row_num
    FROM
        DayOfWeekPizzaCounts
)
SELECT
    day_of_week,
    category,
    total_quantity_ordered
FROM
    RankedPizzaCounts
WHERE
    row_num = 1

--https://www.linkedin.com/pulse/pizza-sales-analysis-sql-amandeep-singh/?trackingId=6evglv4kQTS8zzkZgnwXmw%3D%3D
