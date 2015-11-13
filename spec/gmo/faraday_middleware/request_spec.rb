require 'spec_helper'

describe GMO::FaradayMiddleware::Request do
  Given(:middleware) { described_class.new(proc{ |env| env }) }

  context '#call' do
    Given(:payload) { Hash[GMO::Payload::KEY_TO_PAYLOAD.map{ |k, _| [k, k] }] }
    When (:result) {
      env = {body: payload}
      middleware.call(Faraday::Env.from(env))
    }
    Then { result[:body] == GMO::Payload.dump(payload) }
  end
end
