with

src_users as (
  
  select * from {{ source('boardgame', 'users') }}

),

final as (

  select
    users as user_username,
    url as user_url,
    case
      when trim(country) is NULL then 'Unknown'
      when trim(country) = 'NA' then 'Unknown'
      when country = '' then 'Unknown'
      when len(country) = 2 then 'Unknown'
      else trim(country)
    end as country_name

  from src_users
)

select * from final