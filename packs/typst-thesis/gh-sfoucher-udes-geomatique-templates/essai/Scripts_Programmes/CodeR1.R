# Chargement des packages --------------------------
library("tidyverse")
library("sf")
rm(list = ls())

df <- read.csv("data.csv")
model <- lm(y ~ x, data = df)
summary(model)