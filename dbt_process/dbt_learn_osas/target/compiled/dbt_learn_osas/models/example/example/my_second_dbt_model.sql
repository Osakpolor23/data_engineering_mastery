-- Use the `ref` function to select from other models

select *
from `my-dbt-project-486616`.`dbt_dataset`.`my_first_dbt_model`
where id = 1