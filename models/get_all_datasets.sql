{% set datasets = [] %}
{% set results = [] %}

{% set get_all_datasets %}   
    SELECT
        schema_name AS dataset_id
    FROM
        {{var("project_id")}}.{{var("dataset_location")}}.INFORMATION_SCHEMA.SCHEMATA
{% endset %}
{% do log("Querying schemata." , info=True) %}
--{% set results = run_query(get_all_datasets)%}
--{% set datasets = results.columns[0].values() %}

{# {% for dataset in datasets %}
SELECT * FROM {{var("project_id")}}.{{var("dataset")}}.__TABLES__ 
{% endfor %} #}