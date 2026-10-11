#import "../src/lib.typ": dtu-assignment, important, note-box, dtu-highlight, example, dtu-table, code-block

#show: dtu-assignment.with(
  course: "02102",
  course-name: "Algorithms and Data Structures",
  title: "Assignment 3: Sorting and Searching",
  due-date: datetime(year: 2024, month: 4, day: 15),
  author: "Your Name",
  semester: "Spring 2024"
)

= Problem 1: Binary Search Implementation (25 points)

Implement a binary search algorithm that works on a sorted array of integers.

== Part A: Basic Implementation (15 points)

Write a function `binary_search(arr, target)` that returns the index of the target element, or -1 if not found.

#important([
  Your implementation must have $O(log n)$ time complexity. Implementations with linear time complexity will receive partial credit only.
])

#code-block(
  caption: "Binary Search Implementation")[
  ```python
def binary_search(arr, target):
    """
    Perform binary search on a sorted array.
    
    Args:
        arr: Sorted list of integers
        target: Integer to search for
    
    Returns:
        Index of target if found, -1 otherwise
    """
    left, right = 0, len(arr) - 1
    
    while left <= right:
        mid = (left + right) // 2
        
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1
  ```
]

== Part B: Analysis (10 points)

Answer the following questions:

1. *Time Complexity Analysis*: Prove that your implementation runs in $O(log n)$ time.

   #note-box([
   In each iteration, we eliminate half of the remaining search space. Starting with $n$ elements, after $k$ iterations we have at most $n/2^k$ elements remaining.
   ])

   The algorithm terminates when we have 1 or 0 elements left:
   $ n/2^k ≤ 1 $
   $ n ≤ 2^k $
   $ k ≥ log_2 n $

   Therefore, the maximum number of iterations is $⌈log_2 n⌉$, giving us $O(log n)$ time complexity.

2. *Space Complexity*: What is the space complexity of your iterative implementation?

   The iterative implementation uses only a constant amount of extra space for the variables `left`, `right`, and `mid`, regardless of input size. Therefore, the space complexity is $O(1)$.

3. *Precondition*: What assumption does binary search make about the input array?

   Binary search requires that the input array is sorted in ascending order.

= Problem 2: Sorting Algorithm Comparison (30 points)

Compare the performance characteristics of three sorting algorithms: Bubble Sort, Merge Sort, and Quick Sort.

== Part A: Implementation (20 points)

Implement all three sorting algorithms:

#example([
  Here's the merge sort implementation:
  
  #code-block(
    caption: "Merge Sort Algorithm")[
    ```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    
    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    
    result.extend(left[i:])
    result.extend(right[j:])
    return result
    ```
  )
]])

*Bubble Sort:*
#code-block(
  caption: "Bubble Sort Algorithm")[
  ```python
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        swapped = False
        for j in range(0, n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                swapped = True
        if not swapped:
            break
    return arr
  ```
]

*Quick Sort:*
#code-block(
  caption: "Quick Sort Algorithm")[
  ```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    return quick_sort(left) + middle + quick_sort(right)
```]


== Part B: Complexity Analysis (10 points)

Fill in the complexity comparison table:

#dtu-table(
  columns: 5,
  caption: "Sorting Algorithm Complexity Comparison",
  [*Algorithm*], [*Best Case*], [*Average Case*], [*Worst Case*], [*Space Complexity*],
  [Bubble Sort], [O(n)], [O(n²)], [O(n²)], [O(1)],
  [Merge Sort], [O(n log n)], [O(n log n)], [O(n log n)], [O(n)],
  [Quick Sort], [O(n log n)], [O(n log n)], [O(n²)], [O(log n)],
)

#dtu-highlight([
  Merge sort has consistent O(n log n) performance but requires additional space, while quick sort is usually faster in practice but has poor worst-case performance.
])

= Problem 3: Hash Table Design (25 points)

Design and implement a hash table with collision resolution.

== Part A: Hash Function (10 points)

Implement a hash function for strings:

#code-block(
  caption: "String Hash Function")[
  ```python
def hash_function(key, table_size):
    """
    Simple polynomial hash function for strings.
    """
    hash_value = 0
    for i, char in enumerate(key):
        hash_value += ord(char) * (31 ** i)
    return hash_value % table_size
  ```
]

== Part B: Collision Resolution (15 points)

Implement chaining for collision resolution:

#code-block(
  caption: "Hash Table with Chaining")[
  ```python
class HashTable:
    def __init__(self, size=10):
        self.size = size
        self.table = [[] for _ in range(size)]
    
    def put(self, key, value):
        index = hash_function(key, self.size)
        bucket = self.table[index]
        
        # Update existing key
        for i, (k, v) in enumerate(bucket):
            if k == key:
                bucket[i] = (key, value)
                return
        
        # Add new key-value pair
        bucket.append((key, value))
    
    def get(self, key):
        index = hash_function(key, self.size)
        bucket = self.table[index]
        
        for k, v in bucket:
            if k == key:
                return v
        
        raise KeyError(key)
  ```
]

#important([
  Explain how your collision resolution strategy affects the time complexity of hash table operations.
])

When using chaining:
- *Average case*: O(1) for all operations, assuming a good hash function and reasonable load factor
- *Worst case*: O(n) when all keys hash to the same bucket

= Problem 4: Algorithm Design (20 points)

Design an efficient algorithm to find the two numbers in an array that sum to a given target.

== Problem Statement

Given an array of integers and a target sum, find two numbers in the array that add up to the target. Return their indices.

*Example:*
- Input: `nums = [2, 7, 11, 15]`, `target = 9`
- Output: `[0, 1]` (because `nums[0] + nums[1] = 2 + 7 = 9`)

== Solution

#code-block(
  caption: "Two Sum Algorithm - Hash Map Approach")[
  ```python
def two_sum(nums, target):
    """
    Find two numbers that sum to target using hash map approach.
    
    Time Complexity: O(n)
    Space Complexity: O(n)
    """
    seen = {}  # value -> index mapping
    
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    
    return []  # No solution found
  ```
]

== Analysis

1. *Correctness*: For each element `x`, we check if `target - x` has been seen before. If yes, we found our pair.

2. *Time Complexity*: O(n) - single pass through the array

3. *Space Complexity*: O(n) - hash map can store up to n elements

#note-box([
  This approach is more efficient than the brute force O(n²) solution that checks all pairs.
])

== Bonus Question (5 extra points)

Can you solve this problem with O(1) space complexity? What would be the trade-off?

*Hint*: Consider sorting the array first and using two pointers.

---

#important([
  *Submission Guidelines:*
  - Submit all source code files
  - Include test cases for your implementations
  - Provide clear documentation and comments
  - Ensure your code handles edge cases appropriately
])

*Good luck!*
