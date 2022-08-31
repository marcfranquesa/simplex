# simplex
Matlab implementation of [Dantzig's simplex algorithm](https://en.wikipedia.org/wiki/Simplex_algorithm).

## Usage
Inside the [data folder](/Data/) you can find a couple of input examples, the first number corresponds to the amount of dimensions, the second to the amount of restrictions. We then have the matrix A and vector b correponding to the restrictions.

Here is the output of example1:
```
Starting simplex without Bland rule.
Phase I 
   Iteration   1 : q =  6, rq =  -434.000 B(p) = 22, theta* =     0.118, z =  2465.941
   Iteration   2 : q =  2, rq =  -825.059 B(p) = 26, theta* =     0.790, z =  1814.140
   Iteration   3 : q = 10, rq =  -781.910 B(p) = 23, theta* =     0.243, z =  1624.345
   Iteration   4 : q =  1, rq =  -637.946 B(p) = 27, theta* =     0.050, z =  1592.379
   Iteration   5 : q = 12, rq =  -423.158 B(p) = 24, theta* =     0.622, z =  1329.280
   Iteration   6 : q = 13, rq =  -777.400 B(p) = 29, theta* =     0.615, z =   851.346
   Iteration   7 : q =  8, rq =  -395.141 B(p) = 21, theta* =     0.204, z =   770.813
   Iteration   8 : q =  7, rq =  -289.007 B(p) = 28, theta* =     1.265, z =   405.169
   Iteration   9 : q = 11, rq =  -323.281 B(p) = 30, theta* =     0.779, z =   153.300
   Iteration  10 : q =  4, rq =  -279.795 B(p) = 25, theta* =     0.548, z =     0.000
   Iteration  11 : Basic feasible solution found. Proceding to phase II.
Phase II 
   Iteration  12 : q = 14, rq =  -222.279 B(p) =  1, theta* =     0.535, z =   165.071
   Iteration  13 : q =  9, rq =  -169.363 B(p) =  2, theta* =     1.214, z =   -40.452
   Iteration  14 : q =  5, rq =  -168.593 B(p) = 11, theta* =     1.280, z =  -256.208
   Iteration  15 : q =  3, rq =   -60.662 B(p) = 12, theta* =     0.755, z =  -301.998
   Iteration  16 : q = 20, rq =    -0.742 B(p) =  3, theta* =   171.819, z =  -429.484
   Iteration  17 : q =  1, rq =   -59.214 B(p) =  4, theta* =     1.017, z =  -489.682
   Iteration  18 : q = 19, rq =    -0.882 B(p) =  8, theta* =    16.973, z =  -504.654
   Iteration  19 : q =  4, rq =  -113.318 B(p) =  1, theta* =     0.655, z =  -578.904
   Iteration  20 : Optimal solution found.
End of ASP.
VB* =
    19     6    10    20     4     9    14     7    13     5

xb* =
  Columns 1 through 8

  157.6053    1.5836    1.7889  315.0541    0.6552    2.3107    3.2413    1.2383

  Columns 9 through 10

    2.2902    0.8961

VNB* =
    12    11     2     1    15    16    17    18     8     3

r* =
  Columns 1 through 8

   89.4415   44.9331  196.8803   74.4212    0.2935    0.3284    0.3002    0.1781

  Columns 9 through 10

  200.2289   57.8986

z* =
 -578.9036
```