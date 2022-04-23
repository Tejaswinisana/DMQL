import pandas as pa

df = pa.read_csv('market.csv')
print(df)
df['Sales']= df['Sales'].astype(float)
df.to_csv('modified.csv',index=False)