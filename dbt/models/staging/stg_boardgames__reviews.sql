with

reviews as (

  select * from {{ source('boardgame', 'reviews') }}

),

final as (

  select
    id as boardgame_id,
    user as review_username,
    round(
      cast(
        case
          when cast(rating as float) < 1 then 1
          else rating
        end as int
      ), 0
    ) as review_rating
  from reviews

)

select * from final