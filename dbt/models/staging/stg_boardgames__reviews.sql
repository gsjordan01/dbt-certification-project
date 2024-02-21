with

reviews as (

  select * from {{ source('boardgame', 'reviews') }}

),

final as (

  select
    id as boardgame_id,
    user as review_username,
    round( cast(rating as int), 0 ) as review_rating
  from reviews

)

select * from final