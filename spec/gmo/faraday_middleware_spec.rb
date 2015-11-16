require 'spec_helper'

describe GMO::FaradayMiddleware do
  context '#call' do
    Given(:dummy_url) { 'http://example.com' }
    Given(:req_payload) {
      GMO::Payload::KEY_TO_PAYLOAD
    }
    Given(:conn) {
      Faraday.new() { |conn|
        conn.use     described_class, options
        conn.adapter Faraday.default_adapter
      }
    }

    context 'GMO returns success response' do
      Given(:options) { {} }
      Given(:res_payload) {
        GMO::Payload::PAYLOAD_TO_KEY.
          invert.
          delete_if{ |k, _| [:err_code, :err_info].include?(k) }
      }
      When (:response) {
        stub_request(:post, dummy_url).
          with(body: GMO::Payload.dump(req_payload)).
          to_return(
            status: 200,
            body:   res_payload.map{ |_, v| "#{v}=#{v}" }.join('&')
          )
        conn.post(dummy_url, req_payload)
      }
      Then { response.body == res_payload }
    end

    context 'GMO returns error response' do
      Given(:res_payload) {
        GMO::Payload::PAYLOAD_TO_KEY.
          invert.
          select{ |k, _| [:err_code, :err_info].include?(k) }
      }

      context ':raise_on_gmo_error option is true' do
        Given(:options) { {raise_on_gmo_error: true} }
        When {
          stub_request(:post, dummy_url).
            with(body: GMO::Payload.dump(req_payload)).
            to_return(
              status: 200,
              body:   res_payload.map{ |_, v| "#{v}=#{v}" }.join('&')
            )
        }
        Then { expect{ conn.post(dummy_url, req_payload) }.to raise_error(GMO::Errors) }
      end

      context ':raise_on_gmo_error option is false' do
        Given(:options) { {raise_on_gmo_error: false} }
        When (:response) {
          stub_request(:post, dummy_url).
            with(body: GMO::Payload.dump(req_payload)).
            to_return(
              status: 200,
              body:   res_payload.map{ |_, v| "#{v}=#{v}" }.join('&')
            )
          conn.post(dummy_url, req_payload)
        }
        Then { response.body == res_payload }
      end
    end
  end
end
