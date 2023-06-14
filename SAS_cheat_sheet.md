print all variables from a library & their data types, data length, data format

```SAS
proc contents data=mylib._all_ noprint out=contents;
run;
```
