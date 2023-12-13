# Pandas Cheat Sheet

# CSV

## example snippet
```python
import pandas as pd
import numpy as np
import os

# See current directory
print(os.getcwd())

# Provide the new path here
os.chdir('C:\\Users\\USERNAME\\Downloads')  

# read csv 
df = pd.read_csv('test.csv',low_memory=False) # low memory will help with super large dataframes and datatype conversion errors 
```
## read csv
```python
df = pd.read_csv('filename.csv')
```
## read csv with specific separator
```python
df = pd.read_csv("data2.csv", sep='|')
```
## write csv
```python
df.to_csv(file_name, sep='\t')
```
## write csv with specific encoding 
```python
df.to_csv(file_name, sep='\t', encoding='utf-8')
```

# remove display limit

```python
pd.set_option("display.max_rows", None, "display.max_columns", None)
```

# summary info

```python
df.info(), df.head(), df.shape, df.dtypes
```
# row manipulation

## remove top row
```python
df.columns = df.iloc[0]
```
you can also pass it to header when reading csv like this 
```python
df = pd.read_csv("Prices.csv", header=0)
```

# column manipulation 

## selecting multiple columns
```python
df1 = df[['a', 'b']]
```
## selecting multiple columns through slice 
```python
# Remember, Python is zero-offset! The "third" entry is at slot two.
newdf = df[df.columns[2:4]]

# or ! 
columns = ['b', 'c']
df1 = pd.DataFrame(df, columns=columns)
```
### selecting columns with columns list / subset of list 
1. where df is the dataframe and lst is the lst of columns 
```python
(df.columns.intersection(lst))
```
or 
```python
df[df.columns & lst]
```
2. list comprehension

```python
 df[[c for c in df.columns if c in lst]]
```

# filtering

## testing if column meets certain condition
```python
df['indicator'] = df[columns].ne(0).any(axis=1)
```
## filtering out NAN or Nulls
```python
filtered_df = df[df['a'].notnull()]
```
## filtering out NAN from multiple columns
```python
filtered_df = df[df[['a', 'b', 'c']].notnull().all(1)]
```
## dropping columns with NAN or nulls with threshold
- ie, if threshold 2 then all rows with at least 2 NAN or nulls will get dropped 
```python
df.dropna(thresh=2)
```

# aggregation 

## counting specific values acrossc multiple columns

```python
df[df == 'x'].count()
```

## pivot table
- note that equivalent to SUM (CASE WHEN) in SQL 
```python
 df1=pd.pivot_table(df, index=['x','y'],values=['a','b','c'],aggfunc=np.sum)
```

## conditional sum & group by 
https://stackoverflow.com/questions/17266129/conditional-sum-with-groupby

```python
# First groupby the key1 column:
g = df.groupby('key1')

# and then for each group take the subDataFrame where key2 equals 'one' and sum the data1 column:
g.apply(lambda x: x[x['key2'] == 'one']['data1'].sum())
```

# dataframe manipulation
# df.merge()

```python
pandas.merge(
  left, right,
  how='inner',
  on=None,
  left_on=None, right_on=None,
  left_index=False, right_index=False,
  sort=False,
  suffixes=('_x', '_y'),
  copy=None,
  indicator=False,
  validate=None)
```
ex.
```python
df1.merge(df2, how='left', on='a')
```

# For Loops and Dataframes 

## .append()

```python
all_res = []
for df in df_all:
    for i in substr:
        res = df[df['url'].str.contains(i)]
        all_res.append(res)

df_res = pd.concat(all_res)
```

## .merge()

Create an empty DataFrame with the columns to prevent the "key error: Code"
```python
df = pd.DataFrame(columns=['Code']) 
then in the loop, you

df.merge(my_value, on='Code', how='outer') 
after my_value is created
```
ex, 
```python
# create empty data frame or dataframe with index 
df = pd.dataframe()

for x in x_list:
    for y in y_list:
        # create dataframe result in loop
        # merge in the loop
        df = df.merge(res, on = 'x', how = 'left')
```
