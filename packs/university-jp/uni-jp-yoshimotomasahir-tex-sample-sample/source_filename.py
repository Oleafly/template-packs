import matplotlib.pyplot as plt
import numpy as np

print("Hello World!")
# Comment (日本語は正しく表示されないよ)
X = np.array([i for i in range(-10,10)])
Y = np.exp(-(X * X) / (2 * 3 ** 2))
plt.bar(X, Y, width=1.0)
plt.show()