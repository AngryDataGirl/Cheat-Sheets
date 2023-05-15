# Table of contents
1. [Create](#create)
1. [Update](#update)
3. [Delete](#delete)

# Columns (add, modify, drop, rename) <a name = "columns"></a>

# Create <a name = "create"></a>
## Create foreign key on existing table 

```sql
ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```

```sql
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```

# Update <a name = "update"></a>
## Toggle safe update mode
In action queries such as UPDATE or DELETE in MySQL Workbench (this is a workbench issue apparently, not MySQL itself), 
<br/>sometimes you will run into the following error and are not able to update or delete records in a table. 
<br/>This is likely caused by the default safe mode in MySQL. 

<b>Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.</b>

<br/>MySQL is trying to avoid accidental sweeping update/delete. 
<br/>The error will persists even when you do have WHERE clause in your query.

<b>To fix the problem, turn OFF the safe mode:</b>

```sql
<b>SET SQL_SAFE_UPDATES = 0;</b>
```
## turn ON the safe mode:

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
