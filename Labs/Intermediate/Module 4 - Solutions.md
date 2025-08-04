# Module 4: Solutions

### Exercise 1: Analyzing an Inefficient Query - Solution

1. Execute the query and `EXPLAIN PLAN`:

```
EXPLAIN PLAN FOR
SELECT c.customer_name, a.account_number, a.balance, a.account_type
FROM Customers c
JOIN Bank_Accounts a ON c.customer_id = a.customer_id
WHERE c.customer_name = 'Alice Smith';

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());
```

#### Expected Output

-- TO BE FILLED

#### Observation:

- The `CUSTOMERS` table has `TABLE ACCESS FULL`. This means Oracle is scanning every row in the `Customers` table to find 'Alice Smith', which is inefficient for large tables.

- The `COST` might be relatively low for this small dataset, but in a production system with millions of customers, a full table scan would be very expensive.

2. Suggest if an index would be beneficial:

Yes, an index on `customer_name` would be highly beneficial. Since the `WHERE` clause filters on `customer_name`, an index would allow Oracle to quickly locate the specific row(s) without scanning the entire table.

### Exercise 2: Creating and Utilizing a B-tree Index - Solution

1. Create a B-tree index:

CREATE INDEX idx_customers_name ON Customers (customer_name);

2. Re-run the query from Exercise 1.

```
SELECT c.customer_name, a.account_number, a.balance, a.account_type
FROM Customers c
JOIN Bank_Accounts a ON c.customer_id = a.customer_id
WHERE c.customer_name = 'Alice Smith';
```

3. Run `EXPLAIN PLAN` again:

```
EXPLAIN PLAN FOR
SELECT c.customer_name, a.account_number, a.balance, a.account_type
FROM Customers c
JOIN Bank_Accounts a ON c.customer_id = a.customer_id
WHERE c.customer_name = 'Alice Smith';

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());
```

#### Expected Output

-- TO BE FILLED

#### Differences Noticed:

- Access Path for `Customers`: Changed from `TABLE ACCESS FULL` to `TABLE ACCESS BY INDEX ROWID` using `INDEX UNIQUE SCAN` (or `INDEX RANGE SCAN` if `customer_name` wasn't guaranteed unique). This indicates Oracle is now using the index to find the customer quickly.

- `COST`: The cost has likely decreased (e.g., from 7 to 4 in the example), showing improved efficiency.

- `CARDINALITY`: Remains the same for the specific row count, but the cost to retrieve it is lower.

### Exercise 3: Understanding Bitmap Indexes - Solution

1. Create a Bitmap index:

```
CREATE BITMAP INDEX idx_bank_accounts_type ON Bank_Accounts (account_type);
```

2. Execute the query and `EXPLAIN PLAN`:

```
EXPLAIN PLAN FOR
SELECT account_type, SUM(balance)
FROM Bank_Accounts
WHERE account_type = 'Savings' OR account_type = 'Checking'
GROUP BY account_type;

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());
```

#### Expected Output 

-- TO BE FILLED

#### Observation:

- You'll likely see operations involving `BITMAP INDEX SINGLE VALUE` and `BITMAP OR` or `BITMAP AND`. This demonstrates that Oracle is efficiently using the Bitmap index for queries involving multiple conditions on low-cardinality columns, especially with `OR` clauses.

- The `COST` for accessing `Bank_Accounts` might be lower than a full table scan for this type of query.

### Exercise 4: Identifying When Not to Index - Solution

1. `phone_number` in `Customers` (frequently updated):

A B-tree index on a frequently updated column like `phone_number` would generally be detrimental. While it would speed up `SELECT` queries that filter on `phone_number`, every `INSERT`, `UPDATE`, or `DELETE` operation on a row affecting the `phone_number` column would also require an update to the index itself. This adds overhead, consuming CPU and I/O resources, potentially slowing down DML operations more than the `SELECT` operations are sped up.

2. `branch_id` in `Bank_Accounts` (3 branches, millions of accounts):

- A B-tree index would likely not be the most effective choice for `branch_id` if there are only 3 distinct values but millions of accounts. B-tree indexes are best for high-cardinality columns (many distinct values). For low-cardinality columns, a B-tree index might still result in reading many index blocks to find the few distinct values, and then many data blocks.

- A Bitmap index would be more suitable. Bitmap indexes are highly efficient for low-cardinality columns, especially when combined with `OR` or `AND` conditions. They store a bitmap for each distinct value, with a bit set for each row that contains that value. This is very efficient for querying and combining conditions on such columns.

- Whether no index is suitable depends on query patterns. If `branch_id` is rarely used in `WHERE` clauses or joins, then no index might be acceptable. However, for a critical column like `branch_id` in a banking system, even with low cardinality, it's highly likely to be used frequently for reporting or transactional queries. Therefore, a Bitmap index would be the best choice here.