## Sunwatch

Provides daily or hourly UV information for the US by zipcode or city/state. UV data is provided by the EPA.

### Usage

Daily UV info:

    require 'sunwatch'

    Sunwatch.daily_uv_info_for(city: 'Seattle', state: 'WA')
    # or
    Sunwatch.daily_uv_info_for(zipcode: '98103')

    # return type
    uv_info = Sunwatch.daily_uv_info_for(zipcode: '98103')
    uv_info.zipcode  # => 98103
    uv_info.uv_index # => 3
    uv_info.uv_alert # => 1

Hourly UV info:

    require 'sunwatch'

    Sunwatch.hourly_uv_info_for(city: 'Seattle', state: 'WA')
    Sunwatch.hourly_uv_info_for(zipcode: '98103')

    # return type
    uv_info = Sunwatch.hourly_uv_info_for(zipcode: '98103')
    uv_info.zipcode # => 98103
    
    uv_info.hours.each do |hour|

## Contributing

1. [Fork it](https://github/jstenhouse/sunwatch/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
