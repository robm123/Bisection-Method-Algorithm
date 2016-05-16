# ![](https://cdn2.iconfinder.com/data/icons/science-and-research-line/80/negative_line_gaph_cosine_sine_negative-24.png)Bisection Method Algorithm

Uses: Mips Assembly language

The bisection method finds the root of a given continous function. This program uses the function:

  ![](http://latex2png.com/output//latex_0f3e4e898b5152e353e571dafd2e4679.png)

It askes the user for

* Point A
* Point B
* Tolerance

using these two points from the user, it narrows down in which interval the root lies in. Once finding out in which interval it lies in, 
whether   ![](https://latex.codecogs.com/gif.latex?%5Ba%2C%20midpoint%5D%20or%20%5Bmidpoint%2C%20b%5D) , it then chooses that sub interval to repeat the process to get to the root.

it displays a table to the user with the given information 

* Point A
* Point B
* midpoint
* ![](https://latex.codecogs.com/gif.latex?f%28a%29)
* ![](https://latex.codecogs.com/gif.latex?f%28b%29)
* ![](https://latex.codecogs.com/gif.latex?f%28midpoint%29)
