import pandas as pd
import mysql.connector

# =====================================================
# 1. EXTRACT – READ RAW CSV FILES
# =====================================================

customers = pd.read_csv("../data/customers_raw.csv")
products = pd.read_csv("../data/products_raw.csv")
sales = pd.read_csv("../data/sales_raw.csv")

# Keep original counts for report
customers_raw_count = len(customers)
products_raw_count = len(products)
sales_raw_count = len(sales)

# =====================================================
# 2. TRANSFORM – CLEAN DATA
# =====================================================

# ---------- CUSTOMERS CLEANING ----------

# Remove duplicate customers
customers.drop_duplicates(inplace=True)

# Remove customers with missing email
customers.dropna(subset=["email"], inplace=True)

# Standardize phone numbers → +91-XXXXXXXXXX
customers["phone"] = customers["phone"].astype(str)
customers["phone"] = customers["phone"].str.replace(r"\D", "", regex=True)
customers["phone"] = customers["phone"].str[-10:]
customers["phone"] = "+91-" + customers["phone"]
customers.loc[customers["phone"] == "+91-nan", "phone"] = None

# Fix registration date formats
customers["registration_date"] = pd.to_datetime(
    customers["registration_date"], errors="coerce"
).dt.date

customers.dropna(subset=["registration_date"], inplace=True)

# Standardize city names
customers["city"] = customers["city"].str.strip().str.title()

# ---------- PRODUCTS CLEANING ----------

# Standardize category names
products["category"] = products["category"].str.strip().str.title()

# Fill missing prices with average
products["price"].fillna(products["price"].mean(), inplace=True)

# Fill missing stock with 0
products["stock_quantity"].fillna(0, inplace=True)

# ---------- SALES CLEANING ----------

# Remove duplicate transactions (IMPORTANT FIX)
sales.drop_duplicates(subset=["transaction_id"], inplace=True)

# Remove rows with missing customer_id or product_id
sales.dropna(subset=["customer_id", "product_id"], inplace=True)

# Fix transaction date formats
sales["transaction_date"] = pd.to_datetime(
    sales["transaction_date"], errors="coerce"
).dt.date

sales.dropna(subset=["transaction_date"], inplace=True)

# =====================================================
# 3. LOAD – CONNECT TO MYSQL
# =====================================================

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",   # <-- CHANGE THIS
    database="fleximart"
)

cursor = conn.cursor()

# =====================================================
# 4. LOAD CUSTOMERS
# =====================================================

for _, row in customers.iterrows():
    cursor.execute("""
        INSERT INTO customers
        (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (
        row["first_name"],
        row["last_name"],
        row["email"],
        row["phone"],
        row["city"],
        row["registration_date"]
    ))

conn.commit()

# Create CUSTOMER ID MAP (email → customer_id)
cursor.execute("SELECT customer_id, email FROM customers")
customer_map = {email: cid for cid, email in cursor.fetchall()}

# =====================================================
# 5. LOAD PRODUCTS
# =====================================================

for _, row in products.iterrows():
    cursor.execute("""
        INSERT INTO products
        (product_name, category, price, stock_quantity)
        VALUES (%s, %s, %s, %s)
    """, (
        row["product_name"],
        row["category"],
        row["price"],
        row["stock_quantity"]
    ))

conn.commit()

# Create PRODUCT ID MAP (product_name → product_id)
cursor.execute("SELECT product_id, product_name FROM products")
product_map = {name: pid for pid, name in cursor.fetchall()}

# =====================================================
# 6. LOAD ORDERS
# =====================================================

order_id_map = {}

for _, row in sales.iterrows():
    customer_email = customers.loc[
        customers["customer_id"] == row["customer_id"], "email"
    ].values

    if len(customer_email) == 0:
        continue

    customer_id = customer_map.get(customer_email[0])
    if customer_id is None:
        continue

    total_amount = row["quantity"] * row["unit_price"]

    cursor.execute("""
        INSERT INTO orders
        (customer_id, order_date, total_amount, status)
        VALUES (%s, %s, %s, %s)
    """, (
        customer_id,
        row["transaction_date"],
        total_amount,
        row["status"]
    ))

    order_id_map[row["transaction_id"]] = cursor.lastrowid

conn.commit()

# =====================================================
# 7. LOAD ORDER ITEMS
# =====================================================

for _, row in sales.iterrows():
    order_id = order_id_map.get(row["transaction_id"])
    if order_id is None:
        continue

    product_name = products.loc[
        products["product_id"] == row["product_id"], "product_name"
    ].values

    if len(product_name) == 0:
        continue

    product_id = product_map.get(product_name[0])
    if product_id is None:
        continue

    subtotal = row["quantity"] * row["unit_price"]

    cursor.execute("""
        INSERT INTO order_items
        (order_id, product_id, quantity, unit_price, subtotal)
        VALUES (%s, %s, %s, %s, %s)
    """, (
        order_id,
        product_id,
        row["quantity"],
        row["unit_price"],
        subtotal
    ))

conn.commit()



# =====================================================
# 9. CLOSE CONNECTION
# =====================================================

cursor.close()
conn.close()

print("✅ ETL PROCESS COMPLETED SUCCESSFULLY")
