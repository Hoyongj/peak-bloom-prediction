# Cherry Blossom Peak Bloom Prediction

## Abstract

In this analysis, our group predicted 'peak bloom date' over the next decade for given 4 locations by using multiple linear regression. For the model selection, leave one out cross-validation (LOOCV) was adjusted with mean absolute error (MAE). 


## Approach

There is a fluctuation over time due to periodic phenomenon like solar cycle. (Hence, time series can improve the statistical model.) However, in this analysis, the group wanted to approximate this phenomenon with trigonometric transform based linear regression model. (For example, as $\mathrm{year\_sin} = \sin(\frac{\pi\cdot \mathrm{year}}{5.5})$ has 11 year cycle, it can improve the model.)