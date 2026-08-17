import pandas as pd
fraud = pd.read_csv('Fraud Detection Dataset.csv')
print(fraud.isnull().sum())

def fill_null (dataframe,column,data):
     dataframe.fillna({column : data}, inplace=True)

def check_unique (dataframe,column):
     print(dataframe[column].unique())

fraud = fraud.drop_duplicates(subset=['Transaction_ID'])

print(fraud['Transaction_Amount'].skew())
 
transaction_amount_median = fraud['Transaction_Amount'].median
fraud.fillna({'Transaction_Amount': transaction_amount_median },inplace=True)

time_of_transaction_mode = fraud['Time_of_Transaction'].mode
fill_null(fraud,'Time_of_Transaction', time_of_transaction_mode)

check_unique(fraud,'Device_Used')
fill_null(fraud,'Device_Used','Unknown Device')

check_unique(fraud,'Location')
fill_null(fraud,'Location', 'Unknown Location')

print(fraud['Payment_Method'].unique())
fill_null(fraud,'Payment_Method', 'Invalid Method')

print(fraud.isnull().sum())

# fraud.to_csv('Fraud Detection Cleaned Dataset.csv', index = False)
# fraud.to_excel('Fraud Detection Cleaned Dataset.xlsx', index = False)
# fraud.to_json('Fraud Detection Cleaned Dataset.json', indent=4)