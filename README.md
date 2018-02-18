# mpg-data.txt

1. We want to investigate fuel consumption in various car makes and models. The data set
   “mpg.data.txt” provides 398 rows of data. 

2. The data columns include:
   - Y. mpg: miles per gallon continuous
   - X1. cyl: number of cylinders multi-valued discrete
   - X2. disp: engine displacement continuous
   - X3. hpwr: horsepower continuous
   - X4. wght: weight of car continuous
   - X5. accl: acceleration continuous
   - X6. yr: model year multi-valued discrete
   - X7. org: origin multi-valued discrete
   - X8. car: car name string (unique for each instance)
3. We seek a model of the form:
      Y = B0 + B1 * X1 + B2 * X2 + ….. B7 * X7
4. Complete the analysis using 2 of the following tools (R, SAS, or Excel). Perform the following
steps, perform a complete exploratory data analysis (EDA) for each X variable (descriptive
statistics, plots, etc), Regression analysis: draw a scatter plot of Y and X variables & observe if
there are linear relationships, check for multi-collinearity between X variables, fit the multiple
linear regression model, generate parameter estimates, evaluate goodness of fit tests (F-test,
individual parameter test, coefficient of determination), complete a residual analysis(validate:
constant variance, linear relationship, normal distribution, potential outliers), evaluate and
provide the optimal final model and make predictions on rental price per acre.
