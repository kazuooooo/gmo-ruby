require 'spec_helper'

describe GMO::Payload do
  context '.dump' do
    Given(:payload) {
      Hash[described_class::KEY_TO_PAYLOAD.
        map{ |k, _| [k, k] }
      ]
    }
    When (:result) { described_class.dump(payload) }
    Then {
      result == described_class::KEY_TO_PAYLOAD.map{ |k, v| "#{v}=#{k}" }.join('&')
    }
  end

  context '.load' do
    Given(:payload) {
      described_class::PAYLOAD_TO_KEY.
        map{ |k, _| "#{k}=#{k}" }.
        join('&')
    }
    When (:result) { described_class.load(payload) }
    Then {
      result.each do |k, v|
        expect(described_class::PAYLOAD_TO_KEY).to include(v => k)
      end
    }
  end
end
