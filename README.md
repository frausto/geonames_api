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

GeoNamesAPI uses conventions similar (but not exactly the same) to Rails' ActiveRecord. If you add any features, please stick to `find` and `all` as the core query methods.

The data is converted into the type implied by the content by default. If that isn't sufficient, let's create something more explicit for the exceptions.

The GeoNamesAPI classes include getters and setters that are the GeoNames API field names converted dynamically to more rubyish names using Rails' ActiveSupport `underscore` method. If the API ever changes, the attributes of the classes will change.

There are some extra methods in most of the key classes. Documentation is included below.

### Configuration

The gem is setup to use the `demo` user account by default. You'll need to provide your own credentials for anything but a simple set of test searches.

    > GeoNamesAPI.username = "yourusername@yourdomain.com"

    > GeoNamesAPI.lang = :en

    > GeoNamesAPI.formatted = true

    > GeoNamesAPI.url = "http://api.geonames.org/"
      the base url

    > GeoNamesAPI.style = :full
      values can be (:short ,:medium, :long, :full) depending on how much data you want back

    > GeoNamesAPI.logger = Logger.new("blah.log")
      logger must respond to :info. By default there is no logging.

## LocationObjects

### GeoPoint
A point with "lat" "long" coordinates.
  > GeoNamesAPI::GeoPoint.new(lat,long)
  > ex: GeoNamesAPI::GeoPoint.new("37.451","-122.18")

  The following instance methods are available:

    > postalcodes:          returns type GeoNamesAPI::Endpoint::PostalCode
    > country_subdivisions: returns type GeoNamesAPI::Endpoint::CountrySubdivision
    > places:               returns type GeoNamesAPI::Endpoint::Place
    > place_names:          returns type GeoNamesAPI::Endpoint::PlaceName
    > streets:              returns type GeoNamesAPI::Endpoint::Street
    > elevation:            returns type GeoNamesAPI::Endpoint::Elevation
    > timezone:             returns type GeoNamesAPI::Endpoint::TimeZone
    > weather:              returns type GeoNamesAPI::Endpoint::Weather
    > wiki:                 returns type GeoNamesAPI::Endpoint::Wikipedia
    > country_code:         returns type GeoNamesAPI::Endpoint::CountryCode
    > country:              returns type GeoNamesAPI::Endpoint::Country

### GeoBox

Parameters : north,south,east,west : coordinates of bounding box
  > GeoNamesAPI::GeoBox.new(north,south,east,west)
  > ex: GeoNamesAPI::GeoBox.new(44.1,-9.9,-22.4,55.2)

  The following instance methods are available:

    > earthquakes:  returns type GeoNamesAPI::Endpoint::Earthquake
    > cities:       returns type GeoNamesAPI::Endpoint::City

### GeoPlace

A place with a geonameId
  > GeoNamesAPI::GeoPoint.new(geonameId)
  > ex: GeoNamesAPI::GeoPoint.new(2593110)

  The following instance methods are available:

    > children:   returns type GeoNamesAPI::Endpoint::Children
    > hierarchy:  returns type GeoNamesAPI::Endpoint::Hierarchy


## Endpoints

These are the objects that hit the geoNames endpoints to get data. All endpoint objects have the methods:

    > geo_point
    > geo_box
    > geo_place

which will return the specified location object if the data exists (in the response from the service) to create such an object, otherwise it will return nil

### PlaceSearch

The GeoNamesAPI search. you can see more details at http://www.geonames.org/export/geonames-search.html
  
  Examples:

    FIND:
    > searches all data about a place
    > GeoNamesAPI::Endpoint::PlaceSearch.find(q, maxRows)
    > weather = GeoNamesAPI::Endpoint::PlaceSearch.find("ohio corn", "10")

    FIND_BY_PLACE_NAME:
    > searches only on the name of a place
    > GeoNamesAPI::Endpoint::PlaceSearch.find_by_place_name(name, maxRows)
    > GeoNamesAPI::Endpoint::PlaceSearch.find_by_place_name("ohio", "10")

    FIND_BY_EXACT_PLACE_NAME
    > returns only places that exactly match the name
    > GeoNamesAPI::Endpoint::PlaceSearch.find_by_exact_place_name(name, maxRows)
    > GeoNamesAPI::Endpoint::PlaceSearch.find_by_exact_place_name("columbus", "10")

    CUSTOM_FIND
    > lets you format your own customized search using options seen on http://www.geonames.org/export/geonames-search.html
    > GeoNamesAPI::Endpoint::PlaceSearch.custom_find(options)
    > GeoNamesAPI::Endpoint::PlaceSearch.custom_find({name_equals: "columbus", maxRows: "10"})

  Instance Methods:

    > results:              returns list of results
    > total_results_count:  returns the total number of results
    > next_page:            returns PlaceSearch of the next page of results, returns nil if at last page already
    > previous_page:        returns PlaceSearch of the previous page of results, returns nil if at first page already
    > to_page(page_number): returns the specified page

### Country

The geonames api uses the ISO code of the country as its natural key. 

    > GeoNamesAPI::Endpoint::Country.find("US")
    
    => #<GeoNamesAPI::Endpoint::Country:0x007fd43503dfc0
          @country_code="US",
          @country_name="United States",
          @currency_code="USD",
          @fips_code="US",
          @iso_numeric=840,
          @north=49.388611,
          @capital="Washington",
          @continent_name="North America",
          @area_in_sq_km=9629091.0,
          @languages="en-US,es-US,haw,fr",
          @iso_alpha3="USA",
          @continent="NA",
          @south=24.544245,
          @east=-66.954811,
          @geoname_id=6252001,
          @west=-124.733253,
          @population=310232863
        >

    > GeoNamesAPI::Country.all
    
    => ... array of GeoNamesAPI::Country instances
    
The [postal code exports](http://download.geonames.org/export/zip/) are also available for each country either in string of ruby CSV form.

    # String
    > GeoNamesAPI::Country.find("US").postal_code_export
    # CSV::Table
    > GeoNamesAPI::Country.find("US").postal_code_csv

### Weather

The GeoNamesAPI uses the latitude and longitude of the place as the parameters for its weather service.

    > weather = GeoNamesAPI::Endpoint::Weather.find(41.88,-87.68)
    
    => #<GeoNamesAPI::Endpoint::Weather:0x007fab1c80dc10
          @latitude=41.88,
          @longitude=-87.68,
          @weather_condition="n/a",
          @clouds="few clouds",
          @observation="KMDW 012051Z 28009KT 10SM FEW049 BKN070 11/M02 A2983 RMK AO2 SLP105 T01111022 55010",
          @wind_direction=280,
          @icao="KMDW",
          @sea_level_pressure=1010.5,
          @elevation=188,
          @country_code="US",
          @clouds_code="FEW",
          @lng=-87.75,
          @temperature=11.1,
          @dew_point=-2.2,
          @wind_speed=9,
          @humidity=39,
          @station_name="Chicago, Chicago Midway Airport",
          @datetime="2012-11-01 20:51:00",
          @lat=41.78333333333333
        >
    
The following instance methods are also available:

    > weather.geo_names_api_country
    > weather.geo_names_api_time_zone
    > weather.time_zone
    > weather.at_local
    > weather.at_utc
    > weather.elevation_feet
    > weather.elevation_meters
    # fahrenheit and celcius versions of temps
    > weather.temperature_f
    > weather.temperature_c
    > weather.dew_point_f
    > weather.dew_point_c

### TimeZone

The GeoNamesAPI uses the latitude and longitude of the place as the parameters for its time zone service.

    > time_zone = GeoNamesAPI::TimeZone.find(41.88,-87.68)
    
    => #<GeoNamesAPI::Endpoint::TimeZone:0x007fd4b24d7e00
          @time="2012-11-02 12:04",
          @country_name="United States",
          @sunset="2012-11-02 17:42",
          @raw_offset=-6,
          @dst_offset=-5,
          @country_code="US",
          @gmt_offset=-6,
          @lng=-87.68,
          @sunrise="2012-11-02 07:25",
          @timezone_id="America/Chicago",
          @lat=41.88
        >

    # ActiveSupport::Endpoint::TimeZone instance
    > time_zone.time_zone
    # Local and UTC version of each time
    > time_zone.sunset_local
    > time_zone.sunset_utc
    > time_zone.sunrise_local
    > time_zone.sunrise_utc
    > time_zone.time_local
    > time_zone.time_utc

### Wikipedia

The GeoNamesAPI uses the latitude and longitude of the place as the parameters for its Wikipedia artical service.

Please note the use of the `all` method with `GeoNamesAPI::Endpoint::Wikipedia`. It returns all of the articles that match. The `find` method will return the first matching article.

    > articles = GeoNamesAPI::Endpoint::Wikipedia.all(41.88,-87.68)
    => [#<GeoNamesAPI::Wikipedia:0x007fd4b24e6040
            @summary="Richard T. Crane Technical Preparatory High School, commonly known as Crane Tech Prep or Crane Tech High School, is a public high school in Chicago, Illinois. It is located at 2245 West Jackson Boulevard in Chicago's Near West Side community area.  (...)",
            @distance=0.4108,
            @rank=82,
            @title="Crane High School (Chicago, Illinois)",
            @wikipedia_url="en.wikipedia.org/wiki/Crane_High_School_%28Chicago%2C_Illinois%29",
            @elevation=183,
            @country_code="US",
            @lng=-87.6827,
            @lang="en",
            @lat=41.8769>,
          ...] 

### Others

The other services will be implemented as needed. In the mean time, feel free to contribute! Let's keep the style consistent.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Thanks <3