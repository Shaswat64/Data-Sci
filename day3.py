import pandas as pd

hr = pd.read_csv('HR_Dataset Refresh.csv')
print(hr['Employee_Name'])
hr['Employee_Name'] =hr['Employee_Name'].str.replace(',', ' ', regex=False)
print(hr['Employee_Name'])
hr['ManagerID'] = hr['ManagerID'].astype('int')
hr['DOB'] = pd.to_datetime(hr['DOB'],format='mixed')
print(hr['DOB'])

