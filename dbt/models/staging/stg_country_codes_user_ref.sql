{{
  config(
    schema = 'seeds'
    )
}}


with

country_codes_users_ref as (
  
  select * from {{ ref('country_codes_users_ref') }}

),

final as (

  select
    country_name,
    country_code
  
  from country_codes_users_ref

)

select * from final