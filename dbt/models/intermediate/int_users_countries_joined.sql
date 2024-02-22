with

users as (

  select * from {{ ref('stg_boardgames__users') }}

),

countries as (

  select * from {{ ref('stg_country_codes_user_ref') }}

),

final as (

  select
    u.user_name,
    u.user_url,
    c.country_code

  from users u
  join
  countries c on u.country_name = c.country_name

)

select * from final