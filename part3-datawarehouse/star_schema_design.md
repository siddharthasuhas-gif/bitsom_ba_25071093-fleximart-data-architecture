# Star Schema Design – FlexiMart Data Warehouse

## Section 1: Schema Overview

The FlexiMart data warehouse is designed using a star schema to support analytical reporting and historical sales analysis. The schema consists of one fact table surrounded by three dimension tables.

### FACT TABLE: fact_sales

**Grain:**  
One row per product per order line item.

**Business Process:**  
Sales transactions.

**Measures (Numeric Facts):**
- **quantity_sold:** Number of units sold in a transaction
- **unit_price:** Price per unit at the time of sale
- **discount_amount:** Discount applied to the transaction
- **total_amount:** Final sales amount (quantity × unit_price − discount)

**Foreign Keys:**
- **date_key → dim_date**
- **product_key → dim_product**
- **customer_key → dim_customer**

---

### DIMENSION TABLE: dim_date

**Purpose:**  
Stores date-related information to support time-based analysis.

**Type:**  
Conformed dimension.

**Attributes:**
- **date_key (PK):** Surrogate key in YYYYMMDD format
- **full_date:** Actual calendar date
- **day_of_week:** Day name (Monday, Tuesday, etc.)
- **day_of_month:** Day number in the month
- **month:** Month number (1–12)
- **month_name:** Month name (January, February, etc.)
- **quarter:** Quarter of the year (Q1–Q4)
- **year:** Calendar year
- **is_weekend:** Indicates whether the date is a weekend

---

### DIMENSION TABLE: dim_product

**Purpose:**  
Stores descriptive information about products.

**Attributes:**
- **product_key (PK):** Surrogate key
- **product_id:** Original product identifier from source system
- **product_name:** Name of the product
- **category:** Product category (Electronics, Fashion, etc.)
- **subcategory:** Product subcategory
- **unit_price:** Standard price of the product

---

### DIMENSION TABLE: dim_customer

**Purpose:**  
Stores descriptive information about customers.

**Attributes:**
- **customer_key (PK):** Surrogate key
- **customer_id:** Original customer identifier from source system
- **customer_name:** Full name of the customer
- **city:** City of residence
- **state:** State of residence
- **customer_segment:** Customer classification (High, Medium, Low value)

---

## Section 2: Design Decisions (150 words)

The star schema is designed at the transaction line-item level, meaning each record in the fact table represents one product sold in one order. This granularity allows detailed analysis such as product-level sales, customer purchasing behavior, and time-based trends. It also supports flexible aggregation for reporting at daily, monthly, or yearly levels.

Surrogate keys are used instead of natural keys to improve performance and simplify joins. Numeric surrogate keys are smaller, faster to join, and remain stable even if source system identifiers change. This ensures consistency and scalability in the data warehouse.

The design supports drill-down and roll-up operations effectively. Analysts can roll up sales data from day to month, quarter, or year using the date dimension, and drill down from high-level summaries to individual transactions. Similarly, product and customer dimensions allow analysis by category, subcategory, city, or customer segment.

---

## Section 3: Sample Data Flow

**Source Transaction:**  
Order #101, Customer “John Doe”, Product “Laptop”, Quantity: 2, Price: ₹50,000

**Data Warehouse Representation:**

**fact_sales:**  
- date_key: 20240115  
- product_key: 5  
- customer_key: 12  
- quantity_sold: 2  
- unit_price: 50000  
- total_amount: 100000  

**dim_date:**  
- date_key: 20240115  
- full_date: 2024-01-15  
- month: 1  
- quarter: Q1  

**dim_product:**  
- product_key: 5  
- product_name: Laptop  
- category: Electronics  

**dim_customer:**  
- customer_key: 12  
- customer_name: John Doe  
- city: Mumbai  
