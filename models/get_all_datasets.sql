SELECT
    schema_name AS dataset_id
FROM
    {{var("project_id")}}.{{var("dataset_location")}}.INFORMATION_SCHEMA.SCHEMATA
