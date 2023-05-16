# Table of Contents
1. [What are window functions?](#what)
    1. [How is it different from GROUP BY?](#comparegroupby)
    2. [Why use it over GROUP BY?](#why)
2. [Ranking Window Functions](#ranking)
    1. [Dense Rank](#denserank)
    2. [Rank](#rank)
    3. [Row Number](#rownumber)
    4. [Ranking Functions Table](#rankingfunctionstable)
    5. [Syntax](#rankingsyntax)
3. [Positional Window Functions](#laglead)
    1. [Lag](#lag)
    2. [Lead](#lead)

# Window Functions <a name = "what"></a>
- Window functions applies aggregate and ranking functions over a particular window (set of rows). 
- OVER clause is used with window functions to define that window. 
    - The PARTITION  is where you create the group 
    - The ORDER BY clause orders rows within the partition / window into a particular order.
- if a partition is not provided, then ORDER BY will order all rows of table 


## How is this different from a group by ? <a name = "comparegroupby"></a>
- one of the best articles I've read https://towardsdatascience.com/a-guide-to-advanced-sql-window-functions-f63f2642cbf9
- Window functions are similar to the aggregation done in the GROUP BY clause. 
    - However, rows are not grouped into a single row, each row retains their separate identity. 
    - A window function may return a single value for each row. 

## Why use them? <a name = "why"></a>
- WHen you need to work with aggregate and non-aggregate values 
- when you need to compare one value to an aggregate value on a single record (since the window function does not collapse the records together)

# Ranking Window Functions <a name = "ranking"></a>

## DENSE RANK <a name = "denserank"></a>
- Calculates the rank of a row in an ordered set of rows. 
- Rows with the same values for rank criteria will receive same rank values.
- Returns rank as consecutive integers and does not skip rank in case of ties. 

## RANK <a name = "rank"></a>
- Calculates the rank of a row. 
- Rows with the same values will receive the the same rank values.
- Adds the number of tied rows to the tied rank, to calculate the next rank. Therefore, the rank may not be consecutive.

## ROW_NUMBER() <a name = "rownumber"></a>
- Assigns a sequential unique integer to each row that it is applied to (in the partition or the result set).

## Example of the differences between DENSE_RANK(), RANK() AND ROW_NUMBER() <a name = "rankingfunctionstable"></a>

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

## Syntax  <a name = "rankingsyntax"></a>

<b>MySQL</b>
```sql
DENSE_RANK( ) | RANK() | ROW_NUMBER()  OVER (
    PARTITION BY <expression>[{,<expression>...}]
    ORDER BY <expression> [ASC|DESC], [{,<expression>...}]
)
```
<b>Oracle</b>
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

# Positional Window Functions <a name = "laglead"></a>
## Lag <a name = "lag"></a>
## Lead <a name = "lead"></a>
