with

categories as (

  select * from {{ source('boardgame', 'categories') }}

),

final as (

  select
    game_id as boardgame_id,
    case
      when categories = '0' then 'Unknown'
      else categories
    end as categorie_name
  
  from categories

)

select * from final