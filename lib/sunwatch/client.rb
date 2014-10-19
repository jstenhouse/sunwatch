require 'httparty'
require 'json'

module Sunwatch
  class Client

    EPA_UV_URI = 'http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUV'

    def self.uv_info_for(opts)
      url = build_url(opts)
      response = HTTParty.get(url)
      raise_unavailable_error if response.code != 200
      build_response(JSON.parse(response.body))
    rescue HTTParty::Error => e
      raise_unavailable_error(e.message)
    end

    private

    def self.build_response(response)
      if response.size == 1
        build_daily_response(response.first)
      else
        build_hourly_response(response)
      end
    end

    def self.build_daily_response(response)
      Sunwatch::Response.new(city: response['CITY'],
                             state: response['STATE'],
                             zipcode: response['ZIP_CODE'],
                             uv_index: response['UV_INDEX'],
                             uv_alert: response['UV_ALERT'])
    end

    def self.build_hourly_response(response)
      hours = []
      response.each do |hour|
        hours << { datetime: hour['DATE_TIME'], uv_value: hour['UV_VALUE'] }
      end
      Sunwatch::Response.new(city: response.first['CITY'],
                             state: response.first['STATE'],
                             zipcode: response.first['ZIP'], # wat. API uses ZIP for hourly, and ZIP_CODE for daily
                             hours: hours)
    end

    def self.raise_unavailable_error(msg = '')
      raise Sunwatch::UnavailableError.new("UV Index info is unavailable: #{msg}")
    end

    def self.build_url(opts)
      uri_timewindow = build_url_timewindow(opts)
      uri_location = build_url_location(opts)
      "#{EPA_UV_URI}#{uri_timewindow}/#{uri_location}/json"
    end

    def self.build_url_timewindow(opts)
      opts[:timewindow] == :daily ? 'DAILY' : 'HOURLY'
    end

    def self.build_url_location(opts)
      if opts[:zipcode]
        "ZIP/#{opts[:zipcode]}"
      else
        "CITY/#{opts[:city]}/STATE/#{opts[:state]}"
      end
    end

  end
end
