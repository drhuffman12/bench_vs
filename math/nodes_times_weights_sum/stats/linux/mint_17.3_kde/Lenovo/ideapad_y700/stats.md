| Average - duration |                    | Bench seconds |                | 'time' (user) seconds |                |                                              |
| language           | version            | build/head    | regular/stable | build/head            | regular/stable | comments                                     |
| ------------------ | ------------------ | ------------- | -------------- | --------------------- | -------------- | -------------------------------------------- |
| Crystal            | 0.18.7             | 0.01472908    | 0.1521172      | 0.016                 | 0.396          | ~10x's faster (build)                        |
| jruby              | 1.7.25 (1.9.3p551) |               | 0.4198         |                       | 5.124          | ~ 2x's slower bench, ~20x's slower launching |
|                    | 9.1.2.0 (2.3.0)    | 0.4296        |                | 5.752                 |                |                                              |
| mruby              | 1.2.0              | 1.9022696     | 2.0387188      | 1.948                 | 2.036          | ~ 10x's slower                               |
| ruby               | 2.3.1              |               | 0.1604700262   |                       | 0.176          |                                              |
|                    | 2.4.0              | 0.1727488048  |                | 0.196                 |                |                                              |
