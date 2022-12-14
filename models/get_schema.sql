{% set project_id = "`bmw-taxonomy-adherence`" %}
{% set dataset_location = "`region-europe-west3`" %}
{% set datasets = [] %}

{% set get_all_datasets %}
    SELECT
        schema_name AS dataset_id
    FROM
        {{project_id}}.{{dataset_location}}.INFORMATION_SCHEMA.SCHEMATA
{% endset %}
{% do log("Querying schemata." , info=True) %}
{% set results = run_query(get_all_datasets)%}

{% do log("Getting datasets." , info=True) %}
{% if execute %}
{% set datasets = results.columns[0].values() %}
{% else %}
{% set datasets = [] %}
{% endif %}
{% do log("Printing table." , info=True) %}

{% set get_tables %}
{% for dataset in datasets %}
SELECT * FROM {{project_id}}.{{dataset}}.__TABLES__  
{% endfor %}
{% endset %}
{% do log("Getting table data." , info=True) %}
{% set table_results = run_query(get_tables)%}

{# WITH table_details AS (
    {% for dataset in datasets %}    
    SELECT 
        table_id,
        dataset_id,
        creation_time,
        last_modified_time,
        CASE WHEN type = 1 THEN 'table' WHEN type = 2 THEN 'view' WHEN type = 3 THEN 'external' ELSE '?' END AS type,
        SUM(size_bytes)/pow(10,9) as size
    FROM 
        {{project_id}}.{{dataset}}.__TABLES__ 
    GROUP BY 
        1,2,3,4,5
    {% endfor %}
      ),
 
storage_details AS (
    SELECT 
        table_name,
        table_schema,
        SUM(total_rows) AS total_rows,
        SUM(total_partitions) AS total_partitions,
        SUM(total_logical_bytes) AS total_logical_bytes,
        SUM(active_logical_bytes) AS active_logical_bytes,
        SUM(long_term_logical_bytes) AS long_term_logical_bytes
    FROM 
        {{project_id}}.{{dataset_location}}.INFORMATION_SCHEMA.TABLE_STORAGE    
    GROUP BY 
        1,2
   )

SELECT * 
FROM table_details 
LEFT JOIN storage_details 
ON table_details.table_id=storage_details.table_name #}