{{
  config(
    materialized = 'incremental',
    unique_key = 'ranking_key',
    incremental_strategy = 'merge',
    merge_update_columns = ['is_current', 'valid_to']
    )
}}

with

rankings as (
  select * from {{ ref('stg_boardgames__rankings') }}
),

boardgames_filtered as (
  select * from {{ ref('int_boardgames__boardgames_filtered') }}
),

dim_rankings as (
  select
    {{ dbt_utils.generate_surrogate_key(['boardgame_rank', 'rankings.boardgame_id', 'updated_at']) }} as ranking_key,
    {{ dbt_utils.generate_surrogate_key(['rankings.boardgame_id']) }} as boardgame_key,
    boardgame_rank,
    boardgame_total_reviews,
    boardgame_url,
    boardgame_name,
    boardgame_thumbnail,
    updated_at,
    valid_from,
    valid_to,
    is_current
  from rankings
  where boardgame_id in ( select boardgame_id from boardgames_filtered )
)

select * from dim_rankings

{% if is_incremental() %}   
  -- Apply the filter on the incremental model
  -- (uses >= to include records arriving later than the previous 3 days)
  where updated_at > dateadd(day, -3, current_date)
{% endif %}