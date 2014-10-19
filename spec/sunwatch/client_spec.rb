require 'spec_helper'

describe Sunwatch::Client do
  
  describe '.uv_info_for' do

    let(:daily_zipcode_json_response) { '[{"ZIP_CODE":12345,"UV_INDEX":2,"UV_ALERT":0}]' }
    let(:daily_zipcode_response) { Sunwatch::Response.new(zipcode: 12345, uv_index: 2, uv_alert: 0) }

    let(:daily_citystate_json_response) { '[{"CITY":"WASHINGTON","STATE":"DC","UV_INDEX":3,"UV_ALERT":1}]' }
    let(:daily_citystate_response) { Sunwatch::Response.new(city: 'WASHINGTON', state: 'DC', uv_index: 3, uv_alert: 1) }

    let(:hourly_zipcode_json_response) { '[{"ORDER":1,"ZIP":12345,"DATE_TIME":"OCT/18/2014 04 AM","UV_VALUE":0},{"ORDER":2,"ZIP":12345,"DATE_TIME":"OCT/18/2014 05 AM","UV_VALUE":1}]' }
    let(:hourly_zipcode_response) { Sunwatch::Response.new(zipcode: 12345, hours: [{datetime: 'OCT/18/2014 04 AM', uv_value: 0}, {datetime: 'OCT/18/2014 05 AM', uv_value: 1}]) }
    
    let(:hourly_citystate_json_response) { '[{"SEQUENCE":1,"CITY":"SEATTLE","STATE":"WA","DATE_TIME":"OCT/19/2014 04 AM","UV_VALUE":0},{"SEQUENCE":2,"CITY":"SEATTLE","STATE":"WA","DATE_TIME":"OCT/19/2014 05 AM","UV_VALUE":1}]' }
    let(:hourly_citystate_response) { Sunwatch::Response.new(city: 'SEATTLE', state: 'WA', hours: [{datetime: 'OCT/19/2014 04 AM', uv_value: 0}, {datetime: 'OCT/19/2014 05 AM', uv_value: 1}]) }

    before do
      stub_request(:get, 'http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/ZIP/12345/json').to_return(body: daily_zipcode_json_response)
      stub_request(:get, 'http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/CITY/Seattle/STATE/WA/json').to_return(body: daily_citystate_json_response)
      stub_request(:get, 'http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/ZIP/12345/json').to_return(body: hourly_zipcode_json_response)
      stub_request(:get, 'http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/CITY/Seattle/STATE/WA/json').to_return(body: hourly_citystate_json_response)
    end

    context 'a daily timewindow' do
      context 'with zipcode' do
        it 'fetches uv index info' do
          response = Sunwatch::Client.uv_info_for(timewindow: :daily, zipcode: '12345')
          expect(response).to eq(daily_zipcode_response)
        end
      end

      context 'with city/state' do
        it 'fetches uv index info' do
          response = Sunwatch::Client.uv_info_for(timewindow: :daily, city: 'Seattle', state: 'WA')
          expect(response).to eq(daily_citystate_response)
        end
      end
    end

    context 'an hourly timewindow' do
      context 'with zipcode' do
        it 'fetches uv index info' do
          response = Sunwatch::Client.uv_info_for(timewindow: :hourly, zipcode: '12345')
          expect(response).to eq(hourly_zipcode_response)
        end
      end

      context 'with city/state' do
        it 'fetches uv index info' do
          response = Sunwatch::Client.uv_info_for(timewindow: :hourly, city: 'Seattle', state: 'WA')
          expect(response).to eq(hourly_citystate_response)
        end
      end
    end

    context 'service unavailable' do

      before do
        stub_request(:get, 'http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/ZIP/12345/json').to_return( 
                     :status => ["503", "Temporarily Unavailable"])
      end

      it 'raises a service unavailable error' do
        expect { Sunwatch::Client.uv_info_for(timewindow: :hourly, zipcode: '12345') }.to raise_error Sunwatch::UnavailableError
      end
    end

  end

  describe '.build_url' do
    context 'a daily timewindow' do
      context 'with zipcode' do
        it 'builds a daily timewindow with zipcode url' do
          url = Sunwatch::Client.build_url(timewindow: :daily, zipcode: '12345')
          expect(url).to eq('http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/ZIP/12345/json')
        end
      end

      context 'with city/state' do
        it 'builds a daily timewindow with city/state url' do
          url = Sunwatch::Client.build_url(timewindow: :daily, city: 'Seattle', state: 'WA')
          expect(url).to eq('http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/CITY/Seattle/STATE/WA/json')
        end
      end
    end

    context 'an hourly timewindow' do
      context 'with zipcode' do
        it 'builds an hourly timewindow with zipcode url' do
          url = Sunwatch::Client.build_url(timewindow: :hourly, zipcode: '12345')
          expect(url).to eq('http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/ZIP/12345/json')
        end
      end

      context 'with city/state' do
        it 'builds an hourly timewindow with city/state url' do
          url = Sunwatch::Client.build_url(timewindow: :hourly, city: 'Seattle', state: 'WA')
          expect(url).to eq('http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/CITY/Seattle/STATE/WA/json')
        end
      end
    end
  end

end
