require 'open-uri'
require 'json'
require 'csv'
require 'active_support/all'
require 'zipruby'
require "geonames_api/version"
require "geonames_api/error"
require "geonames_api/object"
require "geonames_api/country"
require "geonames_api/weather"
require "geonames_api/time_zone"
require "geonames_api/wikipedia"
require "geonames_api/postal_code"
require "geonames_api/nearby_postal_code"

module GeoNamesAPI
  
  mattr_accessor :url
  @@url = "http://api.geonames.org/"

  mattr_accessor :formatted
  @@formatted = true
  
  mattr_accessor :lang
  @@lang = :en
  
  mattr_accessor :username
  @@username = "demo"
  
  mattr_accessor :style
  @@style = :full
  
  def self.params
    { formatted: formatted, lang: lang, username: username, style: style }
  end
    
end
