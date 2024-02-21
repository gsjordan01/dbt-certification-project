{{
  config(
    schema = 'seeds'
    )
}}


with

country_codes as (
  
  select * from {{ ref('country_codes') }}

),

final as (

  select
    country_name,
    country_code
  
  from country_codes

)

select * from final