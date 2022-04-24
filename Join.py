import pandas as pd
df1 = pd.read_csv('modified_orders.csv')
df2 = pd.read_csv('final_market.csv')

df_all = df1.merge(df2.drop_duplicates(),on=['Ord_id'],how= 'left',indicator=True)



df_all.loc[df_all['_merge']=='both'].to_csv('modified_merge_ord_market.csv',index=False)