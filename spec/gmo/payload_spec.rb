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

  context '#error?' do
    context 'no :err_code and :err_info options given' do
      Given(:payload) { described_class[] }
      Then { payload.error? == false }
    end

    context ':err_code options given' do
      Given(:payload) { described_class[:err_code, 'E01'] }
      Then { payload.error? == true }
    end

    context ':err_info options given' do
      Given(:payload) { described_class[:err_info, 'E01160010'] }
      Then { payload.error? == true }
    end

    context ':err_code and :err_info options given' do
      Given(:payload) { described_class[:err_code, 'E01', :err_info, 'E01160010'] }
      Then { payload.error? == true }
    end
  end

  context '#errors' do
    context 'with error' do
      Given(:payload) { described_class[:err_code, 'E01', :err_info, 'E01160010'] }
      When (:errors) { payload.errors }
      Then { errors.is_a? GMO::Errors }
    end

    context 'without error' do
      Given(:payload) { described_class[] }
      When (:errors) { payload.errors }
      Then { errors == nil }
    end
  end
end
