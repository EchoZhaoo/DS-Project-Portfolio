# Date: 2017/12/01
# Author: Chunni Zhao

# Load Packages
library(alr4)

# data preprocess
getwd()
setwd("/Users/echozhao/Documents/5302")
getwd()
Waste <- read.table("Waste.txt", sep = " ")
Waste <- Waste[,-7]
colnames(Waste) <- c("FTE", "ImprV", "LandV", 
                     "Size", "Use", "Wst")

# scatter plot
scatterplotMatrix(~ Wst + FTE + ImprV + LandV + 
                    Size + Use, data = Waste,
                  spread = FALSE, 
                  main = "Scatter Plot Matrix")

# regressor transformation
summary(powerTransform(cbind(FTE, ImprV, 
                             LandV, Size) ~ 1, Waste))


scatterplotMatrix(~ Wst + log(FTE) + log(ImprV) + 
                    log(LandV) + log(Size) + Use, 
                  data = Waste,
                  spread = FALSE, 
                  main = "Scatter Plot Matrix 2")


m1 <- lm(Wst ~ log(FTE) + log(ImprV) + 
           log(LandV) + log(Size) + Use, Waste)

# response transformation
inverseResponsePlot(m1)

m2 <- lm(log(Wst) ~ log(FTE) + log(ImprV) + 
           log(LandV) + log(Size) + Use, Waste)
summary(m2)

scatterplotMatrix(~ log(Wst) + log(FTE) + log(ImprV) + 
                    log(LandV) + log(Size) + Use, 
                  data = Waste,
                  spread = FALSE, 
                  main = "Scatter Plot Matrix 3",
                  labels = rownames(Waste),
                  id.n = 3, id.col = "red")


##### Fit models ######
# forward selection using AIC
m0 <- lm(log(Wst) ~ 1, Waste)
s1 <- step(m0,
           scope= list(upper = ~ (log(FTE) + log(ImprV) + 
                                   log(LandV) + log(Size)
                                 + Use)^2, 
                       lower = ~ 1), 
           direction="forward", k = 2)
summary(s1)

# Test for constant variance and curvature
residualPlots(s1)
plot(log(Waste$Wst), predict(s1))
abline(0,1)


# backward selection using BIC
m3 <- lm(log(Wst) ~ (log(FTE) + log(ImprV) + log(LandV) + log(Size) + Use)^2, Waste)
s2 <- step(m3,
           scope = list(upper = ~ (log(FTE) + log(ImprV) + 
                                    log(LandV) + log(Size)
                                  + Use)^2, 
                        lower = ~ 1), 
           direction = "backward")
summary(s2)
avPlots(s2, ~ log(LandV))
avPlots(s2, ~ log(FTE):log(ImprV))
avPlots(s2, ~ log(FTE):Use)
avPlots(s2, ~ log(ImprV):log(LandV))


# Test for constant variance and curvature
par(mfrow = c(2,3))
residualPlots(s2)
par(mfrow=c(1,1))

# scatter plot of response and fitted value
plot(log(Waste$Wst), predict(s2))
abline(0,1)

# outlierTest
outlierTest(s2, cutoff = 1, order = TRUE)

# plot the cook's distance
cook <- cooks.distance(s2)
plot(cook,ylab="Cooks distances")
points(21,cook[21],col='orange')
points(18,cook[18],col='blue')

### delete point 21
m4 <- lm(log(Wst) ~ (log(FTE) + log(ImprV) + log(LandV) + log(Size) + Use)^2, Waste[-21,])
s4 <- step(m4,
           scope = list(upper= ~ (log(FTE) + log(ImprV) + 
                                    log(LandV) + log(Size)
                                  + Use)^2, 
                        lower = ~ 1), 
           direction="backward")
summary(s4)

### delete point 18
m5 <- lm(log(Wst) ~ (log(FTE) + log(ImprV) + log(LandV) + log(Size) + Use)^2, Waste[c(-18),])
s5 <- step(m5,
           scope = list(upper= ~ (log(FTE) + log(ImprV) + 
                                    log(LandV) + log(Size)
                                  + Use)^2, 
                        lower = ~ 1), 
           direction="backward")
summary(s5)

### delete point 18 and 21
m6 <- lm(log(Wst) ~ (log(FTE) + log(ImprV) + log(LandV) + log(Size) + Use)^2, Waste[c(-18,-21),])
s6 <- step(m6,
           scope = list(upper= ~ (log(FTE) + log(ImprV) + 
                                    log(LandV) + log(Size)
                                  + Use)^2, 
                        lower = ~ 1), 
           direction="backward")
summary(s6)


# confidence region
betahat.not.i <- influence(m2)$coefficients
panel.fun <- function(x, y, ...){
  points(x, y, ...)
  dataEllipse(x, y, plot.points = FALSE, levels = c(.99))
  showLabels(x, y, labels=rownames(Waste), id.method = "mahal", id.n = 4)}
pairs(betahat.not.i, panel=panel.fun)
