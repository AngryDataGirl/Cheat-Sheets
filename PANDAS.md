# Pandas Cheat Sheet

# selecting multiple columns
```python
df1 = df[['a', 'b']]
```
# selecting multiple columns through slice 
```python
# Remember, Python is zero-offset! The "third" entry is at slot two.
newdf = df[df.columns[2:4]]

# or ! 
columns = ['b', 'c']
df1 = pd.DataFrame(df, columns=columns)
```
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
