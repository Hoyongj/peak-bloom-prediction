# Peak Bloom Prediction by Linear Model

For this project, our group predicted "cherry blossom peak bloom" with linear regression in 3 different approaches. 


## Approach 1
Our first attempt for the prediction includes temperature data. To use this data, missing data should be handled. So our group fit the regression with generalized linear model. And the result shows that there is a high correlation between `temperature` and `bloom_doy`. However, in 2023, `washingtondc` and `liestal` do not have temperature data for last 4 months. To solve the problem, our group considered to use data imputation, but as it can be biased, we decided to drop this variable.

## Approach 2
As temperature can be explained with sunlight conditions, we tried to compensate the effect of missing temperature data by specifying trigonometic conversion of year and latitude data. As there is a periodic phenomenon called solar cycle with 11 years, we added $\mathrm{year_{sin}} = \sin(\pi\cdot \frac{\mathrm{year}}{5.5})$ and $\mathrm{year_{cos}} = \cos(\pi\cdot \frac{\mathrm{year}}{5.5})$ terms so that they can explain some portion of cycle. Similar to this, the intensity of sunlight is proportional to $\mathrm{cos(latitude)}$. Final model was selected by Akaike information criterion (AIC), however the criteria for this competition is mean absolute error (MAE). So we assumed that model overfitting can be even beneficial in this case.

## Approach 3
Instead of using AIC, we used cross-validation (CV) that measures MAE. Also, to use this function for model selection, we defined stepwise model selecting function for MAE-based CV. Considering the characteristic that `/data/vancouver.csv` has only 1 row, it is impossible to use `location` as categorical variable. So we dropped `location` variable for the final model.

## Discussion
The final model obtained by the "Approach 3" was `bloom_doy ~ year + long + year_sin`. That is quite close to the model from "Approach 2", which was `bloom_doy ~ year + location + year_sin`. So it demonstrates that criteria for AIC and MAE-based CV can yield similar error measure for the fitted model.
Regarding limitation of the "approach 3", it still use `glm` function, which is based on least square method. So, using algorithm with least absolute deviation (LAD) can improve the error term in this analysis. However, there are more than 1 possible algorithms and solutions for LAD, which is decided depending on situation. So fitting model with LAD requires more attention, as it can be biassed as well. 




