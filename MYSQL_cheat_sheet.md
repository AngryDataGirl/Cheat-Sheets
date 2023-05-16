# Contents
The cheat sheet contains helpful references to different commands you might need to work with an MySQL database. 
Items related to querying data will be in a query page (not the cheat sheet).

# Table of contents
1. [Creating Tables](#createtable)
2. [Creating Foreign Key on Existing Table](#createfk)
3. [Update](#update)
	1. [Toggling safe update mode](#safemode)
5. [Delete](#delete)
# Creating Tables <a name = "createtable"></a>

## Create table by copying all columns from another table**
```sql
CREATE TABLE new_table
  AS (SELECT * FROM old_table);
```
## **Create Table by copying selected columns from another table**
```sql
CREATE TABLE new_table
  AS (SELECT column_1, column2, ... column_n
      FROM old_table);
```
## **Create Table by copying selected columns from multiple tables**
```sql
CREATE TABLE new_table
  AS (SELECT column_1, column2, ... column_n
      FROM old_table_1, old_table_2, ... old_table_n);
```
## Create a table from another table without copying any of the values 
```sql 
CREATE TABLE new_table
  AS (SELECT *
      FROM old_table WHERE 1=2);
```

# Columns (add, modify, drop, rename) 

## Add a colum to a table
```sql
ALTER TABLE table_name
ADD column_name datatype;
```

## Modify a column in a table

## Drop a column in a table
Drop a single column
```sql
ALTER TABLE table_name
  DROP COLUMN column_name;
```
Drop multiple columns
```sql
ALTER TABLE table_name
DROP COLUMN column_name_1, column_name_2,...;
```

## Rename a column 
```sql
ALTER TABLE TableName
RENAME COLUMN OldColumnName TO NewColumnName;
```

# ALTER TABLE - ADD Column

To add a column in a table, use the following syntax:

ALTER TABLE *table_name*ADD *column_name datatype*;

The following SQL adds an "Email" column to the "Customers" table:

# Example

ALTER TABLE CustomersADD Email varchar(255);

# Create foreign key on existing table  <a name = "createfk"></a>

```sql
ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```

```sql
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```

# Toggle safe update mode <a name = "safemode"></a>
In action queries such as UPDATE or DELETE in MySQL Workbench (this is a workbench issue apparently, not MySQL itself), 
<br/>sometimes you will run into the following error and are not able to update or delete records in a table. 
<br/>This is likely caused by the default safe mode in MySQL. 

<b>Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.</b>

MySQL is trying to avoid accidental sweeping update/delete. 
<br/>The error will persists even when you do have WHERE clause in your query.

<b>To fix the problem, turn OFF the safe mode:</b>

```sql
<b>SET SQL_SAFE_UPDATES = 0;</b>
```
<b>turn ON the safe mode:</b>

```sql
SET SQL_SAFE_UPDATES=1;
```

# Delete 

## Delete records based on condition <a name = "delete"></a>
```sql
DELETE FROM table_name WHERE condition;
```
```sql
DELETE FROM Customers WHERE columnname ='xxxxx';
```
