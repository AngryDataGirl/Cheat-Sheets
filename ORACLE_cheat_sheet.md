# Table of contents
1. [Oracle Service Name](#find-oracle-service-name)
2. [Tables](#tables)
	- [View all tables](#view-all-tables) 
3. [Columns](#columns)
	- [Search for specific columns](#search-for-specific-columns)
5. [Dates](#dates)
    1. [Format Mask](#dateformatmask)
6. [Indexes](#indexes)
    1. [Sub paragraph](#subparagraph1)
7. [Grant](#grant)
8. [Datatypes](#datatypes)
9. [Strings](#strings)
10. [Loops](#loops)


# Find Oracle service name
Helpful for trying to find the connection information required to set up other connections (ie, through python).

```sql
select * from global_name;
```

# Tables

## View all tables or view all user views 
Helpful when trying to:
- understand what tables or v iews are within a schema
- find table names or view names within a schema

```sql
SELECT *
FROM all_tables;
```
```sql
SELECT view_name
FROM user_views;
```

# Columns

## Search DB for specific columns

To find all tables with a particular column when you know the column name:

```sql
select owner, table_name from all_tab_columns where column_name = 'ID';
```
To find tables that have any or all of the 4 columns:

```sql
select owner, table_name, column_name
from all_tab_columns
where column_name in ('ID', 'FNAME', 'LNAME', 'ADDRESS');

```
To find tables that have all 4 columns (with none missing):

```sql
select owner, table_name
from all_tab_columns
where column_name in ('ID', 'FNAME', 'LNAME', 'ADDRESS')
group by owner, table_name
having count(*) = 4;
```

# find tables with specific column name in oracle 

## A. Tables accessible to the current user
```sql
select t.owner as schema_name,
       t.table_name
from sys.all_tab_columns col
inner join sys.all_tables t on col.owner = t.owner 
                              and col.table_name = t.table_name
where col.column_name = 'QUANTITY_BILLED'
-- excluding some Oracle maintained schemas
and col.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS', 
   'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN', 
   'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
   'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 
   'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
   'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC', 'WKSYS')
order by col.owner, 
         col.table_name;
```

## B. If you have privilege on dba_tab_columns and dba_tables

```sql
select t.owner as schema_name,
       t.table_name
from sys.dba_tab_columns col
inner join sys.dba_tables t on col.owner = t.owner 
                              and col.table_name = t.table_name
where col.column_name = 'QUANTITY_BILLED'
-- excluding some Oracle maintained schemas
and col.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS', 
   'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN', 
   'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
   'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 
   'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
   'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC', 'WKSYS')
order by col.owner, 
         col.table_name;
```

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

## TO_DATE and 
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
## format mask table <a name = "dateformatmask"></a>
| Parameter | Explanation |
| ----|----|
|YEAR|Year, spelled out
|YYYY|4-digit year
|YYY, YY, Y|Last 3, 2, or 1 digit(s) of year.
|IYY, IY, I|Last 3, 2, or 1 digit(s) of ISO year.
|IYYY|4-digit year based on the ISO standard
|RRRR|	Accepts a 2-digit year and returns a 4-digit year. <br/>A value between 0-49 will return a 20xx year.<br/>A value between 50-99 will return a 19xx year.
|Q|	Quarter of year (1, 2, 3, 4; JAN-MAR = 1).
|MM|	Month (01-12; JAN = 01).
|MON|	Abbreviated name of month.
|MONTH|	Name of month, padded with blanks to length of 9 characters.
|RM|	Roman numeral month (I-XII; JAN = I).
|WW|	Week of year (1-53) where week 1 starts on the first day of the year and continues to the seventh day of the year.
|W|	Week of month (1-5) where week 1 starts on the first day of the month and ends on the seventh.
|IW|	Week of year (1-52 or 1-53) based on the ISO standard.
|D|	Day of week (1-7).
|DAY|	Name of day.
|DD|	Day of month (1-31).
|DDD|	Day of year (1-366).
|DY|	Abbreviated name of day.
|J|	Julian day; the number of days since January 1, 4712 BC.
|HH|	Hour of day (1-12).
|HH12|	Hour of day (1-12).
|HH24|	Hour of day (0-23).
|MI|	Minute (0-59).
|SS|	Second (0-59).
|SSSSS|	Seconds past midnight (0-86399).
|AM, A.M., PM, or P.M.|	Meridian indicator
|AD or A.D|	AD indicator
|BC or B.C.|	BC indicator
|TZD|	Daylight savings information. For example, 'PST'
|TZH, TZM, TZR |Time zone hour, Time zone minute, Time zone region.

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
# grant  <a name = "grant"></a>

## Procedure for granting select on all your view / tables to another user
```sql
begin
    for x in (select * from all_views/all_tables where owner = 'replace this with USER NAME 1 that owns table')
    loop
        execute immediate 'GRANT SELECT ON '||x.owner||'.'|| x.view_name || ' to ' || 'replace this with USER NAME that view is to be granted to';
    end loop;
end;
```
## privilege levels  
no comma needed around username! 

### granting object privileges to a role
```sql
GRANT SELECT ON tablename TO username;
```

### granting object privileges WITH GRANT OPTION
- When receiving error ORA-01720: grant option does not exist for 'table_name'

```sql
GRANT SELECT ON schema.table_name TO username WITH GRANT OPTION;
```

### granting create view to a role 
```
GRANT CREATE ANY VIEW TO username;
```
# Datatypes <a name = "datatypes"></a>

## datatype codes
https://docs.oracle.com/cd/A58617_01/server.804/a58234/datatype.htm

| Internal Oracle Datatype| Maximum Internal Length | Datatype Code |
| ----|----|----|
|VARCHAR2  |4000 bytes  |1  |
|NUMBER    |21 bytes    |2 |
|DATE    |7 bytes    |12   |
|CHAR  |2000 bytes  |96  |
|RAW  |2000 bytes |23|  
  
# Strings <a name = "strings"></a>

## apostrophes within strings

[Oracle / PLSQL: Dealing with apostrophes/single quotes in strings (techonthenet.com)](https://www.techonthenet.com/oracle/questions/quotes.php#:~:text=Answer%3A%20Now%20it%20is%20first%20important%20to%20remember,where%20the%20quote%20is%20located%20in%20the%20string.)

**Question:** How can I handle apostrophes and single quotes in strings? As you know, single quotes start and terminate strings in SQL.

**Answer:** Now it is first important to remember that in Oracle, you enclose strings in single quotes. The first quote denotes the beginning of the string and the second quote denotes the termination of the string.

If you need to deal with apostrophes/single quotes in strings, your solution depends on where the quote is located in the string.

We'll take a look at 4 scenarios where you might want to place an apostrophe or single quote in a string.

## **Apostrophe/single quote at start of string**

When the apostrophe/single quote is at the start of the string, you need to enter 3 single quotes for Oracle to display a quote symbol. For example:

```
SELECT '''Hi There'
FROM dual;
```

would return

```
'Hi There
```

## **Apostrophe/single quote in the middle of a string**

When the apostrophe/single quote is in the middle of the string, you need to enter 2 single quotes for Oracle to display a quote symbol. For example:

```
SELECT 'He''s always the first to arrive'
FROM dual;
```

would return

```
He's always the first to arrive
```

## **Apostrophe/single quote at the end of a string**

When the apostrophe/single quote is at the end of a string, you need to enter 3 single quotes for Oracle to display a quote symbol. For example:

```
SELECT 'Smiths'''
FROM dual;
```

would return

```
Smiths'
```

## **Apostrophe/single quote in a concatenated string**

If you were to concatenate an apostrophe/single quote in a string, you need to enter 4 single quotes for Oracle to display a quote symbol. For example:

```
SELECT 'There' || '''' || 's Henry'
FROM dual;
```

would return

```
There's Henry
```

## susbtring
https://docs.oracle.com/database/121/SQLRF/functions196.htm#SQLRF06114

```sql
SUBSTR( str, start_position [, substring_length, [, occurrence ]] );
```
The SUBSTR() function accepts three arguments:
- str: STR that you want to extract the substring from. The data type of str can be CHAR, VARCHAR2, NCHAR, NVARCHAR2, CLOB, or NCLOB.
- start_position: INT that determines where the substring starts.
	- 0, substring will start at first character of the str.
 	- start_position is positive, the SUBSTR() function will count from the beginning of the str.
	- start_position is negative, then the SUBSTR() function will count backward from the end of the str .
- substring_length: the number of characters in the substring.
	- If omitted, the SUBSTR() function returns all characters starting from the start_position.
 	- In case the substring_length is less than 1, the SUBSTR() function returns null.
 
## instring
https://docs.oracle.com/database/121/SQLRF/functions196.htm#SQLRF06114

```sql
SELECT INSTR('CORPORATE FLOOR','OR', 3, 2) "Instring"
  FROM DUAL;
 
  Instring
----------
        14
```

## reversed instring
```sql
SELECT INSTR('CORPORATE FLOOR','OR', -3, 2) "Reversed Instring"
  FROM DUAL;
 
Reversed Instring
-----------------
                2
```

# Loops

## Create views

```sql
begin
    for x in (
        SELECT * 
        FROM all_tables 
        WHERE owner = 'PIDAR_RPT' AND (
--            table_name LIKE '%M1%'
--            OR 
--            table_name LIKE '%M2%'
--            OR 
            table_name LIKE '%M3%'
            )
            )
    loop
        execute immediate 'CREATE VIEW '||x.table_name||' AS (SELECT * FROM '||x.owner||'.'|| x.table_name||')';
    end loop;
end;```

## Grant permissions
```sql
begin
    for x in (
        SELECT * 
        FROM all_views 
        WHERE owner = 'PIDAR'
        AND view_name LIKE '%M1%'
        OR view_name LIKE '%M2%'
        OR view_name LIKE '%M3%' /*OR view_name LIKE '%M2%'*/)
    loop
        execute immediate 'GRANT SELECT ON '||x.owner||'.'|| x.view_name || ' to ' || 'USER2';
    end loop;
end;```

## Drop tables
```sql
begin
  for i in (
    SELECT 'drop view '||view_name||' cascade constraints' tbl 
    FROM user_views 
    WHERE 
--        table_name LIKE '%something%'
--        OR 
--        table_name LIKE '%something%'
--        OR 
        view_name LIKE '%something%'
        ) 
  loop
     execute immediate i.tbl;
  end loop;
end;
```

