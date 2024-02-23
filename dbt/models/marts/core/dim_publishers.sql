with

publishers as (
  select * from {{ ref('stg_boardgames__publishers') }}
),

boardgames_filtered as (
  select * from {{ ref('int_boardgames__boardgames_filtered') }}
),

dim_publishers as (
  select distinct
  {{ dbt_utils.generate_surrogate_key(['publisher_name', 'publishers.boardgame_id']) }} as publisher_key,
  {{ dbt_utils.generate_surrogate_key(['publishers.boardgame_id']) }} as boardgame_key,
  publisher_name
  from publishers
  where publishers.boardgame_id in ( select boardgame_id from boardgames_filtered )
)

select * from dim_publishers