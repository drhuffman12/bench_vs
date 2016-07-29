| Average - duration |         | Bench seconds |                | 'time' (user) seconds |                |                       |
|--------------------|---------|---------------|----------------|-----------------------|----------------|-----------------------|
| language           | version | build/head    | regular/stable | build/head            | regular/stable | comments              |
| Crystal            | 0.18.7  | 0.01386758    | 0.14259954     | 0.012                 | 0.388          | ~10x's faster (build) |
| jruby              | n/a     |               |                |                       |                | tbd                   |
| mruby              | 1.9     | 2.6646974     | 2.060629       | 2.352                 | 2.188          | ~ 10x's slower        |
| ruby               | 2.3.1   |               | 0.1813885104   |                       | 0.204          |                       |
|                    | 2.4.0   | 0.1720886014  |                | 0.188                 |                |                       |
