# NoSQL Justification Report – FlexiMart

## Section A: Limitations of RDBMS (150 words)

Relational databases such as MySQL are designed with a fixed schema, which makes them less suitable for highly diverse product data. In an e-commerce system like FlexiMart, different product types have different attributes. For example, laptops require fields such as RAM, processor, and storage, while shoes require size, color, and material. In a relational model, accommodating these differences would require either many nullable columns or multiple separate tables, increasing complexity and reducing efficiency.

Frequent schema changes are another limitation. Adding new product types or attributes requires altering table structures, which can be time-consuming and risky in a production environment. Each schema change may impact existing queries and applications.

Additionally, storing customer reviews in a relational database is difficult because reviews are naturally hierarchical. Representing reviews would require separate tables and complex joins, making data retrieval slower and harder to manage compared to nested structures.

---

## Section B: NoSQL Benefits (150 words)

MongoDB addresses these challenges by using a flexible, document-based schema. Each product can store only the attributes relevant to its type, allowing laptops and shoes to coexist in the same collection without unused or null fields. This flexibility enables faster development and easier adaptation when new product categories are introduced.

MongoDB supports embedded documents, which allows customer reviews to be stored directly inside the product document. This structure closely matches real-world data and enables faster read operations because reviews can be retrieved without joining multiple tables.

Another major advantage is horizontal scalability. MongoDB is designed to scale across multiple servers using sharding, making it suitable for large and growing product catalogs. As FlexiMart expands, MongoDB can handle increasing data volume and traffic efficiently, which is more challenging to achieve with traditional relational databases.

---

## Section C: Trade-offs (100 words)

Despite its advantages, MongoDB has certain disadvantages compared to MySQL. One limitation is weaker support for complex transactions. While MongoDB supports transactions, relational databases still provide more mature and reliable transactional consistency for financial operations.

Another drawback is the lack of enforced schema and constraints. Without strict schemas, there is a risk of inconsistent data if validation rules are not carefully implemented. This can make data governance and reporting more challenging. Therefore, while MongoDB is ideal for flexible product catalogs, MySQL remains better suited for transactional systems requiring strong consistency.
