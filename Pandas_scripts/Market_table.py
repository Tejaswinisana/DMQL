import pandas as pd
df = pd.read_csv('market.csv')
df.replace(to_replace='NA',value=0,inplace=True)
# df['Product_Base_Margin'].mask(df['Product_Base_Margin']=='NA',0, inplace=True)
df.to_csv('final_market.csv',index=False)
