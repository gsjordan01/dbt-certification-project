with

reviews as (
  select * from {{ ref('stg_boardgames__reviews') }}
),

dim_users as (
  select * from {{ ref('dim_users') }}
),

dim_boardgames as (
  select * from {{ ref('dim_boardgames') }}
),

fct_reviews as (
  select
    {{ dbt_utils.generate_surrogate_key(['dim_users.user_key', 'dim_boardgames.boardgame_key', 'review_rating']) }} as reviews_key,
    dim_users.user_key,
    dim_boardgames.boardgame_key,
    review_rating
  from reviews
  inner join dim_users on reviews.review_username = dim_users.user_username
  inner join dim_boardgames on reviews.boardgame_id = dim_boardgames.boardgame_id
)

select * from fct_reviews