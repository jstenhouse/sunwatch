require 'spec_helper'

describe Sunwatch do

  describe '.daily_uv_info_for' do

    context 'invalid options' do
      context 'with only city' do
        it 'raises a configuration error' do
          expect { Sunwatch.daily_uv_info_for(city: 'Seattle') }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with only state' do
        it 'raises a configuration error' do
          expect { Sunwatch.daily_uv_info_for(state: 'WA') }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with non-string/non-number zipcode' do
        it 'raises a configuration error' do
          expect { Sunwatch.daily_uv_info_for(zipcode: Object.new) }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with non-string city' do
        it 'raises a configuration error' do
          expect { Sunwatch.daily_uv_info_for(city: 1) }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with non-string state' do
        it 'raises a configuration error' do
          expect { Sunwatch.daily_uv_info_for(state: 1) }.to raise_error Sunwatch::ConfigurationError
        end
      end
    end

    context 'valid options' do
      context 'with city and state' do
        let(:valid_options) { { city: 'Seattle', state: 'WA' } }

        it 'will send appropriate options to client' do
          expect(Sunwatch::Client).to receive(:uv_info_for) { valid_options.merge(timewindow: :daily) }
          Sunwatch.daily_uv_info_for(valid_options)
        end
      end

      context 'with zipcode' do
        let(:valid_options) { { zipcode: '12345' } }

        it 'will send appropriate options to client' do
          expect(Sunwatch::Client).to receive(:uv_info_for) { valid_options.merge(timewindow: :daily) }
          Sunwatch.daily_uv_info_for(valid_options)
        end
      end
    end
  end

  describe '.hourly_uv_info_for' do

    context 'invalid options' do
      context 'with only city' do
        it 'raises a configuration error' do
          expect { Sunwatch.hourly_uv_info_for(city: 'Seattle') }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with only state' do
        it 'raises a configuration error' do
          expect { Sunwatch.hourly_uv_info_for(state: 'WA') }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with non-string/non-number zipcode' do
        it 'raises a configuration error' do
          expect { Sunwatch.hourly_uv_info_for(zipcode: Object.new) }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with non-string city' do
        it 'raises a configuration error' do
          expect { Sunwatch.hourly_uv_info_for(city: 1) }.to raise_error Sunwatch::ConfigurationError
        end
      end

      context 'with non-string state' do
        it 'raises a configuration error' do
          expect { Sunwatch.hourly_uv_info_for(state: 1) }.to raise_error Sunwatch::ConfigurationError
        end
      end
    end

    context 'valid options' do
      context 'with city and state' do
        let(:valid_options) { { city: 'Seattle', state: 'WA' } }

        it 'will send appropriate options to client' do
          expect(Sunwatch::Client).to receive(:uv_info_for) { valid_options.merge(timewindow: :hourly) }
          Sunwatch.hourly_uv_info_for(valid_options)
        end
      end

      context 'with zipcode' do
        let(:valid_options) { { zipcode: '12345' } }

        it 'will send appropriate options to client' do
          expect(Sunwatch::Client).to receive(:uv_info_for) { valid_options.merge(timewindow: :hourly) }
          Sunwatch.hourly_uv_info_for(valid_options)
        end
      end
    end
  end

end
