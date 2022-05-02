
import pandas as pd

df = pd.read_csv('order.csv')
df['Order_Date'] = pd.to_datetime(df['Order_Date'])
df.drop_duplicates(subset='Order_ID', keep=False, inplace=True)
df.to_csv('modified_4.csv',index=False)