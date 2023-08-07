# What does variable = . mean in SAS ? 
https://stackoverflow.com/questions/31078585/what-does-variable-variable-dot-mean-in-oracle-sql-sas

In addition SAS Missing values for character variables appear as blanks. Missing values are set like this for character: if name="none" then name=' '.

## generic format of proc sql query
```SAS
PROC SQL;
	SELECT *
	FROM LIB.TABLE_NAME
;
quit;
```

## limiting obs in proc sql query

```SAS
PROC SQL outobs = 20; create table test as
	SELECT *
	FROM LIB.TABLE_NAME
;
quit;
```

## grouping by a column to get max and formatting a column 

```SAS
proc sql;
	CREATE TABLE table_name AS  
	SELECT 
		column_name1,
		max(column_name2) as new_column_name2 format=datetime120.
	FROM table_name
	GROUP BY column_name1;
quit;
```



## print all variables from a library & their data types, data length, data format

```SAS
proc contents data=mylib._all_ noprint out=contents;
run;
```

note on variable types, not sure why this was so hard to find
https://support.sas.com/documentation/cdl/en/lrcon/62955/HTML/default/viewer.htm#a001103996.htm

- TYPE 1 is numeric 
- TYPE 2 is character


## cast char to numeric

The INPUT function is used to convert the character values in CharacterColumn to numeric values. The BEST12. format is used to define the desired numeric format for the output. You can adjust the format according to your specific requirements.

```sas
PROC SQL;
   CREATE TABLE NewTable AS
   SELECT INPUT(CharacterColumn, BEST12.) AS NumericColumn
   FROM YourTable;
QUIT;
```
- YourTable is the name of the table containing the character column you want to cast
- CharacterColumn is the name of the character column you want to convert
- NumericColumn is the name you want to give to the resulting numeric column in the new table NewTable.

### other formats

- BEST.: This format automatically determines the best width for the numeric variable based on the input data.
- COMMA.: This format adds commas to represent thousands separators in the numeric values.
- DOLLAR.: This format adds a dollar sign ($) and commas to represent thousands separators in the numeric values.
- MMDDYY.: This format converts character values in the format 'MMDDYY' to SAS date values.
- DATEw.: This format converts character values in the format 'YYYY-MM-DD' to SAS date values, where 'w' represents the width of the output.
- TIMEw.: This format converts character values in the format 'HH:MM:SS' to SAS time values, where 'w' represents the width of the output.
