{% set datasets = [] %}
{% set get_all_datasets %}
    SELECT
        schema_name AS dataset_id
    FROM
        {{var(project_id)}}.{{var(dataset_location)}}.INFORMATION_SCHEMA.SCHEMATA
{% endset %}
{% do log("Querying schemata." , info=True) %}
{% set results = run_query(get_all_datasets)%}

{% do log("Getting datasets." , info=True) %}
{% if execute %}
{% set datasets = results.columns[0].values() %}
{% else %}
{% set datasets = [] %}
{% endif %}