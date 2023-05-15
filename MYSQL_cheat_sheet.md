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

