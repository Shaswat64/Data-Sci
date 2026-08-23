import pandas as pd
hr = pd.read_csv('HR_Dataset Refresh.csv')
# print(hr.info())
# hr['DOB'] = pd.to_datetime(hr['DOB'],format='mixed')

# hr['Birth Year'] = hr['DOB'].dt.year
# hr['Birth Month'] = hr['DOB'].dt.month
# hr['Birth Day'] = hr['DOB'].dt.day
# hr['Birth Month Name'] = hr['DOB'].dt.month_name()
# hr['Birth Day Name'] = hr['DOB'].dt.day_name()
# print(hr['Birth Month Name'])
# print(hr.info())
# print(hr.isnull().sum())

print(hr['Salary'])


