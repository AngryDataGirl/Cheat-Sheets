# DBT Cheat Sheet

- [dbt_commands](#dbt-commands)
  - [Selecting models](#selecting-models)
  - [Selecting tests](#selecting-tests)
- [Structure and config](#structure-and-config)
  - [Where to save singular tests](#where-to-save-singular-tests) 
  - [Defining custom test names](#defining-custom-test-names)
- [Creating tests]
- [Notes on creating macros](#notes-on-creating-macros)
  - [Printing output](#printing-output) 
  - [Accessing models or context items through the graph node](#accessing-models-or-context-items-through-the-graph-node) 

## dbt commands
- by default `dbt run` runes everything
- use `--select` flag to specify a subset of nodes
  
|command|arguments|
|-------|---------|
|run|`--select`, `--exclude`, `--selector`, `--defer`|
|test|`--select`, `--exclude`, `--selector`, `--defer`|
|seed|`--select`, `--exclude`, `--selector`|
|snapshot|`--select`, `--exclude`, `--selector`|
|ls(list)|`--select`, `--exclude`, `--selector`, `--resource-type`|
|compile|`--select`, `--exclude`, `--selector`,`--inline`|
|freshness|`--select`, `--exclude`, `--selector`|
|build|`--select`, `--exclude`, `--selector`,`--resource-type`,`--defer`|


## Selecting Models  
```python 
# Run tests on a model (indirect selection) / upstream / downstream
$ dbt test --select customers / +stg_customers / stg_customers+

# Run tests on all models with a particular tag (direct + indirect) - note that tag has to be set on the model in the yaml config / multi tags selection USE COMMA NO SPACES
$ dbt test --select tag:my_model_tag
$ dbt run --select tag:my_model_tag1,tag:my_model_tag2
```

## Selecting Tests
[Test selection examples | dbt Developer Hub (getdbt.com)](https://docs.getdbt.com/reference/node-selection/test-selection-examples)

```python
# singular / generic 
$ dbt test --select test_type:singular / generic

# directly select the test by name
$ dbt test --select (test_name) 
```

# Structure and config 

## Where to save singular tests 
save singular tests as sql queries in the test path, no need to put them in directory, dbt will know where to find them so long as they are with your other tests  

## Defining custom test names 
(more human readable)
[define a custom name for one test](https://docs.getdbt.com/reference/resource-properties/tests#define-a-custom-name-for-one-test)

By default, dbt will synthesize a name for your generic test by concatenating:
- test name (not_null, unique, etc)
- model name (or source/seed/snapshot)
- column name (if relevant)
- arguments (if relevant, e.g. values for accepted_values)
It does not include any configurations for the test. If the concatenated name is too long, dbt will use a truncated and hashed version instead. The goal is to preserve unique identifiers for all resources in your project, including tests.

By defining a custom name, you get full control over how the test will appear in log messages and metadata artifacts. You'll also be able to select the test by that name.

```yaml
version: 2

models:
  - name: orders
    columns:
      - name: status
        tests:
          - accepted_values:
              name: unexpected_order_status_today
              values: ['placed', 'shipped', 'completed', 'returned']
              config:
                where: "order_date = current_date"
```

# Creating tests

generic test config bloc
```SQL
{% test column_exists(model, column_name) %}

SELECT table_name, column_name, data_type, data_length
FROM USER_TAB_COLUMNS
WHERE table_name = '{{model}}'
AND column_name = '{{column_name}}'

{% endtest %}
```

## Storing test failures

[Tests | dbt Developer Hub (getdbt.com)](https://docs.getdbt.com/docs/build/tests#storing-test-failures)

[store_failures | dbt Developer Hub (getdbt.com)](https://docs.getdbt.com/reference/resource-configs/store_failures#description)

Normally, a test query will calculate failures as part of its execution. If you set the optional `--store-failures` flag or `[store_failures` config](https://docs.getdbt.com/reference/resource-configs/store_failures), dbt will first save the results of a test query to a table in the database, and then query that table to calculate the number of failures.

This workflow allows you to query and examine failing records much more quickly in development

add this block to the yml to globally store failures
```yaml
tests:
  +store_failures: true
  +schema: the_island_of_misfit_tests
```

# Notes on creating macros 

## Printing output
useful for macros and seeing results of macro code 
```sql
-- {{ print(results) }}
-- {{ print(results_list[0]) }}
```

## Accessing models or context items through the graph node
https://docs.getdbt.com/reference/dbt-jinja-functions/graph#:~:text=The%20graph%20context%20variable%20is%20a%20dictionary%20which,node%20ids%20onto%20dictionary%20representations%20of%20those%20nodes.

```sql
{% if execute %}
  {% for node in graph.nodes.values()
     | selectattr("resource_type", "equalto", "model")
     | selectattr("package_name", "equalto", "snowplow") %}
  
    {% do log(node.unique_id ~ ", materialized: " ~ node.config.materialized, info=true) %}
  
  {% endfor %}
{% endif %}
```
- the join is to concatenate the separate tags to strings separated by a blank space
- note that, we still need to give each element single quotes   
```
{% macro get_models_with_tag(tag) %}

{% if execute %}

{% set models_with_tag = [] %}
{% for model in graph.nodes.values() | selectattr("resource_type", "equalto", "model") %}

    {% if tag in model.config.tags %}
        {{ models_with_tag.append(model.name) }}
    {% endif %}

{% endfor %}

{{ return(models_with_tag|join(',')) }}
{% endif %}

{% endmacro %}

```

# config inheritance

## general config inheritance
- Official Documentation : [https://docs.getdbt.com/reference/configs-and-properties#config-inheritance]
  - dbt prioritizes configurations in order of <b>specificity</b>, from most specificity to least specificity.
  - This generally follows the order above: an in-file config() block --> properties defined in a .yml file --> config defined in the project file.

## test configs inheritance
- Generic tests work a little differently when it comes to specificity. See test configs : [https://docs.getdbt.com/reference/test-configs]
  - Test configs are applied <b>hierarchically</b>:
    1. Properties within .yml definition (generic tests only, see test properties for full syntax)
    2. A config() block within the test's SQL definition
    3. In dbt_project.yml
- Examples: 
  - In the case of a singular test, the config() block within the SQL definition takes precedence over configs in the project file.
  - In the case of a specific instance of a generic test:
    1. test's .yml properties 
    2. values set in its generic SQL definition's config()
    3. values set in dbt_project.yml.

# DBT tests

## test severity configs 
Official Documentation: [https://docs.getdbt.com/reference/resource-configs/severity]

The relevant configs are:
- severity: error or warn (default: error)
- error_if: conditional expression (default: !=0)
- warn_if: conditional expression (default: !=0)

Note that each of these configs need to be wrapped in their own config {{}} like this

```python
{{ config(severity = 'warn') }}
{{ config(warn_if = '>=1') }}
```

### project level test severity 

```yaml
tests:
  +severity: warn  # all tests

  <package_name>:
    +warn_if: >10 # tests in <package_name>
```

### test severity on OOB generic model
However I found that this actually works for the custom generic tests as well and that the example of the custom generic actually does not work

```yml
models:
  - name: large_table
    columns:
      - name: slightly_unreliable_column
        tests:
          - unique:
              config:
                severity: error
                error_if: ">1000"
                warn_if: ">10"
```

### test severity on singular model
While it is sorta implied in the contextual text before the examples, note that in the offical documentation the singular test example is simply: 
```yaml
{{ config(error_if = '>50') }}
```
This will not apply if you do not also add a config line on the singular model to tell it which severity to check for. So your test severity config block at the beginning of your file needs to look like this: 

```yaml
{# singular test severity : warn #}
{{ config(severity = 'error') }}
{{ config(error_if = '>=1') }}

{# singular test severity : error #}
{{ config(severity = 'warn') }}
{{ config(warn_if = '>=1') }}
```

# DBT macros + jinja (+ and testing) 

## example structure of dbt generic test using jinja control flow (if/then)
Official Documentation on Jinja and Macros: [https://docs.getdbt.com/docs/build/jinja-macros]
Really good tutorial on Jinja: [https://ttl255.com/jinja2-tutorial-part-2-loops-and-conditionals/]

```sql
{% test test_name(model, column_name, custom_col1, custom_col2) %}

  {% if run_query("[SELECT * FROM model statement]") == 0 %}
  
  SELECT * FROM statement1 
  
  {% else %}
  
  SELECT * FROM statement2 
  
  {% endif %}

{% endtest %}
```
- actually this might not work since the run-query will return a <b>table</b>, and you are evaluating it against a single value
- the below code returns proper flow / results

```sql

{% set test_query %}

SELECT count(*)
FROM
(
SELECT *
WHERE 
    table_name = 'table_name'
    AND column_name = 'column_name'
)   

{% endset %}

{% set results = run_query(test_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ print(results) }}
{{ print(results_list[0]) }}

{% if results_list[0] != 0 %}

SELECT 'not equal to zero' as x FROM dual

{% else %}

SELECT 'zero' as x FROM dual

{% endif %}

```
- you also want to take note of '' and "  ''  "
- in the example below, I have a generic test where I am passing in the model to the test-query -- which we will run and return a count
- if you don't set your quotations properly, the model might still run, but you will not get the intended results bc the if / then flow statement is not triggering as the comparison is empty

```sql
{% test test_column_null_values(model, column_name, date_column) %}

{{ config(severity = 'warn') }}

{% set test_query %}

SELECT count(*)
FROM
(
SELECT column_name, table_name FROM USER_TAB_COLUMNS
WHERE 
    table_name = "'{{ model }}'"
    AND column_name = "'column_name'"
)   

{% endset %}

```
- then it turns out that dbt is returning a combination of my schema & table name, which it cannot find in the DB, ie 'USERNMAE.test_table' and it's not that that doesn't exist as a table, but that that is not how the information is stored on the USER_TAB_COLUMNS.
- thankfully, I found this https://docs.getdbt.com/reference/dbt-jinja-functions/model, you can do <b>{{ model.name }}</b>

```sql

{% set test_query %}

SELECT count(*)
FROM
(
SELECT column_name, table_name FROM USER_TAB_COLUMNS
WHERE 
    table_name = '{{ model.name }}'
    AND column_name = 'EMP_STAT_ID'
)   

{% endset %}
``` 

## What if the IF statement depends on a dynamic model?
- ie, you want to feed it a variable that may change in the jinja
- there migh be a smarter way to make sure it compiles & without a macro, but I thought it would be good to have the sql query run as a macro, where it is super simple to sub in the variable that will change
- then call that macro in the if statement
- note that in this example the changing variable was 'model' and 'model' is also one of the default arguments for a custom generic test
- the if statement required a sql statement, where I am checking if the column exists on a particular table
- this would also be used on other tables, which is why I need to sub in the {{model}}
- this documentation was important to know why it was running into compile errors (and more difficult to have the query pasted into the {{if block}} of the jinja statement [https://docs.getdbt.com/docs/building-a-dbt-project/dont-nest-your-curlies]

### the macro 
```sql
{% macro check_if_column_exists(column_name, model) %}

 SELECT CASE WHEN count(*) = 0 THEN 'FALSE' ELSE 'TRUE' END AS column_existence
    FROM (
        SELECT column_name, table_name FROM USER_TAB_COLUMNS
        WHERE 
            table_name = {{ model }}
            AND column_name = {{ column_name }}
            )

{% endmacro %}
```
### the if statement in the test 
```sql
{% if check_if_column_exists('column_name','model') == 'TRUE' %} #calling the macro

SELECT *    
FROM {{ model }} #this is the same model variable 
WHERE ...
{% else %}

SELECT * 
FROM {{ model }}
WHERE ...

{% endif %}

{% endtest %}
``` 
