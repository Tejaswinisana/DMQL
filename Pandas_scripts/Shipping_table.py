import pandas as pd
df = pd.read_csv('modified_merge_both.csv')
df[df.columns[~df.columns.isin(['Order_Date','Order_Priority','Ord_id','_merge'])]].to_csv('final_shipping.csv',index=False)