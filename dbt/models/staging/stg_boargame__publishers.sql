with

publishers as (

  select * from {{ source('boardgame', 'publishers') }}

),

final as (

  select
    game_id as boardgame_id,
    case
      when publishers = '0' then 'Unknown'
      else publishers
    end as designer_name
  
  from publishers

)

select * from final