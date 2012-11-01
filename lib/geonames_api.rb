require 'open-uri'
require 'json'
require 'active_support/all'
require "geonames_api/version"
require "geonames_api/country"
require "geonames_api/weather"

module GeoNamesAPI
  BASE_URL = "http://api.geonames.org/"
  
  def self.to_url_params(params)
    "?" + params.collect { |key, value| "#{key}=#{value}" }.join("&")
  end
  
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
  
  def self.set_default_type(value)
    case value
    when /\A\d+\Z/
      value.to_i
    when /\A\d*\.\d*\Z/
      value.to_f
    else
      value
    end
  end
  
end
