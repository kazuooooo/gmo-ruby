require 'spec_helper'

describe GMO do
  Then { GMO::VERSION != nil }

  context '.configure' do
    Then {
      expect{ |b| described_class.configure(&b) }.to(
        yield_successive_args(GMO::Configuration)
      )
    }
    And  {
      described_class.configure do |config|
        expect(config).to eq(described_class.config)
      end
    }
  end
end

describe GMO::Configuration do
  Given(:config) { described_class.new }

  context '#initialize' do
    Then { config.request == config.default_request }
    Then { config.raise_on_gmo_error == config.raise_on_gmo_error }
  end

  context '#to_hash' do
    Given(:config_hash) { {
      url:     'https://example.com',
      headers: {
        :'Content-Type' => 'text/plain',
      },
      request: {
        timeout:      10,
        open_timeout:  2,
      },
      ssl:     {
        verify: false,
      },
      proxy:   {
        uri:      'http://dummyhost',
        user:     'dummyuser',
        password: 'dummypassword',
      },
    } }
    When {
      config_hash.each do |k, v|
        config.send :"#{k}=", v
      end
    }
    Then { config.to_hash == described_class.new.to_hash.merge(config_hash) }
  end
end
