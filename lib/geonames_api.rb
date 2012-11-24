require 'open-uri'
require 'json'
require 'csv'
require 'active_support/all'
require 'zipruby'

require "geonames_api/version"
require "geonames_api/error"
require "geonames_api/object"

Dir[File.dirname(__FILE__) + '/geonames_api/*.rb'].each {|file| require file }

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

  mattr_accessor :logger
  @@logger = nil
  
  def self.params
    { formatted: formatted, lang: lang, username: username, style: style }
  end
    
end
