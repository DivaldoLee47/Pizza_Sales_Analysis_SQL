# Pizza Sales Analysis with SQL

We all love pizza!  What could be a more perfect blend than combining our love for food and data by delving into a project focused on analyzing Pizza Sales?

For this project, I sourced pizza sales data from Kaggle which contains four csv files: order_details.csv, orders.csv, pizza_types.csv, and pizzas.csv, which I subsequently imported into SQL Server Management Studio.

orders.csv has columns : order_id, date, time.

order_details.csv has columns : order_details_id, order_id, pizza_id, quantity.

pizza_types.csv has columns : pizza_type_id, name, category, ingredients.

pizzas.csv has columns : pizza_id, pizza_type_id, size, price.

After applying data cleaning tasks such as checking for null values, duplicate rows and ensuring correct data types, I used INNER JOIN to combine all the tables to get the size of the dataset, resulting in a consolidated dataset of 48620 unique rows and 10 unique columns.

# Exploratory Data Analysis

1. How many unique types of pizzas are there on the menu?
2. Which category (e.g., Chicken, Vegetarian) has the most number of pizza varieties?
3. How many orders were placed? And how many pizzas were ordered in total?
4. What is the average number of pizzas ordered in a single transaction?
5. Which pizza has been ordered the most in terms of quantity?
6. On which days of the week are the most orders placed?
7. What is the distribution of quantity of pizza ordered by pizza size (small, medium, large)?
8. How many orders contain more than one type of pizza?
9. Determine the best and worst month in terms of order volume.
10. What is the most popular pizza category (e.g., Chicken, Vegetarian) for each day of the week, based on the total quantity of pizzas ordered?

Key Findings and Suggestions

1. The pizza establishment boasts a diverse menu featuring 32 distinct pizza varieties, providing customers with ample choices.
2. Throughout 2015, the restaurant successfully processed a total of 21,350 orders, selling a whopping 49,574 pizzas.
3. On average, each transaction consisted of 2 pizzas. To stimulate sales, consider encouraging customers to explore additional menu items, such as sides or     beverages. This can be accomplished through special bundle offers, time-limited promotions, or recommending complementary items during the ordering process.
4. The "big_meat_s" pizza stood out as the top seller, with a total of 1,914 units ordered. This pizza's popularity could be leveraged to promote other similar menu items.
5. Fridays experienced the highest order volume, with 3,538 orders processed. Capitalize on this peak day by introducing Friday-specific promotions or discounts.
6. Large pizzas proved to be the most popular size, with 19,536 orders, followed by medium (15,635) and small (14,403). Entice customers to opt for larger sizes by offering discounts or special promotions.
7. A notable portion of orders (13,149 out of 21,350) included multiple pizza types. Consider introducing combo deals to incentivize customers to explore different pizza options.
8. July recorded the highest order volume with 1,935 orders, while October had the lowest with 1,646 orders. To address seasonal fluctuations, analyze the factors influencing order volume and plan marketing initiatives or seasonal specials to boost sales during slower months like October.

By implementing these recommendations and capitalizing on the insights gained from the analysis, the pizza establishment can enhance sales and customer satisfaction, ultimately resulting in increased revenue.
