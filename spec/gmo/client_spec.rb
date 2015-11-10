require 'spec_helper'

describe GMO::Client do
  Given(:client) { described_class.new }

  context '#entry_tran' do
    Given(:payload) { {} }
    When (:result) { client.entry_tran(payload) }
    Then { result.is_a? Hash }
  end

  context '#exec_tran' do
    Given(:payload) { {} }
    When (:result) { client.exec_tran(payload) }
    Then { result.is_a? Hash }
  end

  context '#secure_tran' do
    Given(:payload) { {} }
    When (:result) { client.secure_tran(payload) }
    Then { result.is_a? Hash }
  end

  context '#alter_tran' do
    Given(:payload) { {} }
    When (:result) { client.alter_tran(payload) }
    Then { result.is_a? Hash }
  end

  context '#change_tran' do
    Given(:payload) { {} }
    When (:result) { client.change_tran(payload) }
    Then { result.is_a? Hash }
  end

  context '#search_trade' do
    Given(:payload) { {} }
    When (:result) { client.search_trade(payload) }
    Then { result.is_a? Hash }
  end

  context '#traded_card' do
    Given(:payload) { {} }
    When (:result) { client.traded_card(payload) }
    Then { result.is_a? Hash }
  end

  context '#save_member' do
    Given(:payload) { {} }
    When (:result) { client.save_member(payload) }
    Then { result.is_a? Hash }
  end

  context '#update_member' do
    Given(:payload) { {} }
    When (:result) { client.update_member(payload) }
    Then { result.is_a? Hash }
  end

  context '#delete_member' do
    Given(:payload) { {} }
    When (:result) { client.delete_member(payload) }
    Then { result.is_a? Hash }
  end

  context '#search_member' do
    Given(:payload) { {} }
    When (:result) { client.search_member(payload) }
    Then { result.is_a? Hash }
  end

  context '#save_card' do
    Given(:payload) { {} }
    When (:result) { client.save_card(payload) }
    Then { result.is_a? Hash }
  end

  context '#delete_card' do
    Given(:payload) { {} }
    When (:result) { client.delete_card(payload) }
    Then { result.is_a? Hash }
  end

  context '#search_card' do
    Given(:payload) { {} }
    When (:result) { client.search_card(payload) }
    Then { result.is_a? Hash }
  end
end
