#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
#Автор: Igor A. Shmakov
#Первая версия: 2023-06-18
#Версия: 0.1
#Лицензия: GPLv3

Created on Sun Jun 18 22:02:48 2023
@author: Igor A. Shmakov
"""

__author__ = 'Igor A. Shmakov'
__license__ = "GPLv3"
__version__ = '0.1'
__date__ = '2023-06-18'


def fib(n: int) -> None:
    """
    Функция вычисляет n-ю последовательность Фибоначчи.
    Parameters
    ----------
    n : int
        число до которого нужно вычислить последовательность Фибоначчи.

    Returns
    -------
    None
        функиция ничего не возвращает.

    """
    ch = 0
    ch1 = 1
    
    for i in range(n):
        temp = ch1
        ch1 = ch
        ch = temp + ch1
        print(ch, end=" ")
    
    print()

    
if __name__ == "__main__":
    """
    Точка входа в программу/
    """
    n = int(input("""Введите целое число n, до которого нужно вычислить последовательнсть Фибоначчи: """))
    fib(n)