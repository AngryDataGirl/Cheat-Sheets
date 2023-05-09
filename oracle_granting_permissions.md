## Procedure for granting select on all your tables to another user

```
begin
    for x in (select * from all_tables where owner = 'username')
    loop
        execute immediate 'grant create any view'||x.owner||'.'|| x.table_name || ' to ' || 'username';
    end loop;
end;

```

## Different commands for permissions

```
GRANT CREATE ANY VIEW TO username;
```
