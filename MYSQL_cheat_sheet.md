# Table of contents
1. [Columns](#columns)
1. [Dates](#dates)
2. [Indexes](#indexes)
    1. [Sub paragraph](#subparagraph1)
3. [Another paragraph](#paragraph2)

# Columns (add, modify, drop, rename) <a name = "columns"></a>

# Create foreign key on existing table 

```sql
ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```

```sql
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```

# Toggle safe update mode
In action queries such as UPDATE or DELETE in MySQL Workbench (this is a workbench issue apparently, not MySQL itself), 
<br/>sometimes you will run into the following error and are not able to update or delete records in a table. 
<br/>This is likely caused by the default safe mode in MySQL. 

<b>Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.</b>

<br/>MySQL is trying to avoid accidental sweeping update/delete. 
<br/>The error will persists even when you do have WHERE clause in your query.

## To fix the problem, turn OFF the safe mode:

```sql
SET SQL_SAFE_UPDATES = 0;
```
## turn ON the safe mode:

```sql
SET SQL_SAFE_UPDATES=1;
```

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

