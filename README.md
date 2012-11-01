# GeoNames API

This is a lightweight client for the [GeoNames](http://www.geonames.org) API. Huge thanks to them for such a great service!

There are many GeoNames API clients. BUT, most are rewritten versions of a Java API whose interface is a little funny =|

This is a simplified ruby implementation that does not implement the entire API. But, its lightweight and has a nice interface and will be easy to extend :)

The gem was written by [@barelyknown](http://twitter.com/barelyknown).

## Getting Started

Add this line to your application's Gemfile:

    gem 'geonames_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geonames_api

## Usage

### FYI

GeoNamesAPI uses conventions similar to Rails' ActiveRecord. If you add any features, please stick to `find` and `all` as the core query methods.

The data is converted into the type implied by the content by default. If that isn't sufficient, let's create something more explicit for the exceptions.

The GeoNamesAPI classes include getters and setters that are the GeoNames API field names converted dynamically to more rubyish names using Rails' ActiveSupport `underscore` method. If the API ever changes, the attributes of the classes will change.

### Configuration

The gem is setup to use the `demo` user account by default. You'll need to provide your own credentials for anything but a simple set of test searches.

    > GeoNamesAPI.username = "yourusername@yourdomain.com"
    > GeoNamesAPI.lang = :en
    
For a complete list of the config options, take a look at the `geonames_api.rb` file.

### Country

The geonames api uses the ISO code of the country as its natural key. 

    > GeoNamesAPI::Country.new("US").find
    
    => #<GeoNamesAPI::Country:0x007fd43503dfc0 @country_code="US", @country_name="United States", @currency_code="USD", @fips_code="US", @iso_numeric=840, @north=49.388611, @capital="Washington", @continent_name="North America", @area_in_sq_km=9629091.0, @languages="en-US,es-US,haw,fr", @iso_alpha3="USA", @continent="NA", @south=24.544245, @east=-66.954811, @geoname_id=6252001, @west=-124.733253, @population=310232863>

    > GeoNamesAPI::Country.all
    
    => ... array of GeoNamesAPI::Country instances

### Weather

The geonames api uses the latitude and longitude of the place as the parameters for its weather service.

    > GeoNamesAPI::Weather.new(41.88,-87.68).find
    
    => #<GeoNamesAPI::Weather:0x007fab1c80dc10 @latitude=41.88, @longitude=-87.68, @weather_condition="n/a", @clouds="few clouds", @observation="KMDW 012051Z 28009KT 10SM FEW049 BKN070 11/M02 A2983 RMK AO2 SLP105 T01111022 55010", @wind_direction=280, @icao="KMDW", @sea_level_pressure=1010.5, @elevation=188, @country_code="US", @clouds_code="FEW", @lng=-87.75, @temperature=11.1, @dew_point="-2.2", @wind_speed=9, @humidity=39, @station_name="Chicago, Chicago Midway Airport", @datetime="2012-11-01 20:51:00", @lat=41.78333333333333>

### Others

The other services will be implemented as needed. In the mean time, feel free to contribute! Let's keep the style consistent.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Thanks <3