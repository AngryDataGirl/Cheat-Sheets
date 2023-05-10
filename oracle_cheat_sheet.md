# Table of contents
1. [Columns](#columns)
1. [Dates](#dates)
2. [Indexes](#indexes)
    1. [Sub paragraph](#subparagraph1)
3. [Another paragraph](#paragraph2)

# Columns (add, modify, drop, rename) <a name = "columns"></a>

## add a column to your table 
```sql
ALTER TABLE my_table ADD (new_col DATE);
```

## modify old column value  
Set this new column's value to hold the old_column's value converted to a DATE value.
```sql
UPDATE my_table SET new_col=TO_DATE(old_col,'MM/DD/YYYY');
``` 
Update format mask as needed. 

## drop the old column.
```sql
ALTER TABLE my_table DROP (old_col);
```

## rename new column to old column 
```sql
ALTER TABLE my_table RENAME new_col TO old_col;
``` 


# dates <a name = "dates"></a>

## TO_DATE and format mask 
<br/>for more formats, search for ORACLE FORMAT MASKS DATES
<br/>Changing a string / varchar to date in Oracle, first instinct was to cast -- but why does cast not work ? 
<br/>SQL Error: ORA-01861: literal does not match format string 01861
	<br/>  this error occurs because the nls portion of TO_DATE( string1 [, format_mask] [, nls_language] ) does not match the string you are trying to convert 
```sql
SELECT
  TO_DATE(sh.somedate1,'YYYY-MM-DD') AS somedate1,
  TO_DATE(sh.somedate2,'YYYY-MM') AS somedate2,
  TO_DATE(sh.somedate3,'YYYY-MM-DD HH24:MI:SS') AS somedate3, 
FROM 
  some_model 
```

# indexes <a name = "indexes"></a>

## view all existing indexes
```sql
SELECT * 
FROM all_indexes
-- WHERE owner = 'user'
```
## creating indexes
```sql
create index <index_name> on <table_name> ( <column1>, <column2>, … );
```
## dropping indexes
```sql
DROP INDEX [schema_name.]index_name;
```

## drop index if it exists
```sql
DECLARE index_count INTEGER;
BEGIN
SELECT COUNT(*) INTO index_count
    FROM USER_INDEXES
    WHERE INDEX_NAME = 'index_name';

IF index_count > 0 THEN
    EXECUTE IMMEDIATE 'DROP INDEX index_name';
END IF;
END;
```

