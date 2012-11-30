module GeoNamesAPI
  module Endpoint
    class PlaceSearch < GeoNamesAPI::EndpointObject
      METHOD = "searchJSON"
      ID = ["q", "maxRows"]
      NESTED = false
      DEFAULT_MAX_ROWS = 100

      class << self
        def find(*names)
          params = name_params(names)
          custom_find(params)
        end
        alias_method :all, :find

        def find_by_place_name(name, max_rows=DEFAULT_MAX_ROWS)
          params = {name: name, maxRows: max_rows}
          custom_find(params)
        end

        def find_by_exact_place_name(name, max_rows=DEFAULT_MAX_ROWS)
          params = {name_equals: name, maxRows: max_rows}
          custom_find(params)
        end

        def custom_find(params={})
          if response = where(setup_params(params)).first
            response['find_params'] = params
            initial_response_parse(response)
          end
        end
      end

      def next_page
        return nil if geonames.size < find_params['maxRows'].to_i
        find_params['startRow'] = find_params['startRow'].to_i
        find_params['startRow'] += find_params['maxRows'].to_i
        self.class.custom_find(find_params)
      end

      def previous_page
        return nil if find_params['startRow'] == 0
        find_params['startRow'] = find_params['startRow'].to_i
        find_params['startRow'] -= find_params['maxRows'].to_i
        self.class.custom_find(find_params)
      end

      def to_page(page_number)
        find_params['startRow'] = find_params['maxRows'].to_i * (page_number.to_i - 1)
        self.class.custom_find(find_params)
      end

      def results 
        geonames
      end

      private

      def self.setup_params(params)
        params['maxRows'] ||= DEFAULT_MAX_ROWS
        params['startRow'] ||= 0
        params
      end

      def self.initial_response_parse(response)
        result = new(response)
        result.geonames = result.geonames.collect { |response| Place.new(response) if response }.compact
        result
      end
    end
  end
end