# Data Structures

Order in which to learn
- [Arrays](#arrays)
- Strings
- Matrix
- Maths
- Stack
- Queue
- Recursion
- Searching and Sorting
- Linked List
- Binary Trees and Binary Search Trees
- Asymptotic analysis (Big-O notation)

## Arrays
- a collection of elements that are stored in a contiguous block of memory.
- can be one-dimensional or multi-dimensional and their length is fixed.
- Array elements must be of the same type, for example, a character array can only store characters and an integer array can only store integers.
- *This makes it easier to calculate the position of each element by simply adding an offset to a base value, i.e., the memory location of the first element of the array (generally denoted by the name of the array).*
- _Python does not have built-in support for Arrays, but Python Lists can be used instead_

### Array Concepts

- **array index**
    - elements are identified by their index
    - array index starts from 0
- **array element**
    - elements are items stored in an array
    - can be accessed by their index
- **array length**
    - length determined by number of elements it can contain

```sql
arr = [10, 20, 30]  # This array will store integer
arr2 = ['c', 'd', 'e']  # This array will store characters
arr3 = [28.5, 36.5, 40.2]  # This array will store floating elements
```
#### types of arrays

This is a 1 dimensional array

|A|A|B|S|
|-|-|-|-|

This is a 1 dimensional array with the index below

|element|A|A|B|S|
|-|-|-|-|-|
|index|0|1|2|3|

There are also 2 dimensional array (matrix)

|1,1|1,2|
|-|-|
|2,1|2,2|

```python to create 2d array
# Creates a list containing 5 lists, each of 8 items, all set to 0
w, h = 8, 5
Matrix = [[0 for x in range(w)] for y in range(h)] 
```
#### Advantages of using Arrays:
- Arrays allow random access to elements. This makes accessing elements by position faster.
- Arrays have better cache locality which makes a pretty big difference in performance.
- Arrays represent multiple data items of the same type using a single name.
- Arrays store multiple data of similar types with the same name.
- Array data structures are used to implement the other data structures like linked lists, stacks, queues, trees, graphs, etc.

#### Disadvantages of Array:
- As arrays have a fixed size, once the memory is allocated to them, it cannot be increased or decreased, making it impossible to store extra data if required. An array of fixed size is referred to as a static array.
- Allocating less memory than required to an array leads to loss of data.An array is homogeneous in nature so, a single array cannot store values of different data types.
- Arrays store data in contiguous memory locations, which makes deletion and insertion very difficult to implement. This problem is overcome by implementing linked lists, which allow elements to be accessed sequentially.

#### Application of Array:
- They are used in the implementation of other data structures such as array lists, heaps, hash tables, vectors, and matrices.
- Database records are usually implemented as arrays.
- It is used in lookup tables by computer.
- It is used for different sorting algorithms such as bubble sort insertion sort, merge sort, and quick sort.
  
### Array Operations
Types of Array operations:
- **Traversal**: Traverse through the elements of an array.
- **Insertion**: Inserting a new element in an array.
- **Deletion**: Deleting element from the array.
- **Searching**: Search for an element in the array.
- **Sorting**: Maintaining the order of elements in the array.
