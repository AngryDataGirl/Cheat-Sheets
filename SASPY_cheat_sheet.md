# Saspy
[Official Documentation](https://sassoftware.github.io/saspy/)

## Installation

```python
# regular install
pip install saspy

# release:
pip install http://github.com/sassoftware/saspy/releases/saspy-X.X.X.tar.gz

# or, for a given branch (put the name of the branch after @)
pip install git+https://git@github.com/sassoftware/saspy.git@branchname

#The best way to update and existing deployment to the latest SASPy version is to simply uninstall and then install
pip uninstall -y saspy
pip install saspy
```

## Commands

### import
```python
import saspy
import pandas as pd
```

### start a SAS session
```python
sas = saspy.SASsession(cfgname='default')
```

# script to download big csv 

```
# this file is mean to extract data from large SAS tables and turn them into dataframes that we can work with 
import saspy 
import pandas as pd

# initialize sas session
sas = saspy.SASsession(cfgfile='\\sascfg_personal.py') # make sure this points to your sascfg file, for windows it would use winiomwin

# libref and table to connect to in SAS
SAS_table = 'SAS TABLE NAME'
SAS_libref = 'SAS LIBREF'

print(
    sas.exist(table = SAS_table , libref = SAS_libref)
)

year = 2023

# for loop to loop through dates in this scenario;

for y in range(2001,year+1):
    start_date = str('01JAN'+str(y)+':00:00:00')
    end_date = str('31DEC'+str(y)+':00:00:00')

    filter = str("DATE BETWEEN '"+start_date+"'dt and '"+end_date+"'dt")

    print(filter)

    df = sas.sasdata2dataframe(
        table = SAS_table,
        libref = SAS_libref,
        # method = 'CSV',
        dsopts = {
            'where': filter
            # 'obs': 10
            }
        )

    df.to_csv("C:\\Users\\AWENG\\Downloads\\FILENAME"+str(y)+".csv", encoding='utf-8', index=False)

```
