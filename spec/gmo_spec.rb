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

  context 'default value' do
    Then { config.request == config.default_request }
  end
end
