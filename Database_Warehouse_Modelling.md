# Notes on Database Warehouse Modelling

# Star Schema
- contains Facts and Dimensions Tables
- Fact table contains "facts" such as transaction amounts and quantities
- Dimension Tables are like "time" or "product"

## Benefits of star schemas
- simple to understand and implement
- good for simple queries because of their reduced dependency on joins when accessing the data, as compared to normalized models like snowflake schemas.
- Adapt well to fit OLAP models.
- Improved query performance as compared to normalized data, because star schemas attempt to avoid computationally expensive joins.

## How does a star schema differ from 3NF (Third Normal Form)?
- 3NF, or Third Normal Form, is a method of reducing data-redundancy through normalization. 
- it typically has more tables than a star schema due to data normalization but queries are more complex due to the increased number of joins between large tables
