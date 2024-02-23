with

designers as(
  select * from {{ ref('stg_boardgames__designers') }}
),

boardgames_filtered as (
  select * from {{ ref('int_boardgames__boardgames_filtered') }}
),

dim_designers as (
  select distinct
  {{dbt_utils.generate_surrogate_key(['designer_name', 'designers.boardgame_id'])}} as designer_key,
  {{dbt_utils.generate_surrogate_key(['designers.boardgame_id'])}} as boardgame_key,
  designer_name
  from designers
  where designers.boardgame_id in (select boardgame_id from boardgames_filtered)
)

select * from dim_designers