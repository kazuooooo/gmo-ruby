require 'spec_helper'

describe GMO::FaradayMiddleware::RaiseGMOError do
  context '#on_complete' do
    Given(:payload) { 'ErrCode=G02|G12|G44&ErrInfo=42G020000|42G120000|42G440000' }
    Given(:conn) {
      Faraday.new() { |conn|
        conn.response :raise_gmo_error
        conn.response :gmo
        conn.adapter  :test do |stub|
          stub.get('/') { [200, {}, payload] }
        end
      }
    }
    Then { expect{ conn.get('/') }.to raise_error(GMO::Errors) }
  end
end
