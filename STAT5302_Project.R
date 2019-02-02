# Date: 2017/12/01
# Author: Chunni Zhao

# Load Packages
library(alr4)
library(car) 

# data preprocess
getwd()
setwd("/Users/echozhao/Documents/5302")
getwd()
Waste <- read.table("Waste.txt", sep = " ")
Waste <- Waste[,-7]
colnames(Waste) <- c("FTE", "ImprV", "LandV", 
                     "Size", "Use", "Wst")

# change the variable Use into factor
assDat$Use <- as.factor(assDat$Use)

# get the summary of the data
summary(assDat)

# draw the scatterplot matrix of the data
scatterplotMatrix(~ FTE + ImprV + LandV + Size
                  + Wst |Use, data = assDat)

# there is a point that has huge FTE, ImprV, LandV
# and Size but small Wst
which(assDat$FTE > 2000)
which(assDat$ImprV > 1.5*10^7)
which(assDat$LandV > 2*10^6)
which(assDat$Size > 6*10^5)
assDat$Wst[77]


##############################################
##############   Modeling   ##################
##############################################
# try the power transformation with that point (77)
pt1 <- powerTransform(cbind(FTE, ImprV, LandV, Size) ~ 1,
                      data = assDat)
# power transformation suggests using all log transformation
summary(pt1)

# try the power transformation without observation 77
pt2 <- powerTransform(cbind(FTE, ImprV, LandV, Size) ~ 1,
                       data = assDat[-77, ])

# It still suggests using all log transformation
summary(pt2)

# scatterplot matrix of variables after log transformation
# with observation 77
scatterplotMatrix(~ log(FTE) + log(ImprV) + log(LandV)
                  + log(Size) + Wst | Use, data = assDat)

# scatterplot matrix of variables after log transformation
# without observation 77
scatterplotMatrix(~ log(FTE) + log(ImprV) + log(LandV)
                  + log(Size) + Wst |Use, data = assDat[-77, ])

# comment: we can see that whether dropping the observation 
# 77 makes little difference in the making the regressors 
# linearly related

# variable screening using backward selection
s1 <- step (lm(Wst ~ ( log (FTE) + log (ImprV) + log (LandV)
                       + log(Size) + Use)^2, data = assDat) , direction = "backward")

# plot the response versus the fitted value
plot(Wst ~ fitted(s1), data = assDat)

# Try to do a power transformation on the fitted value 
# the result shows that we may choose 4 as the power
with(assDat, invTranPlot(abs(fitted(s1)) , Wst))

# choose 4 as a power and transform the fitted value
s2 <- lm(Wst ~ poly(I(fitted(s1)), 4), data = assDat)

# plot the residual plot
# there is a huge cluster on the left
residualPlot(s2)

# test nonconstant variance
# the result shows that it is significant that 
# the model has a non constant variance
ncvTest(s2)

# we can do the regression of square of residuals on 
# the fitted value to model the variance
we <- lm(resid(s2)^2 ~ fitted(s1), data = assDat)
# the result turns out that it is significant
summary(we)

# fit the model with the reciprocal of fitted we as the weight
m1<- lm(Wst ~ poly(I(fitted(s1)), 4), data = assDat, weights = 1/abs(fitted(we)))

# plot the residual plot, we can see that
# there is still a cluster of points on the left
plot(resid(m1, "pearson") ~ fitted(m1)) lines(lowess(fitted(m1), f = 1,
                                                     resid (m1, "pearson" ) ) , col="red" )

# the summary shows that almost all of the terms are very significant
summary (m1)

# ncvTest shows that we can not reject the null hypothesis
# that there is no nonconstant variance
ncvTest(m1)

# the outlier test shows that there are 2 possible outliers
outlierTest(m1)

# plot the values
influenceIndexPlot(m1, vars = c("Cook"))

#find out the observation with largest Cook’s distance 
which(cooks.distance(m1) == max(cooks.distance(m1)))

#################################################### 
# plot the confidence region matrix of retaining that 
# point and removing that point 
####################################################
# create function cE to plot confidence ellipses: 
# betas is a vector with length 2 to store the indices 
# for betas
# c is the confidence level
# dp is the indice for the observation to drop
ce <- function(betas, c, dp){
  # confidence region after dropping case dp
  confidenceEllipse(lm(Wst ~ poly(I(fitted(s1)[-dp]) , 4), 
                       data = assDat[-dp, ] ,
                       weights = 1/abs(fitted(we)[-dp])), 
                    which.coef = betas,
                    levels = c,
                    col = "blue", lty = 2)
  # confidence region before dropping case dp for betaas
  confidenceEllipse (m1, which.coef = betas, 
                     levels = c, add = TRUE)
}

# there are 6 coefficients
d <- 5

# set the arrangement of the plots 
par(mfrow = c(d,d))
# change the figure margins setting 
par(mar = c(1,1,1,1))
# create a vector to store variable names
vname <- c("Intercept", "fitted"," fitted^2", 
           "fitted^3", "fitted^4")
for (i in c(1:d)){ 
  for (j in c(1:d)){
  if (i == j){
    plot(1, type = "n")
    # text the variable name 
    text(1,1, vname[i], cex = 2)
  }else{
    ce(c(i,j), 0.95, 41)
  }
  }
}
  
# set the figure margins to the default
par(mar=c(5.1, 4.1, 4.1, 2.1))
# set the figure arrangement to default 
par(mfrow = c(1,1))


