# DBT models

## selec specific models 

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

### project level
Note that I found if you config the test severity on the project level that 
```yaml
tests:
  +severity: warn  # all tests

  <package_name>:
    +warn_if: >10 # tests in <package_name>
```

### test severity on OOB generic model
however I found taht this actually works for the custom generic tests as well and that the example of the custom generic actually does not work

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

### example structure of dbt generic test using jinja control flow (if/then)
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
