'''
lab01: 拴牛鼻的绳子
'''
import math

def caculate(x):
    return 2 * x * math.cos(x)**2 + math.pi/2 - math.sin(x) * math.cos(x) - math.pi/4

def main():
    r = 10
    x = 0
    x0 = caculate(x)

    while abs(x0 - x) >= 0.00001:
        x = x0;
        x0 = caculate(x)
    R = 2 * 10 * math.cos(x0)

    print("x0 = ", x0)
    print("R = ", R)

if __name__ == "__main__":
    main()