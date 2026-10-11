# Importation des bibliothèques
import numpy as np
import pandas as pd

df = pd.read_csv("data.csv")
model = LinearRegression().fit(X, y)