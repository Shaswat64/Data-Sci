import pandas as pd
df = pd.read_csv('HR_Dataset Refresh.csv')
print(df)

it_department = df[(df['Department'] == 'IT/IS')]
print(it_department)
print("-----------------------------------")
print("")

disengaged_employees = df[(df['Department'].str.strip() == 'Production') & (df['EmpSatisfaction'] < 3)]
print(disengaged_employees)
print("-----------------------------------")
print("")

recruitment_channels = df[(df['RecruitmentSource'] == "Employee Referral") | (df['RecruitmentSource'] == "Glassdoor")]
print(recruitment_channels)
print("-----------------------------------")
print("")

attendance_anomalies = df[(df['Salary'] > 100000) & (df['Absences'] > 10)]
print(attendance_anomalies[['Employee_Name','Position','ManagerName']])
print("-----------------------------------")
print("")

id_masking = df[(df['ManagerName'] == "Kissy Sullivan") & (df['DaysLateLast30'] > 0)]
print(id_masking['Employee_Name'])
print("-----------------------------------")
print("")
