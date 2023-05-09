# Procedure for granting select on all your tables to another user
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
# Permisions 

### granting object privileges to a role
```sql
GRANT SELECT ON tablename TO username;
```

### granting create view to a role 
```
GRANT CREATE ANY VIEW TO username;
```
