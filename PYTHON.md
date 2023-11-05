
- [Dictionaries](#dictionaries)
  - [Creating a dictionary](#creating-a-dictionary)
  - [Keys](#keys)
    - [view all keys](#view-all-keys)
  - [Values](#values)
    - [view all values](#view-all-values)
    - [access values](#access-values)
    - [access single value with a key](#access-single-value-with-a-key)
    - [access single value with a key that does not exist](#access-single-value-with-a-key-that-does-not-exist)
    - [use get() to access value](#use-get-to-access-value)
  - [add values](#add-values)
    - [add value to dictionary](#add-value-to-dictionary)
    - [add value to dictionray in a for loop](#add-value-to-dictionray-in-a-for-loop)
    - [increment count of value in dictionary](#increment-count-of-value-in-dictionary)
  - [methods for deleting values](#methods-for-deleting-values)
    - [with keyword DEL](#with-keyword-del)
    - [using pop](#using-pop)
    - [using popitem()](#using-popitem)
  - [Keys and Values](#keys-and-values)
    - [view all key value pairs](#view-all-key-value-pairs)
    - [find number of key value pairs](#find-number-of-key-value-pairs)
- [Strings](#strings)
  - [replace()](#replace)


# Dictionaries 

## Creating a dictionary 
```python
#create an empty dictionary
my_dictionary = {} 

# to view
print(my_dictionary) 

#to check the data type use the type() function
print(type(my_dictionary))
```

## Keys
- keys can only be immutable datatypes: integers, strings, tuples, floating point numbers, and booleans.
- mutable: sets, lists, or dictionaries

### view all keys 
```sql
print(my_dictionary.keys())
```

## Values
### view all values 
```python
print(my_dictionary.values())
```
### access values
### access single value with a key
```python
#access the value associated with the given key
print(my_dictionary['key_name'])
```
### access single value with a key that does not exist 
results in a KeyError 
```python
# One way to avoid this from happening is to first search to see if the key is in the dictionary in the first place.
my_dictionary = {'key1': 'value1', 'key2': value2, 'key3': 'value3'}

#search for the 'key4' key
print('key4' in my_information)

# will return False since there is no Key4
```
### use get() to access value 
```python
print(my_dictionary.get('value4'))
# returns none if it does not exist

print(my_dictionary.get(), 'This value does not exist'))
#returns message instead of None
```
## add values

### add value to dictionary
- if key already exists in the dictionary and the key will end up being updated with the new value.
- remember that keys need to be unique.
```python
# method 1
dictionary_name[key] = value

# method 2: built in update
my_dictionary.update(key1= 'value1', key2 = value2, key3 = "value3")
```
### add value to dictionray in a for loop

```sql
for x in item_to_be_looped:
  if x in dictionary:
    dictionary[x] = value 
```
### increment count of value in dictionary

```sql
for x in item_to_be_looped:
  if x in dictionary:
    dictionary[x] += value 
```
## methods for deleting values 
- keyword DEL
- pop()
- popitem()

### with keyword DEL
```python
# using keyword
del dictionary_name[key]
```
### using pop
this will remove the key, but save the removed value 
```python
dictionary_name.pop(key)

# to avoid KeyError and return custom message on error
my_information.pop('nonexistant_key','Not found')
```

### using popitem()
popitem() method takes no arguments, removes and returns the last key-value pair from a dictionary.
```python 
my_dictionary.update(key1= 'value1', key2 = value2, key3 = "value3")
popped_item = my_information.popitem()
# returns (key3 = "value3")
```
## Keys and Values

### view all key value pairs
```python
print(my_dictionary.items())
```
### find number of key value pairs
```python
print(len(my_dictionary))
```

# Strings

## replace()

```python
x.replace(".", "[.]")
``` 