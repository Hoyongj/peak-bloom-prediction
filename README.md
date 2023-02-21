# Cherry Blossom Peak Bloom Prediction

## Abstract

In this analysis, our group predicted 'peak bloom date' over the next decade for given 4 locations by using multiple linear regression. For the model selection, leave one out cross-validation (LOOCV) cost by mean absolute error (MAE) was used for stepwise model selection. 


## Approach

There is a fluctuation over time due to periodic phenomenon like solar cycle. Considering it, time series analysis can improve the statistical model. However, in this analysis, the group wanted to approximate this phenomenon with prior knowledge. Especially, trigonometric transformed explanatory variables are used for this linear regression model. (For example, as $\mathrm{year_{sin}} = \sin(\frac{\pi\cdot \mathrm{year}}{5.5})$ has 11 year cycle, it can improve the model.)