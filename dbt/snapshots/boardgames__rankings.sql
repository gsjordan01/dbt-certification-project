{% snapshot rankings_snapshot %}

{{
   config(
       target_schema='dbt_jordanGS',
       unique_key='id',
       strategy='timestamp',
       updated_at='updated_at',
   )
}}

select
  id,
  "Average",
  "Bayes average",
  "Name",
  "Rank",
  "Thumbnail",
  url,
  "Users rated",
  "Year",
  "updated_at" as updated_at
from {{ source('boardgame', 'rankings') }}

{% endsnapshot %}