select
  country_code
from {{ ref('country_codes') }}
where len(country_code) <> 3
