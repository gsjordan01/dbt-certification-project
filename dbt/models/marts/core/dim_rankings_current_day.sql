{{
    config(
        materialized='incremental',
        unique_key='ranking_key',
        pre_hook = [
            '{% if is_incremental() %} DELETE FROM {{this}} WHERE date(updated_at) <> current_date()  {% endif %}'
        ]
    )
}}

with dim_rankings as (
  select * from {{ ref('dim_rankings') }}
)

select * from dim_rankings

{% if is_incremental() %}
  -- Apply this filter if it is an incremental run
  -- we're going to select only the new records
  where updated_at > (select max(updated_at) from {{ this }})

{% endif %}
