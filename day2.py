#pandas
# Used for data cleasining, feature engineering, data analysis

import pandas as pd

#seires
alphabets = pd.Series(["a","b","c"], index=['a','b','c'])
print(alphabets)
print("--------------------")
print(" ")
products = pd.DataFrame([
    ['Watch', 'Navy Force', 2018, 'Rs.35000'],
    ['TV', 'Samsung', 2022, 'Rs.60000'],
    ['Laptop', 'Dell', 2025, 'Rs.150000']
],
columns=['products','Brand','Year','Price'],
index=['a','b','c']
)
print(products)
print("--------------------")
print(" ")


# #slicing

# print(products.loc['a':'b', 'products': 'Year'])
# print(products.loc['a','c'],['products','Year']
# )
print("--------------------")
print(" ")

print(products.info)
print("--------------------")
print(" ")
print(products.shape)
print(products.size)

df = pd.read_csv('Real estate.csv')
# print(df)
print(df.head())
print(df.tail())