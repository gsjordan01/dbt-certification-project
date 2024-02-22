with

boardgames as (
  select * from {{ ref('stg_boardgames__boardgames') }}
),

reviews as (
  select * from {{ ref('stg_boardgames__reviews') }}
),

boardgames_filtered as (
  select
    *
  from boardgames
  where 
    boardgame_id in ( select boardgame_id from reviews )
    and boardgames.boardgame_type = 'boardgame' 
    and boardgames.boardgame_avg_rating != -1
    and boardgames.boardgame_avg_weight != -1
)

select * from boardgames_filtered