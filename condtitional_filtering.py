import pandas as pd
df = pd.read_csv('Employees.csv')
print(df.head())
print("")
print("------------------------")


emp_salary = df[(df['SALARY']>10000)&(df['SALARY']<18000)]          # faster method
print(emp_salary)
print("")
print("------------------------")


emp_salary_between = df[df['SALARY'].between(10000,18000)]        # slower method
print(emp_salary_between)
print("")
print("------------------------")

emp_job_id = df[(df['JOB_ID'] == 'AD_VP') | (df['JOB_ID']== 'IT_PROG')] 
print(emp_job_id)
print("")
print("------------------------")

emp_job_id = df[((df['SALARY']>4000) & (df['SALARY']<7000) ) & (df['JOB_ID']== 'IT_PROG')] 
print(emp_job_id)
print("")
print("------------------------")
