require 'spec_helper'

describe GMO::Client do
  Given(:stub_url) { 'https://mock.mul-pay.jp' }
  Given(:client_options) { {
    url: stub_url,
  } }
  Given(:client) { described_class.new(client_options) }

  context '#entry_tran' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/EntryTran.idPass").
        with(body: {}).
        to_return(status: 200)
      client.entry_tran(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#exec_tran' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/ExecTran.idPass").
        with(body: {}).
        to_return(status: 200)
      client.exec_tran(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#secure_tran' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/SecureTran.idPass").
        with(body: {}).
        to_return(status: 200)
      client.secure_tran(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#alter_tran' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/AlterTran.idPass").
        with(body: {}).
        to_return(status: 200)
      client.alter_tran(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#change_tran' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/ChangeTran.idPass").
        with(body: {}).
        to_return(status: 200)
      client.change_tran(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#search_trade' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/SearchTrade.idPass").
        with(body: {}).
        to_return(status: 200)
      client.search_trade(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#traded_card' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/TradedCard.idPass").
        with(body: {}).
        to_return(status: 200)
      client.traded_card(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#save_member' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/SaveMember.idPass").
        with(body: {}).
        to_return(status: 200)
      client.save_member(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#update_member' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/UpdateMember.idPass").
        with(body: {}).
        to_return(status: 200)
      client.update_member(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#delete_member' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/DeleteMember.idPass").
        with(body: {}).
        to_return(status: 200)
      client.delete_member(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#search_member' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/SearchMember.idPass").
        with(body: {}).
        to_return(status: 200)
      client.search_member(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#save_card' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/SaveCard.idPass").
        with(body: {}).
        to_return(status: 200)
      client.save_card(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#delete_card' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/DeleteCard.idPass").
        with(body: {}).
        to_return(status: 200)
      client.delete_card(payload)
    }
    Then { result.is_a? Faraday::Response }
  end

  context '#search_card' do
    Given(:payload) { {} }
    When (:result) {
      stub_request(:post, "#{stub_url}/payment/SearchCard.idPass").
        with(body: {}).
        to_return(status: 200)
      client.search_card(payload)
    }
    Then { result.is_a? Faraday::Response }
  end
end
