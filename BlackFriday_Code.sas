
PROC IMPORT OUT= WORK.BlackFriday DATAFILE="C:\Users\vxn180007\Desktop\SAS Assignment\Project\BlackFriday.csv" 
		DBMS=CSV REPLACE;
		GETNAMES=YES; DATAROW=2;
	
RUN;


data BlackFridaydata;
set BlackFriday;
Marital = put(Marital_Status, 1.);
Product1 = put(Product_Category_1, 2.);
Product2 = put(Product_Category_2, 2.);
Product3 = put(Product_Category_3, 2.);
Occupations = put(Occupation, 2.);
ProductID = put(Product_ID, 9.);
format purchase value dollar10.2;
run;
/*goptions colors=(red green blue);*/
/*gender count*/
proc gchart data=BlackFridaydata;
vbar Gender / type=freq;
title 'Count of males and females';
run;
/*average across gender
Even though female shoppers make less purchases than males at this specific store, they seem to be purchasing almost as much on average as the 
male shoppers*/
proc gchart data=BlackFridaydata;
vbar Gender / discrete type=mean
 sumvar=Purchase mean;
 title 'Average Spending across Gender';
run;

/*marital count*/
proc gchart data=BlackFridaydata;
vbar Marital / type=freq;
title 'Frequency Distribution of Marital Status';
run;
/*average across marital status
Even though female shoppers make less purchases than males at this specific store, they seem to be purchasing almost as much on average as the 
male shoppers*/
proc gchart data=BlackFridaydata;
vbar Marital / discrete type=mean
 sumvar=Purchase mean;
 title 'Average Spending across Marital Status';
run;


/*age category count*/
proc gchart data=BlackFridaydata;
vbar Age / type=freq;
title 'Frequency distribution of Age Groups';
run;
/*average purchase across age*/
proc gchart data=BlackFridaydata;
vbar Age / discrete type=mean
 sumvar=Purchase mean;
 title 'Average Spending across Age Groups';
run;


 /* Generate pie chart for city category count */
proc gchart data=Blackfridaydata;
   pie City_Category / type=freq
                  other=0
                  midpoints='A' 'B' 'C'
                  value=none
                  percent=arrow
                  slice=arrow
                  noheading;
	title 'Frequency Distribution of Cities';
run;

proc gchart data=BlackFridaydata;
hbar City_Category / discrete type=mean
 sumvar=Purchase mean;
 title 'Average Spending across City_Categories';
run;

/*Stay_In_Current_City_Years  count*/
proc gchart data=BlackFridaydata;
vbar Stay_In_Current_City_Years / type=freq;
title 'Frequency Distribution of Years of Stay In Current City';
run;
/*average purchase across Stay_In_Current_City_Years */
proc gchart data=BlackFridaydata;
vbar Stay_In_Current_City_Years  / discrete type=mean
 sumvar=Purchase mean;
 title 'Average Spending across Years of Stay In Current City';
run;
/*Occupations count*/
proc gchart data=BlackFridaydata;
vbar Occupations  / type=freq;
title 'Frequency Distribution of Occupations';
run;
/*average across occupations*/
proc gchart data=BlackFridaydata;
vbar Occupations / discrete type=mean
 sumvar=Purchase mean;
 title 'Average Spending across Occupations';
run;                                                                                                                       
      /*gender and marital count  */                                                                                                                
proc gchart data=Blackfridaydata;                                                                                                       
   vbar Gender / subgroup=Gender group=Marital  type=freq                                                                         
                  legend=legend1 space=0 gspace=4                                                                                        
                  maxis=axis1 raxis=axis2 gaxis=axis3;
title 'Frequency Distribition of Gender across Marital Status'; 
run;                                                                                                                                   
/* gender and marital average sales*/                                                                                                                
proc gchart data=Blackfridaydata;                                                                                                       
   vbar gender / subgroup=gender group=Marital  discrete type=mean
 sumvar=Purchase mean                                                                      
                  legend=legend1 space=0 gspace=4                                                                                        
                  maxis=axis1 raxis=axis2 gaxis=axis3;  
title 'Average Sales across Gender and Marital Status'; 
run;   
/*age and gender count */                                                                                                                
proc gchart data=Blackfridaydata;                                                                                                       
   vbar Age / subgroup=Age group=Gender  type=freq                                                                         
                  legend=legend1 space=0 gspace=4                                                                                        
                  maxis=axis1 raxis=axis2 gaxis=axis3;
title 'Frequency Distribition of Age Groups across Gender'; 
run; 
/* age & gender average sales*/                                                                                                                
proc gchart data=Blackfridaydata;                                                                                                       
   vbar age / subgroup=age group=gender  discrete type=mean
 sumvar=Purchase mean                                                                      
                  legend=legend1 space=0 gspace=4                                                                                        
                  maxis=axis1 raxis=axis2 gaxis=axis3;  
title 'Average Sales across Gender and Marital Status'; 
run; 
/*city category & stay in years */                                                                                                                
proc gchart data=Blackfridaydata;                                                                                                       
   vbar City_Category / subgroup=City_Category group=Stay_In_Current_City_Years  type=freq                                                                         
                  legend=legend1 space=0 gspace=4                                                                                        
                  maxis=axis1 raxis=axis2 gaxis=axis3;
title 'Frequency Distribition of City Categories and Years of Stay '; 
run; 
/* age & gender average sales*/                                                                                                                
proc gchart data=Blackfridaydata;                                                                                                       
  vbar City_Category / subgroup=City_Category group=Stay_In_Current_City_Years   discrete type=mean
 sumvar=Purchase mean                                                                      
                  legend=legend1 space=0 gspace=4                                                                                        
                  maxis=axis1 raxis=axis2 gaxis=axis3;  
title 'Average Sales across City Categories and Years of Stay '; 
run; 
/*top selling wip P00110742*/
proc sql;
select Product_id, count(Product_id) as county from BlackFridaydata
group by Product_id
order by county desc
;
quit;
goptions colors=(red green blue white yellow brown);
goptions reset=all border;

proc gchart data=Blackfridaydata;
hbar3d age / midpoints=(30 40 50)
freq freqlabel="Total in Group" subgroup=gender autoref
     maxis=axis2
     raxis=axis1
     legend=legend1
     coutline=black
     ;
run;
quit;
proc gchart data=Blackfridaydata;
hbar3d age / midpoints=(30 40 50)
freq freqlabel="Total in Group" subgroup=gender autoref
sumvar=Purchase mean
     maxis=axis2
     raxis=axis1
     legend=legend1
     coutline=black
     ;
run;
quit;
proc gbarline data=Blackfridaydata;
bar City_Category / discrete sumvar=Purchase space=4;
run;
quit;
data BlackFridaydata_CatA;
set Blackfridaydata;
where City_Category = 'A';
run;
data BlackFridaydata_CatB;
set Blackfridaydata;
where City_Category = 'B';
run;
data BlackFridaydata_CatC;
set Blackfridaydata;
where City_Category = 'C';
run;
axis1 label = ( f= "Arial/bold" "Product Subcategory") major= (Width = 20);
axis2 label = (f= "Calibri/bold" "Purchase") major = (width = 20);
run;


proc gchart data=BlackFridaydata_CatA;
format quarter roman.;
format Purchase dollar8.;
vbar3d Age / sumvar=Purchase mean subgroup=Gender inside=subpct
     outside=mean
     width=13
     space=10
     maxis=axis1
     raxis=axis2
     cframe=white
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata_CatB;
format quarter roman.;
format Purchase dollar8.;
vbar3d Age / sumvar=Purchase mean subgroup=Gender inside=subpct
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=white
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata_CatC;
format quarter roman.;
format Purchase dollar8.;
vbar3d Age / sumvar=Purchase mean subgroup=Gender inside=subpct
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=white
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata;
format quarter roman.;
format Purchase dollar8.;
block Gender / sumvar=Purchase
type=mean
group=City_Category
subgroup=Marital
legend=legend1
noheading;
run;
quit;
proc gchart data=BlackFridaydata;
format Purchase dollar8.;
vbar3d City_Category / sumvar=Purchase subgroup=Marital inside=subpct
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=gray
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata_CatA;
star Stay_In_Current_City_Years / sumvar=Purchase type = mean;
run;
quit; 
proc gchart data=BlackFridaydata_CatB;
star Stay_In_Current_City_Years / sumvar=Purchase type = mean;
run;
quit; 
proc gchart data=BlackFridaydata_CatC;
star Stay_In_Current_City_Years / sumvar=Purchase type = mean;
run;
quit; 
proc gchart data=BlackFridaydata_CatA;
format Purchase dollar8.;
vbar3d Occupations / sumvar=Purchase subgroup=Gender inside=subpct
     shape = cylinder
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=White
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata_CatB;
format Purchase dollar8.;
vbar3d Occupations / sumvar=Purchase subgroup=Gender inside=subpct
     shape = cylinder
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=White
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata_CatC;
format Purchase dollar8.;
vbar3d Occupations / sumvar=Purchase subgroup=Gender inside=subpct
     shape = cylinder
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=White
     legend=legend1;
run;
quit;

proc gchart data=Blackfridaydata;
hbar3d City_Category / midpoints=(30 40 50)
freq freqlabel="Total in Group" subgroup=age autoref
     maxis=axis2
     raxis=axis1
     legend=legend1
     coutline=black
     ;
run;
quit;
goptions reset = global;
proc gchart data=BlackFridaydata;
format Purchase dollar8.;
vbar3d Product1 / sumvar=Purchase subgroup=City_Category inside=subpct
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=white
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata;
format Purchase dollar8.;
vbar3d Product2 / sumvar=Purchase subgroup=City_Category inside=subpct
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=White
     legend=legend9;
run;
quit;
proc gchart data=BlackFridaydata;
format Purchase dollar8.;
hbar3d Product3 / sumvar=Purchase subgroup=City_Category inside=subpct
     outside=mean
     width=9
     space=4
     maxis=axis1
     raxis=axis2
     cframe=White
     legend=legend1;
run;
quit;
proc gchart data=BlackFridaydata;
  pie Product1  /
             across=2
             clockwise value=none
             slice=outside percent=outside;
run;
quit; 
proc gchart data=BlackFridaydata;
  pie Product2  /
             across=2
             clockwise value=none
             slice=outside percent=outside;
run;
quit;
proc gchart data=BlackFridaydata;
  pie Product3  /
             across=2
             clockwise value=none
             slice=outside percent=outside;
run;
quit;
proc surveyselect data=BlackFridaydata out=bf_sampled outall samprate=0.8 seed=2;
run;

data bf_training bf_test;
	set bf_sampled;

	if selected then
		output bf_training;
	else
		output bf_test;
run;
Data bf_training;
set bf_training;
log_purchase = log10(purchase);
run;
Data bf_test;
set bf_test;
log_purchase = log10(purchase);
run;
/*ASE in train vs. test data */
/* forward selection with cross validation as criteria with 10-folds */
proc glmselect data=bf_training testdata=bf_test seed = 2  plots=all;
 class Gender (split) City_Category (split) Stay_In_Current_City_Years (split) Age  (split) Marital (split) 
Product1 Product2 Product3 ProductID Occupations;
model log_purchase = Gender City_Category Stay_In_Current_City_Years Age Marital Occupations Product1 
Product2 Product3  City_Category*Gender City_Category*Age City_Category*Marital City_Category*Stay_In_Current_City_Years
  /selection=forward(select=cv) hierarchy=single cvmethod=random(10)showpvalues ;
 performance buildsscp=incremental;
run;

/*ASE in train vs. test data */
/* backward selection with cross validation as criteria with 10-folds */

proc glmselect data=bf_training testdata=bf_test seed = 2  plots=all;
  class Gender (split) City_Category (split) Stay_In_Current_City_Years (split) Age  (split) Marital (split) 
Product1 Product2 Product3 ProductID Occupations;
model log_purchase = Gender City_Category Stay_In_Current_City_Years Age Marital  Product1 Product2 Product3 ProductID
  /selection=backward(select=cv) hierarchy=single cvmethod=random(10)showpvalues ;
 performance buildsscp=incremental;
run;
/*ASE in train vs. test data */
/* stepwise selection with cross validation as criteria with 10-folds */

proc glmselect data=bf_training testdata=bf_test seed = 2  plots=all;
  class Gender (split) City_Category (split) Stay_In_Current_City_Years (split) Age  (split) Marital (split) 
Product1 Product2 Product3 ProductID Occupations;
model log_purchase = Gender City_Category Stay_In_Current_City_Years Age Marital Occupations Product1 Product2 Product3 ProductID
  /selection=stepwise(select=cv) hierarchy=single cvmethod=random(10)showpvalues ;
 performance buildsscp=incremental;
run;

proc HPFOREST data=bf_training;
	target purchase / level= interval;
	input gender Marital/ level = binary;
	input city_category Stay_In_Current_City_Years Product1 Occupations Age Product2 Product3 ProductID/ level= ordinal;
run;
proc glmselect data=bf_training testdata=bf_test seed = 2  plots=all;
  class Gender (split) City_Category (split) Stay_In_Current_City_Years (split) Age  (split) Marital (split) 
Product1 Product2 Product3 ProductID Occupations;
model log_purchase = Gender City_Category Stay_In_Current_City_Years Age Marital Occupations Product1 Product2 Product3 ProductID
  /selection=lasso(choose=cv stop=none) hierarchy=single cvmethod=random(10)showpvalues ;
 performance buildsscp=incremental;
run;



proc glmselect data=bf_training testdata=bf_test seed = 2  plots=all;
class Gender (split) City_Category (split) Stay_In_Current_City_Years (split) Age  (split) Marital (split) 
Product1 Product2 Product3 ProductID Occupations;
model log_purchase = Gender City_Category Stay_In_Current_City_Years Age Marital Occupations Product1 Product2 Product3 ProductID
/selection=forward(select=cv) hierarchy=single cvmethod=random(10)showpvalues ;
modelaverage nsamples=50 tables=(ParmEst(all));
performance buildsscp=incremental;
score data=bf_test out=test_performance residual=res;
run;

