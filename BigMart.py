import pandas as px
import numpy as np
import os
import matplotlib.pyplot as plt
import seaborn as sns
from IPython import get_ipython
#ipy = get_ipython()
#if ipy is not None:
#    ipy.run_line_magic('matplotlib', 'inline')
from sklearn import datasets
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
import statsmodels.api as sm
import statsmodels.formula.api as smf
from sklearn.preprocessing import OneHotEncoder
#print(os.getcwd())
bm_Data = px.read_csv("Train_BigMArt.csv")
#print(bm_Data)
bm_Data.dropna(inplace=True,how ='all')
#print(bm_Data)
bm_Data.drop('Outlet_Establishment_Year',axis=1,inplace=True)
sns.pairplot(bm_Data)
plt.show()
#print(bm_Data)
#print(bm_Data.head())
Item_Type_count = bm_Data['Item_Type'].value_counts()
sns.set(style="darkgrid")
sns.barplot(Item_Type_count.index, Item_Type_count.values, alpha=0.9)
plt.title('Frequency Distribution of itemTypes')
plt.ylabel('Number of Occurrences', fontsize=12)
plt.xlabel('Item_types', fontsize=12)
plt.show()
# We see the maximum item_type is fruites and vegetables
Outlet_Type_count = bm_Data['Outlet_Type'].value_counts()
sns.set(style="darkgrid")
sns.barplot(Outlet_Type_count.index, Outlet_Type_count.values, alpha=0.9)
plt.title('Frequency Distribution of OutletTypes')
plt.ylabel('Number of Occurrences', fontsize=12)
plt.xlabel('Outlet_types', fontsize=12)
plt.show()
# maximum frequency in Outlet_Type = "Supermarket Type1"
Outlet_Location_Type_count = bm_Data['Outlet_Location_Type'].value_counts()
sns.set(style="darkgrid")
sns.barplot(Outlet_Location_Type_count.index, Outlet_Location_Type_count.values, alpha=0.9)
plt.title('Frequency Distribution of OutletTypes')
plt.ylabel('Number of Occurrences', fontsize=12)
plt.xlabel('Outlet_Location_Type', fontsize=12)
plt.show()
Item_Fat_Content_count =  bm_Data['Item_Fat_Content'].value_counts()
sns.set(style="darkgrid")
sns.barplot(Item_Fat_Content_count.index, Item_Fat_Content_count.values, alpha=0.9,palette="Greens_d")
plt.title('Frequency Distribution of Fat Content')
plt.ylabel('Number of Occurrences', fontsize=12)
plt.xlabel('Fat_Content', fontsize=12)
plt.show()
Outlet_size_count =  bm_Data['Outlet_Size'].value_counts()
sns.set(style="darkgrid")
sns.barplot(Outlet_size_count.index, Outlet_size_count.values, alpha=0.9,palette="Blues_d")
plt.title('Frequency Distribution of Outlet Size')
plt.ylabel('Number of Occurrences', fontsize=12)
plt.xlabel('Outlet_Size', fontsize=12)
plt.show()

bm_df = px.DataFrame(bm_Data)
cols = ['Item_Fat_Content','Item_Type','Outlet_Size','Outlet_Location_Type','Outlet_Type',]
for each in cols:
        dummies = px.get_dummies(bm_df[each], prefix=each, drop_first=False)
        bm_df = px.concat([bm_df, dummies], axis=1)
print(list(bm_df))
bm_df.dropna(subset=['Item_Weight', 'Item_Fat_Content_Low Fat','Item_Outlet_Sales'],how='all')
bm_df['Item_Weight'].fillna(bm_df['Item_Weight'].mean(), inplace=True)
all_inf_or_nan = bm_df.isin([np.inf, -np.inf, np.nan]).all(axis='columns')
bm_df[~all_inf_or_nan]
X = bm_df[['Item_Weight','Item_Fat_Content_Low Fat','Item_Fat_Content_Regular','Item_Fat_Content_low fat','Item_Type_Baking Goods', 'Item_Type_Breads', 'Item_Type_Breakfast', 'Item_Type_Canned', 'Item_Type_Dairy', 'Item_Type_Frozen Foods', 'Item_Type_Fruits and Vegetables', 'Item_Type_Hard Drinks', 'Item_Type_Health and Hygiene', 'Item_Type_Household', 'Item_Type_Meat', 'Item_Type_Others', 'Item_Type_Seafood', 'Item_Type_Snack Foods', 'Item_Type_Soft Drinks', 'Item_Type_Starchy Foods', 'Outlet_Size_High', 'Outlet_Size_Medium', 'Outlet_Size_Small', 'Outlet_Location_Type_Tier 1', 'Outlet_Location_Type_Tier 2', 'Outlet_Location_Type_Tier 3', 'Outlet_Type_Grocery Store', 'Outlet_Type_Supermarket Type1', 'Outlet_Type_Supermarket Type2', 'Outlet_Type_Supermarket Type3','Item_MRP','Item_Visibility']]
Y = bm_df['Item_Outlet_Sales']
print(np.any(np.isnan(X)))
print(np.all(np.isfinite(X)))
print(bm_df)
reg = linear_model.LinearRegression()
reg.fit(X, Y)
X = sm.add_constant(X)
model = sm.OLS(Y,X).fit()
# regression coefficients
#print('Coefficients: \n', reg.coef_)
print('Summary:', model.summary())
