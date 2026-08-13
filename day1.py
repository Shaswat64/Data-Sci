import numpy as np

# Numeric Python


a = [1,2,3,4,5]
b = [5,6,7,8,9]
c = a+b
print(c)
print("-------------------")

arr_a = np.array(a)
arr_b = np.array(b)

# print(type(arr_a))


arr_c = arr_a * arr_b
print(arr_c)
print("------------------")

multi_d_array = np.array([
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12]
])
print(multi_d_array)
print("------------------")

print(a)
print(arr_a)
print("------------------")

print(multi_d_array.shape)
print(multi_d_array.size)
print(multi_d_array.ndim)
print("---------------------")

data = np.array(['Mobile', 'TV', 'Watch', 'Laptop', 'Desktop'])
max_char = max(len(word)for word in data)
print(max_char)