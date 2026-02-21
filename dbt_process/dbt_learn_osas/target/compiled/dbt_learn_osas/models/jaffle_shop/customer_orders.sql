

with customers as (
 
    select * from `my-dbt-project-486616`.`dbt_dataset`.`stg_customers` -- to reference the stg_customers model
 
),
 
orders as (
 
    select * from `my-dbt-project-486616`.`dbt_dataset`.`stg_orders`
 
),
 
customer_orders as (
 
    select
        customer_id,
 
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
 
    from orders
 
    group by 1
 
),
 
final as (
 
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders
 
    from customers
 
    left join customer_orders using (customer_id)
 
)
 
select * from final --for first run, use dbt run --select +customer_orders (to run d downstream models first)