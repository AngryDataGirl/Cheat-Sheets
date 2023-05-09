# RANK, DENSE RANK, ROW NUMBER 
## ORACLE FORMAT
```sql
ROW_NUMBER() | RANK() | DENSE_RANK( ) OVER([ query_partition_clause ] order_by_clause)
```
where the partition by clause looks like this, note that it can be ommitted if you do not want to partition
```sql
PARTITION BY expression1 [,expression2, ...]
``` 
where the order by clause looks like this
```sql
ORDER BY expression1 [,expression2,...] [ASC | DESC ] [NULLS FIRST | LAST]
```
example
```sql
DENSE_RANK( ) OVER(PARTITION BY some_id, some_name ORDER BY some_date)
RANK( ) OVER(PARTITION BY some_id, some_name ORDER BY some_date)
ROW_NUMBER( ) OVER(PARTITION BY some_id, some_name ORDER BY some_date)
```
## AND ROW_NUMBER()

# ORACLE
## RANK()
## DENSE_RANK()
## AND ROW_NUMBER()
