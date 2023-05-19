# Table of contents
1. [Columns](#columns)
1. [Dates](#dates)
    1. [Format Mask](#dateformatmask)
3. [Indexes](#indexes)
    1. [Sub paragraph](#subparagraph1)
4. [Grant](#grant)

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

## Procedure for granting select on all your tables to another user
look up documentation on ORACLE for GRANT 
</br>https://docs.oracle.com/en/database/oracle/oracle-database/18/sqlrf/GRANT.html#GUID-20B4E2C0-A7F8-4BC8-A5E8-BE61BDC41AC3

```
begin
    for x in (select * from all_tables where owner = 'username')
    loop
        execute immediate 'GRANT SELECT ON '||x.owner||'.'|| x.table_name || ' to ' || 'username';
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

