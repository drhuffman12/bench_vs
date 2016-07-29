# This benchmark compares a neural-network-like algorithm. 

For Neural Networks, you typically take use various propogation functions to a 1D array of inputs and a 2D array of weights into a 1D array of outputs.

Here we are just multiplying the inputs acros the weights and summing up the partial results to get the outputs with the following pseudo-code:
   
   * generate a 1D array (i.e.: n1) of random values
   * generate a 2D array (i.e.: w1) of random values
   * for each element in a 1D array (e.g.: n1[i])
     - multiply to each element in a slice of a 2D array horizontally into a 2D array of partial results (e.g.: w2[i,j] = n1[i]*w1[i,j])
   * then, sum up the columns of resulting values (e.g.: n2[j] = sum(w2[*,j]) 

# Dependancies:
 * rvm ("https://rvm.io/")
 * crenv ("https://github.com/pine/crenv")
 * crenv-update ("https://github.com/pine/crenv-update")

# Results:

| Average - duration |                    | Bench seconds |                | 'time' (user) seconds |                |                                              |
| language           | version            | build/head    | regular/stable | build/head            | regular/stable | comments                                     |
|--------------------|--------------------|---------------|----------------|-----------------------|----------------|----------------------------------------------|
| Crystal            | 0.18.7             | 0.01472908    | 0.1521172      | 0.016                 | 0.396          | ~10x's faster (build)                        |
| jruby              | 1.7.25 (1.9.3p551) |               | 0.4198         |                       | 5.124          | ~ 2x's slower bench, ~20x's slower launching |
|                    | 9.1.2.0 (2.3.0)    | 0.4296        |                | 5.752                 |                |                                              |
| mruby              | 1.2.0              | 1.9022696     | 2.0387188      | 1.948                 | 2.036          | ~ 10x's slower                               |
| ruby               | 2.3.1              |               | 0.1604700262   |                       | 0.176          |                                              |
|                    | 2.4.0              | 0.1727488048  |                | 0.196                 |                |                                              |
