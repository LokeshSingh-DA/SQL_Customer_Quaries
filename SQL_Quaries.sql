create table customers(
customer_id int primary key auto_increment,
name varchar(100) not null,
email varchar(100) not null unique,
phone Varchar (15),
created_at datetime default current_timestamp);

CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
category VARCHAR(50) NOT NULL,
price DECIMAL(10,2) NOT NULL,
stock_quantity INT NOT NULL DEFAULT 0,
added_on DATETIME DEFAULT current_timestamp);

CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(20) DEFAULT 'Pending',
total_amount DECIMAL(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

CREATE TABLE order_items (
order_item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_id INT,
quantity INT NOT NULL CHECK (quantity > 0),
item_price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id));

CREATE TABLE payments (
payment_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
amount_paid DECIMAL(10,2) NOT NULL CHECK (amount_paid > 0),
method VARCHAR(20) NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id));

CREATE TABLE product_reviews (
review_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
customer_id INT,
rating INT NOT NULL,
review_text TEXT,
review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

# ---------------  Questions ---------------- #
                # Level 1 : Basics
# Q1. Retrieve Customer names and emails for email marketing
select Name, email from customers;

# Q2. View complete product catalog with all available details
select * from products;

# Q3. List all unique product categories
select distinct category from products;

# Q4. Show all products priced above 1000
select name, price from products
where price > 1000;

# Q5. Display products within a mid_range price bracket (2000 to 5000)
select name, price from products
where price between 2000 and 5000;

# Q6. Fetch data for specific Customer IDs
select * from customers
where customer_id in (1,10,14,24);
# here i extracts data of random customers.

# Q7. Identify customers whose name starts with the letter "A"
select * from customers
where name like "A%";

# Q8. List electronic Products priced under 3000
select * from products
where category = "Electronics" and price < 3000;

# Q9. Display Products name and price in descending order of price
select name, price from products
order by price desc;

# Q10 Display products names and prices, sorted by price and then by name
select name, price from products
order by price desc, name ;


		 # Level 2: Filtering and Formatting

# Q1. Retrieve orders where customer information is missing (possibly due to data migration ordeletion
select * from orders
where customer_id is null;

# Q2. Display customer names and emails using column aliases for frontend readability
select name as Customer_Name, email as Email from customers;

# Q3. Calculate total value per item ordered by multiplying quantity and item price
select quantity, item_price, (quantity * item_price) as Total_value 
from order_items;

# Q4. Combine Customer name and phone number in a single column
select concat(name," : ",phone) as Customer_Details 
from customers;

# Q5.  Extract only the date part from order timestamps for date-wise reporting
select date(order_date) as Date from orders;

# Q6. List products that do not have any stock left.
select * from products
where stock_quantity = 0;


			# Level 3: Aggregation 

# Q1. Count the total number of orders placed
select count(*) as Total_Orders from orders;

# Q2. Calculate the total revenue collected from all orders
select sum(total_amount) as Total_Revenue from orders;

# Q3. calculate the avg of value.
select avg(total_amount) as Average_Order_Value from orders;

# Q4.  Count the number of customers who have placed at least one orders
select count(distinct customer_id) as Customers from orders;

# Q5. Find the nummber of orders placed by each customer
select customer_id, count(customer_id) as total_orders from orders
group by customer_id;

# Q6. Find total sales amount made by each customer
select customer_id, sum(total_amount) as Total_Sales from orders
group by customer_id;

# Q7. List the number of products sold per categoryT
select category, count(*) as Items from products join order_items
on products.product_id = order_items.product_id
group by category;


# Q8. Find the average item price per category
select category, avg(price) as Average_Price from products
group by category;

# Q9. Show number of orders placed per day
select date(order_date) as Date,count(*) as Orders 
from orders
group by date(order_date)
order by date(order_date);

# Q10. List total payments received per payment method
select Method,sum(amount_paid) as Total_Price
from payments
group by method;


		# Level 4: Multi-Table Queries (JOIN)
   
# Q1. Retrieve order details along with the customer name (INNER JOIN)
select * from customers
inner join orders
on customers.customer_id = orders.customer_id;

# Q2. Get list of products that have been sold (INNER JOIN with order_items)
select * from products 
inner join order_items
on products.product_id = order_items.product_id;

# Q3. List all orders with their payment method (INNER JOIN )
select payment_id as Order_ID, method from orders 
inner join payments
on orders.order_id = payments.order_id;

# Q4. Get list of customers and their orders (LEFT JOIN)
select * from customers
left join orders
on customers.customer_id = orders.customer_id;

# Q5. List all products along with order item quantity (LEFT JOIN)
select name, count(name) as Order_Item_Quantity from products 
left join order_items
on products.product_id = order_items.product_id
group by name;

# Q6. List all payments including those with no matching orders (RIGHT JOIN)
select method, order_item_id from payments 
right join order_items
on payments.order_id = order_items.order_id;

# Q7. Combine data from three tables: customer, order, and payment
select * from customers
join orders
on customers.customer_id = orders.customer_id
join payments
on orders.order_id = payments.order_id;


		# Level 5: Subqueries (Inner Queries)

# Q1. List all products priced above the average product price
select Name, Price from products
where price >(select avg(price) from products);

# Q2. Find customers who have placed at least one order
select name, count(name) as orders from customers
inner join orders
on customers.customer_id = orders.customer_id
group by name;

# Q3. Show orders whose total amount is above the average for that customer
select Name,order_id,total_amount from orders
inner join customers
on customers.customer_id = orders.customer_id
where total_amount>(select avg(total_amount) from orders);

# Q4. Display customers who haven’t placed any orders
SELECT *
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
where order_id is null;


# Q5. Show products that were never ordered
select * from products
LEFT JOIN order_items
ON products.product_id = order_items.product_id
WHERE order_items.product_id IS NULL;

# Q6. Show highest value order per customer
select name, max(total_amount) as Highest_Amount from customers
join orders
on customers.customer_id = orders.customer_id
group by name;

# Q7. Highest Order Per Customer (Including Names)
select name, max(total_amount) as Highest_Amount from customers
join orders
on customers.customer_id = orders.customer_id
group by name;


			# Level 6: Set Operations
	
 # Q1. List all customers who have either placed an order or written a product review
 select * 
 from customers
 where customer_id in ( select customer_id from orders)
 union
 select * from customers 
 where customer_id in ( select customer_id from product_reviews);
 
# Q2.  List all customers who have placed an order as well as reviewed
select * from customers 
where exists ( select 1 from orders 
where customers.customer_id = orders.customer_id
)
and 
exists ( select 1 from product_reviews 
where product_reviews.customer_id = customers.customer_id
);
