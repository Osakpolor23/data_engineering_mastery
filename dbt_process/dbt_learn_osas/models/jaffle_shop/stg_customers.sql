select
        id as customer_id,
        first_name,
        last_name

    from {{ source('dbt_dataset', 'customers') }} --my-dbt-project-486616.dbt_dataset.customers