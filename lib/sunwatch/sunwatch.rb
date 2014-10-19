module Sunwatch
  def self.daily_uv_info_for(opts = {})
    validate_opts!(opts)
    opts[:zipcode] = opts[:zipcode].to_s if opts[:zipcode] # allow integers
    opts[:timewindow] = :daily
    Sunwatch::Client.uv_info_for(opts)
  end

  def self.hourly_uv_info_for(opts = {})
    validate_opts!(opts)
    opts[:zipcode] = opts[:zipcode].to_s if opts[:zipcode] # allow integers
    opts[:timewindow] = :hourly
    Sunwatch::Client.uv_info_for(opts)
  end

  private

  def self.validate_opts!(opts)
    if opts[:zipcode]
      validate_string_or_number!(:zipcode, opts[:zipcode])
    elsif opts[:city] && opts[:state]
      validate_string!(:city, opts[:city])
      validate_string!(:state, opts[:state])
    else
      raise ConfigurationError.new('city/state or zipcode must be provided')
    end
  end

  def self.validate_string!(opt, value)
    unless value.respond_to?(:to_str)
      raise ConfigurationError.new("#{opt.to_s} must be a string")
    end
  end

  def self.validate_string_or_number!(opt, value)
    unless value.respond_to?(:to_str) || value.respond_to?(:to_int)
      raise ConfigurationError.new("#{opt.to_s} must be a string or integer")
    end
  end
end
