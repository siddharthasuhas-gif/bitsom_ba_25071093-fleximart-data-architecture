# Database Schema Documentation – FlexiMart

## Entity–Relationship Description

This database is designed to store and manage customer orders and product sales data for the FlexiMart e-commerce platform. It consists of four main entities: customers, products, orders, and order_items. The design follows a relational model with clearly defined primary keys and foreign key relationships.

---

## ENTITY: customers

**Purpose:**  
Stores information about customers who register and place orders on the FlexiMart platform.

**Attributes:**
- **customer_id**: Unique identifier for each customer (Primary Key, auto-incremented)
- **first_name**: Customer’s first name
- **last_name**: Customer’s last name
- **email**: Customer’s email address (unique and mandatory)
- **phone**: Customer’s contact phone number
- **city**: City where the customer resides
- **registration_date**: Date when the customer registered on the platform

**Relationships:**
- One customer can place **many orders**  
  (One-to-Many relationship with the `orders` table)

---

## ENTITY: products

**Purpose:**  
Stores information about products available for sale on the FlexiMart platform.

**Attributes:**
- **product_id**: Unique identifier for each product (Primary Key, auto-incremented)
- **product_name**: Name of the product
- **category**: Category to which the product belongs (e.g., Electronics, Fashion)
- **price**: Selling price of the product
- **stock_quantity**: Number of units available in stock

**Relationships:**
- One product can appear in **many order items**  
  (One-to-Many relationship with the `order_items` table)

---

## ENTITY: orders

**Purpose:**  
Stores high-level information about each order placed by a customer.

**Attributes:**
- **order_id**: Unique identifier for each order (Primary Key, auto-incremented)
- **customer_id**: Identifier of the customer who placed the order (Foreign Key)
- **order_date**: Date when the order was placed
- **total_amount**: Total monetary value of the order
- **status**: Current status of the order (e.g., Pending, Completed)

**Relationships:**
- Each order belongs to **one customer**
- Each order can contain **many order items**

---

## ENTITY: order_items

**Purpose:**  
Stores detailed line-item information for each product included in an order.

**Attributes:**
- **order_item_id**: Unique identifier for each order item (Primary Key, auto-incremented)
- **order_id**: Identifier of the related order (Foreign Key)
- **product_id**: Identifier of the product purchased (Foreign Key)
- **quantity**: Number of units of the product ordered
- **unit_price**: Price per unit at the time of purchase
- **subtotal**: Total price for this item (quantity × unit_price)

**Relationships:**
- Each order item belongs to **one order**
- Each order item references **one product**





The FlexiMart database design follows the principles of Third Normal Form (3NF) to ensure data consistency, reduce redundancy, and avoid data anomalies.

In this design, each table has a primary key that uniquely identifies each record. All non-key attributes in a table are fully functionally dependent on the primary key. For example, in the `customers` table, attributes such as first_name, last_name, email, phone, city, and registration_date depend only on customer_id and not on any other attribute.

There are no partial dependencies because all tables use single-column primary keys. There are also no transitive dependencies. For instance, customer city is stored only in the `customers` table and not repeated in the `orders` table, ensuring that customer details are maintained in one place.

This design avoids update anomalies because customer or product information can be updated in one table without affecting order records. Insert anomalies are avoided because new customers or products can be added independently without requiring an order. Delete anomalies are avoided because deleting an order does not remove customer or product information.

By separating customers, products, orders, and order items into distinct tables with clear relationships, the database achieves 3NF and supports reliable, scalable transactional operations.



 Sample Data Representation

 customers

 customer_id  first_name  last_name   email                      city      registration_date 
  1           Rahul       Sharma     rahul.sharma@gmail.com     Bangalore  2023-01-15        
  2           Priya       Patel      priya.patel@yahoo.com      Mumbai     2023-02-20        



 products

 product_id  product_name            category      price     stock_quantity 

 1          Samsung Galaxy S21      Electronics   45999.00    150            
 2          Nike Running Shoes      Fashion        3499.00     80             



 orders

 order_id  customer_id  order_date  total_amount  status     

 1        1            2024-01-15  45999.00      Completed  
 2        2            2024-01-16  5998.00       Completed  



 order_items

 order_item_id  order_id  product_id  quantity  unit_price  subtotal 
 1             1         1           1         45999.00    45999.00 
 2             2         2           2         2999.00     5998.00  
