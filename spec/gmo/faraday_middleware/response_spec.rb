require 'spec_helper'

describe GMO::FaradayMiddleware::Response do
  context '#on_complete' do
    Given(:payload) {
      GMO::Payload::PAYLOAD_TO_KEY.map{ |k, _| "#{k}=#{k}" }.join('&')
    }
    Given(:conn) {
      Faraday.new() { |conn|
        conn.response :gmo
        conn.adapter :test do |stub|
          stub.get('/') { [200, {}, payload] }
        end
      }
    }
    When (:response) { conn.get '/' }
    Then { response.body == GMO::Payload.load(payload) }
  end
end
