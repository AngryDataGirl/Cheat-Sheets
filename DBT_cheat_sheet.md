# DBT models

## selec specific models 

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
however I found that this actually works for the custom generic tests as well and that the example of the custom generic actually does not work

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
While it is sorta implied in the contextual text before the examples, 
Note that in the offical documentation the singular test example is simply: 
```yaml
{{ config(error_if = '>50') }}
```
This will not apply if you do not also add a config line on the singular model to tell it which severity to check for:

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
- actually this might not work since the run-query will return a table, and you are evaluating it against a single value
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

## What if the if statement depends on a dynamic model?
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
