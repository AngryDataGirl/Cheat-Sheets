print all variables from a library & their data types, data length, data format

```SAS
proc contents data=mylib._all_ noprint out=contents;
run;
```

note on variable types, not sure why this was so hard to find
https://support.sas.com/documentation/cdl/en/lrcon/62955/HTML/default/viewer.htm#a001103996.htm

- TYPE 1 is numeric 
- TYPE 2 is character
