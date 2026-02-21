select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from my-dbt-project-486616.dbt_dataset.orders