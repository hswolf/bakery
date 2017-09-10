# Bakery Challenge

## Background
A bakery used to base the price of their produce on an individual item cost. So if a customer ordered 10
cross buns then they would be charged 10x the cost of single bun. The bakery has decided to start
selling their produce prepackaged in bunches and charging the customer on a per pack basis. So if the
shop sold vegemite scroll in packs of 3 and 5 and a customer ordered 8 they would get a pack of 3 and
a pack of 5. The bakery currently sells the following products:

| Name  |  Code |  Packs |
|---|---|---|
|  Vegemite Scroll | VS5  | 3 @ $6.99 <br> 5 @ $8.99 |
| Blueberry Muffin  | MB11  |  2 @ $9.95 <br> 5 @ $16.95 <br> 8 @ $24.95 |
| Croissant  | CF  |  3 @ $5.95 <br> 5 @ $9.95 <br> 9 @ $16.99 |

## Task
Given a customer order you are required to determine the cost and pack breakdown for each product.
To save on shipping space each order should contain the **minimal number of packs**.

## Input
Each order has a series of lines with each line containing the number of items followed by the product
code. An example input:
```
10 VS5
14 MB11
13 CF
```

## Output
A successfully passing test(s) that demonstrates the following output:
**We should care about only the total number of packs here, not which pack should be used**

```
10 VS5 $17.98
      2 x 5 $8.99
14 MB11 $54.8
      1 x 8 $24.95
      3 x 2 $9.95
13 CF $25.85
      2 x 5 $9.95
      1 x 3 $5.95
```

## How to run
```
bundle <!-- Required only in first running time -->
ruby main.rb
```
Output is in **output** file

### If you want to update product data, order data
Please change these files, **but keeping their format otherwise app cannot run appropriately.**
```
product.yml
input.yml
```
### If you want to use your own config files, please see
```
ruby main.rb -h
```

## Testing
```
rspec
```
```
..............................

Finished in 0.01062 seconds (files took 0.09845 seconds to load)
30 examples, 0 failures
```

## Benchmark
```
ruby benchmark.rb
```
```
       user     system      total        real
Benchmark case 1
   0.000000   0.000000   0.000000 (  0.000170)
Benchmark case 2
   0.010000   0.000000   0.010000 (  0.008545)
Benchmark case 3
   0.820000   0.000000   0.820000 (  0.825801)
Benchmark case 4
  95.540000   0.060000  95.600000 ( 95.663081)
Benchmark case 5
   8.440000   0.000000   8.440000 (  8.494925)
Benchmark case 6
  23.520000   0.010000  23.530000 ( 23.538386)
Benchmark case 7
  34.080000   0.010000  34.090000 ( 34.110215)
Benchmark case 8
  44.380000   0.000000  44.380000 ( 44.413392)
```
