require 'spec_helper'

describe GMO::Errors do
  Given(:err_code) { %w{G02 G12 G44} }
  Given(:err_info) { %w{42G020000 42G120000 42G440000} }
  Given(:errors) {
    described_class.new(
      err_code.join(described_class::SEPARATOR),
      err_info.join(described_class::SEPARATOR)
    )
  }

  context '#initialize' do
    Then { errors.message != nil }
  end

  context '#each' do
    context 'block given' do
      Then {
        args = err_code.zip(err_info).map{ |code, info| [code, info, String] }
        expect{ |b| errors.each(&b) }.to yield_successive_args(*args)
      }
    end

    context 'no block given' do
      Given(:ret) { errors.each }
      Then { ret.is_a? Enumerator }
    end
  end

  context '#full_messages' do
    When (:messages) { errors.full_messages }
    Then { messages == errors.map{ |_, _, message| message } }
  end
end
