-- =========================
-- Insert into dim_date
-- =========================

INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,0),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,0),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,0),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,0),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,0),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,1),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,1),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,0),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,0),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,0),

(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,0),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,0),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,1),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,1),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,0),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,0),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,0),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,0),
(20240209,'2024-02-09','Friday',9,2,'February','Q1',2024,0),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,1);

-- =========================
-- Insert into dim_product
-- =========================

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop Pro','Electronics','Laptop',50000),
('P002','Smartphone X','Electronics','Mobile',30000),
('P003','Wireless Earbuds','Electronics','Audio',5000),
('P004','Smart TV','Electronics','TV',60000),
('P005','Gaming Mouse','Electronics','Accessories',2000),

('P006','Jeans','Fashion','Clothing',2500),
('P007','T-Shirt','Fashion','Clothing',1200),
('P008','Jacket','Fashion','Clothing',4500),
('P009','Sneakers','Fashion','Footwear',6000),
('P010','Sandals','Fashion','Footwear',1800),

('P011','Rice Bag','Groceries','Food',900),
('P012','Wheat Flour','Groceries','Food',700),
('P013','Cooking Oil','Groceries','Food',1500),
('P014','Sugar','Groceries','Food',800),
('P015','Tea Powder','Groceries','Beverage',1200);

-- =========================
-- Insert into dim_customer
-- =========================

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Rahul Sharma','Bangalore','Karnataka','High'),
('C002','Priya Patel','Mumbai','Maharashtra','Medium'),
('C003','Amit Kumar','Delhi','Delhi','Low'),
('C004','Sneha Reddy','Hyderabad','Telangana','Medium'),
('C005','Vikram Singh','Chennai','Tamil Nadu','High'),
('C006','Anjali Mehta','Bangalore','Karnataka','Low'),
('C007','Ravi Verma','Pune','Maharashtra','Medium'),
('C008','Pooja Iyer','Bangalore','Karnataka','High'),
('C009','Karthik Nair','Kochi','Kerala','Low'),
('C010','Deepa Gupta','Delhi','Delhi','Medium'),
('C011','Arjun Rao','Hyderabad','Telangana','High'),
('C012','Lakshmi Krishnan','Chennai','Tamil Nadu','Medium');

-- =========================
-- Insert into fact_sales (40 rows)
-- =========================

INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240101,1,1,2,50000,0,100000),
(20240102,2,2,1,30000,0,30000),
(20240103,3,3,3,5000,0,15000),
(20240104,4,4,1,60000,5000,55000),
(20240105,5,5,4,2000,0,8000),

(20240106,6,6,2,2500,0,5000),
(20240107,7,7,3,1200,0,3600),
(20240108,8,8,1,4500,0,4500),
(20240109,9,9,2,6000,0,12000),
(20240110,10,10,1,1800,0,1800),

(20240201,11,11,5,900,0,4500),
(20240202,12,12,3,700,0,2100),
(20240203,13,1,2,1500,0,3000),
(20240204,14,2,4,800,0,3200),
(20240205,15,3,1,1200,0,1200),

(20240206,1,4,1,50000,0,50000),
(20240207,2,5,2,30000,2000,58000),
(20240208,3,6,3,5000,0,15000),
(20240209,4,7,1,60000,5000,55000),
(20240210,5,8,2,2000,0,4000),

(20240101,6,9,3,2500,0,7500),
(20240102,7,10,2,1200,0,2400),
(20240103,8,11,1,4500,0,4500),
(20240104,9,12,2,6000,0,12000),
(20240105,10,1,3,1800,0,5400),

(20240106,11,2,4,900,0,3600),
(20240107,12,3,2,700,0,1400),
(20240108,13,4,1,1500,0,1500),
(20240109,14,5,5,800,0,4000),
(20240110,15,6,2,1200,0,2400),

(20240201,1,7,1,50000,0,50000),
(20240202,2,8,2,30000,2000,58000),
(20240203,3,9,3,5000,0,15000),
(20240204,4,10,1,60000,5000,55000),
(20240205,5,11,2,2000,0,4000);
