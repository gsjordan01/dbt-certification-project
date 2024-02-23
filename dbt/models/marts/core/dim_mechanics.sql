with

mechanics as (
  select * from {{ ref('stg_boardgames__mechanics') }}
),

boardgames_filtered as (
  select * from {{ ref('int_boardgames__boardgames_filtered') }}
),

dim_mechanics as (
  select distinct
    {{ dbt_utils.generate_surrogate_key(['mechanic_name', 'mechanics.boardgame_id']) }} as mechanic_key,
    {{ dbt_utils.generate_surrogate_key(['mechanics.boardgame_id']) }} as boardgame_key,
    mechanic_name
  from mechanics
  where mechanics.boardgame_id in ( select boardgame_id from boardgames_filtered )
)

select * from dim_mechanics