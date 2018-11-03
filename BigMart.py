import pandas as px
import os
import matplotlib.pyplot as plt
import seaborn as sns
from IPython import get_ipython
ipy = get_ipython()
if ipy is not None:
    ipy.run_line_magic('matplotlib', 'inline')
from sklearn import datasets
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
#print(os.getcwd())
bm_Data = px.read_csv("Train_BigMArt.csv")
#print(bm_Data)
bm_Data.dropna(thresh=5,inplace=True)
#print(bm_Data)
bm_Data.drop('Outlet_Establishment_Year',axis=1,inplace=True)
#print(bm_Data)
#print(bm_Data.head())
Item_Type_count = bm_Data['Item_Type'].value_counts()
sns.set(style="darkgrid")
#sns.barplot(Item_Type_count.index, Item_Type_count.values, alpha=0.9)
#plt.title('Frequency Distribution of itemTypes')
#plt.ylabel('Number of Occurrences', fontsize=12)
#plt.xlabel('Item_types', fontsize=12)
#plt.show()
# We see the maximum item_type is fruites and vegetables
Outlet_Type_count = bm_Data['Outlet_Type'].value_counts()
#sns.set(style="darkgrid")
#sns.barplot(Outlet_Type_count.index, Outlet_Type_count.values, alpha=0.9)
#plt.title('Frequency Distribution of OutletTypes')
#plt.ylabel('Number of Occurrences', fontsize=12)
#plt.xlabel('Outlet_types', fontsize=12)
#plt.show()
# maximum frequency in Outlet_Type = "Supermarket Type1"
Outlet_Location_Type_count = bm_Data['Outlet_Location_Type'].value_counts()
#sns.set(style="darkgrid")
#sns.barplot(Outlet_Location_Type_count.index, Outlet_Location_Type_count.values, alpha=0.9)
#plt.title('Frequency Distribution of OutletTypes')
#plt.ylabel('Number of Occurrences', fontsize=12)
#plt.xlabel('Outlet_Location_Type', fontsize=12)
#plt.show()
#sns.heatmap(bm_Data.corr())
#plt.show()
replace_map1= {'Outlet_Type':{'Supermarket Type1' : 1,'Supermarket Type2' : 2,'Supermarket Type3' : 3,'Grocery Store' : 4}}
bm_Data_replace=bm_Data.copy()
bm_Data_replace.replace(replace_map1,inplace =True)
#print(bm_Data_replace['Outlet_Type'])
X=bm_Data_replace[['Outlet_Type']]
Y=bm_Data_replace[['Item_Outlet_Sales']]
X_train,X_test,Y_train,Y_test= train_test_split(X,Y,test_size = 0.2,random_state = 0)
lm = linear_model.LinearRegression()
model = lm.fit(X_train,Y_train)

y_pred = lm.predict(X_test)
#print(model)
#print(lm.intercept_)
print(r2_score(Y_test,y_pred))
plt.scatter(X_test,y_pred,
            color = "green", s = 10, label = 'Outlet_Type')
plt.show()
