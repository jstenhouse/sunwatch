module Sunwatch
  class Response
    Hour = Struct.new(:datetime, :uv_value)

    attr_accessor :city, :state, :zipcode, :uv_index, :uv_alert, :hours

    def initialize(opts)
      @city     = opts[:city]
      @state    = opts[:state]
      @zipcode  = opts[:zipcode]
      @uv_index = opts[:uv_index]
      @uv_alert = opts[:uv_alert]
      if opts[:hours]
        @hours = []
        opts[:hours].each do |hour|
          @hours << Hour.new(to_datetime(hour[:datetime]), hour[:uv_value])
        end
      end
    end

    def hourly?
      @hours != nil
    end

    def daily?
      @hours == nil
    end

    def ==(other)
      self.class == other.class &&
      @city == other.city &&
      @state == other.state &&
      @zipcode == other.zipcode &&
      @uv_index == other.uv_index &&
      @uv_alert == other.uv_alert &&
      @hours == other.hours
    end

    private

    def to_datetime(str_datetime)
      # OCT/19/2014 05 AM
      DateTime.strptime(str_datetime, "%b/%d/%Y %I %p")
    end
  end
end
