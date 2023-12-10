# Drop tables in loop

```sql
DO $$ 
  DECLARE 
    r RECORD;
BEGIN
  FOR r IN 
    (
		SELECT *
		FROM information_schema.tables
    WHERE table_schema = 'x' AND table_type = 'BASE TABLE'
    ) 
  LOOP
     EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.table_name) || ' CASCADE';
  END LOOP;
END $$ ;
```
