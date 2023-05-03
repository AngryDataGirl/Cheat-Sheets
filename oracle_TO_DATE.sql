# Changing a string / varchar to date in Oracle, first instinct was to cast -- but why does cast not work ? 
# SQL Error: ORA-01861: literal does not match format string 01861
	# this error occurs because the nls portion of TO_DATE( string1 [, format_mask] [, nls_language] ) does not match the string you are trying to convert 

# example of some TO_DATE conversions
# for more formats, search for ORACLE FORMAT MASKS DATES

SELECT
  TO_DATE(sh.somedate1,'YYYY-MM-DD') AS somedate1,
  TO_DATE(sh.somedate2,'YYYY-MM') AS somedate2,
  TO_DATE(sh.somedate3,'YYYY-MM-DD HH24:MI:SS') AS somedate3, 
FROM 
  some_model 
