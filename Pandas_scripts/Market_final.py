import pandas as pd
df = pd.read_csv('modified_merge_ord_market.csv')
df[df.columns[~df.columns.isin(['Order_ID','Order_Date','Order_Priority','_merge'])]].to_csv('new_final_market.csv',index=False)