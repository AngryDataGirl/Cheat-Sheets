# DENSE RANK, RANK, ROW NUMBER 

<b>DENSE_RANK()</b> 
- Calculates the rank of a row in an ordered set of rows. 
- Rows with the same values for rank criteria will receive same rank values.
- Returns rank as consecutive integers and does not skip rank in case of ties. 

<b>RANK()</b>
- Calculates the rank of a row. 
- Rows with the same values will receive the the same rank values.
- Adds the number of tied rows to the tied rank, to calculate the next rank. Therefore, the rank may not be consecutive.

<b>ROW_NUMBER()</b>
- Assigns a sequential unique integer to each row that it is applied to (in the partition or the result set).

## Example of the differences between DENSE_RANK(), RANK() AND ROW_NUMBER()


| Example | Dense_Rank | Rank | Row_number |
| --- | --- | --- | ---|
| A | 1 | 1 | 1 |
| B | 2 | 2 | 2|
| B | 2 | 2 | 3|
| C | 3 | 4 | 4|
| D | 4 | 5 | 5|
| E | 5 | 6 | 6|
| F | 6 | 7 | 7|
| F | 6 | 7 | 8|
| F | 6 | 7 | 9|

## MYSQL FORMAT 
```sql
DENSE_RANK( ) | RANK() | ROW_NUMBER()  OVER (
    PARTITION BY <expression>[{,<expression>...}]
    ORDER BY <expression> [ASC|DESC], [{,<expression>...}]
)
```

## ORACLE FORMAT
```sql
DENSE_RANK( ) | RANK() | ROW_NUMBER()  OVER([ query_partition_clause ] order_by_clause)
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


