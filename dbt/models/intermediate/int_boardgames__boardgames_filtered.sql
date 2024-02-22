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
    and boardgames.boardgame_type = {{ var('boardgame_type') }}
    and boardgames.boardgame_avg_rating != {{{ var('number_unknown') }}}
    and boardgames.boardgame_avg_weight != {{ var('number_unknown') }}
)

select * from boardgames_filtered