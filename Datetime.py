
import pandas as pd

df = pd.read_csv('shipping.csv')
print(df)
df['Ship_Date'] = pd.to_datetime(df['Ship_Date'])
df.drop_duplicates(subset='Order_ID', keep=False, inplace=True)
df.to_csv('modified_shipping.csv',index=False)