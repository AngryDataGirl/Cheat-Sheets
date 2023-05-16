# What is a CTE?
A CTE is a named subquery that appears at the top of a query in a WITH clause, which can contain multiple CTEs separated by commas.
<br> The benefits of a CTE are:
- makes queries more readable by organizing long / complex queries with multiple steps 
- CTEs can be reused, CTE can refer to any other CTE defined above it in the same WITH clause

## Syntax: 
```sql
WITH cte1 AS 
(
  query_block
)
, 
cte2 AS 
(
  query_block
)

SELECT * 
FROM cte1
LEFT JOIN cte2 
  ON cte1.something = cte2.something 
```

# What is a recursive CTE?
there are also non-recursive and recursive CTEs, the latter really unlocks the power of CTEs and are useful when processing hierarchical structures such as trees and graphs 


## Syntax
```sql
WITH RECURSIVE cte_name AS
(
  CTE_auxiliary_query_1   -- non-recursive term
  UNION [ALL]
  CTE_auxiliary_query_2   -- recursive term
) 

CTE_primary_query;
```
## example 1: generating numbers 1 through 10
```sql
WITH RECURSIVE nums_consecutive AS 
(
  SELECT 1 AS num
  UNION ALL
  SELECT num + 1 FROM nums_consecutive WHERE num < 10
) 

SELECT * FROM nums_consecutive;
```

Some good examples and explanations on the subject: 

[https://dev.mysql.com/doc/refman/8.0/en/with.html](https://dev.mysql.com/doc/refman/8.0/en/with.html)

[https://leetcode.com/discuss/study-guide/1600722/database-sql-primer-part-3-common-table-expressions-ctes](https://leetcode.com/discuss/study-guide/1600722/database-sql-primer-part-3-common-table-expressions-ctes)

[https://leetcode.com/discuss/study-guide/1601295/database-sql-primer-part-4-recursive-ctes](https://leetcode.com/discuss/study-guide/1601295/database-sql-primer-part-4-recursive-ctes)
