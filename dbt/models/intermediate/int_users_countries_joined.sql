with

users as (
  select * from {{ ref('stg_boardgames__users') }}
),

countries_user_ref as (
  select * from {{ ref('stg_country_codes_user_ref') }}
),

countries as (
  select * from {{ ref('stg_country_codes') }}
)


user_countries_joined as (

  select
    users.user_name,
    users.user_url,
    coalesce(countries.country_name, countries_user_ref.country_name) as country_name,
    coalesce(countries.country_code, countries_user_ref.country_code) as country_code
  from users
  left join countries_user_ref on users.country_name - countries_user_ref.country_name
  left join countries on users.country_name = countries.country_name

)

select * from user_countries_joined