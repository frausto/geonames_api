module GeoNamesAPI
  module Endpoint
    class Country < GeoNamesAPI::EndpointObject

      METHOD = "countryInfoJSON"
      ID = "country"

      EXPORT_BASE_URL = "http://download.geonames.org/export/zip/"
      EXPORT_HEADERS = %W(country_code postal_code place_name admin_name1 admin_code1 admin_name2 admin_code2 admin_name3 admin_code3 latitude longitude accuracy)

      def postal_code_export
        zip_data = open(postal_code_export_url) { |f| f.binmode; f.read }
        stream = lambda { return zip_data.slice!(0, 256) }
        csv = EXPORT_HEADERS.join("\t") + "\n"
        Zip::Archive.open_buffer(stream) do |archive|
          archive.each do |f|
            csv << f.read if f.name =~ /\A#{country_code}/
          end
        end
        csv
      end
      
      def postal_code_csv
        CSV.parse(postal_code_export, headers: true, col_sep: "\t", header_converters: :symbol, encoding: "ISO8859-1")
      end
      
      def postal_code_export_url
        EXPORT_BASE_URL + country_code + ".zip"
      end
      
    end
  end
end