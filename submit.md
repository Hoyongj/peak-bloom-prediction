# Peak Bloom Prediction by Linear Model

For this project, our group predicted "cherry blossom peak bloom" with linear regression in 3 different approaches. 


## Approach 1
Our first attempt for the prediction includes temperature data. To use this data, missing data should be handled. So our group fit the regression with generalized linear model. And the result shows that there is a high correlation between `temperature` and `bloom_doy`. However, in 2023, `washingtondc` and `liestal` do not have temperature data for last 4 months. To solve the problem, our group considered to use data imputation, but as it can be biased, we decided to drop this variable.

## Approach 2
As temperature can be explained with sunlight conditions, we tried to compensate the effect of missing temperature data by specifying trigonometic conversion of year and latitude data. As there is a periodic phenomenon called solar cycle with 11 years, we added $\mathrm{year_{sin}} = \sin(\pi\cdot \frac{\mathrm{year}}{5.5})$ and $\mathrm{year_{cos}} = \cos(\pi\cdot \frac{\mathrm{year}}{5.5})$ terms so that they can explain some portion of cycle. Similar to this, the intensity of sunlight is proportional to $\mathrm{cos(latitude)}$. Final model was selected by Akaike information criterion (AIC), however the criteria for this competition is mean absolute error (MAE). So we assumed that model overfitting can be even beneficial in this case.

## Approach 3
Instead of using AIC, we used cross-validation (CV) that measures MAE. Also, to use this function for model selection, we defined stepwise model selecting function for MAE-based CV. Considering the characteristic that `/data/vancouver.csv` has only 1 row, it is impossible to use `location` as categorical variable. So we dropped `location` variable for the final model.

<!-- If we try to fit the generalized linear model based the data, it shows that there is high correlation between `temperature` and `bloom_doy`. To fit the model in this case, we need to use generalized model as there are missing data like kyoto However, `library(rnoaa)` -->