require 'spec_helper'

describe GMO::Client do
  # @example
  #   build_payload(:shop_id, :shop_pass)
  #     # => {shop_id: 'shop_id', shop_pass: 'shop_pass'}
  def build_payload(*keys)
    Hash[keys.map{ |k| [k, k.to_s] }]
  end

  # @example
  #   build_response_body({access_id: 'access_id', access_pass: 'access_pass'})
  #     # => 'AccessID=access_id&AccessPass=access_pass'
  def build_response_body(res_hash)
    res_hash.map{ |k1, v1|
      "#{GMO::Payload::PAYLOAD_TO_KEY.find{ |k2, v2| k1 == v2 }[0]}=#{v1}"
    }.join('&')
  end

  Given(:stub_url) { 'https://mock.mul-pay.jp' }
  Given(:client_options) { {
    url: stub_url,
    raise_on_gmo_error: false,
  } }
  Given(:client) { described_class.new(client_options) }

  context '#initialize' do
    context 'no options parameter given' do
      When (:client) { described_class.new }
      Then { client.options == GMO.config.to_hash }
    end

    context 'options parameter given' do
      Given(:options) { {
        url:    stub_url,
        ssl:    false,
        proxy: 'http://localhost',
      } }
      When (:client) { described_class.new(options) }
      Then { client.options == GMO.config.to_hash.merge(options) }
    end
  end

  context '#entry_tran' do
    [
      [
        '2.1.  カード番号を入力して決済する＜本人認証サービスを未使用＞',
        [
          :shop_id,
          :shop_pass,
          :order_id,
          :job_cd,
          :item_cd,
          :amount,
          :tax,
          :td_flag,
          :td_tenant_name,
        ],
        [
          :access_id,
          :access_pass,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.2.  カード番号を入力して決済する＜本人認証サービスを使用＞',
        [
          :shop_id,
          :shop_pass,
          :order_id,
          :job_cd,
          :item_cd,
          :amount,
          :tax,
          :td_flag,
          :td_tenant_name,
        ],
        [
          :access_id,
          :access_pass,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞',
        [
          :shop_id,
          :shop_pass,
          :order_id,
          :job_cd,
          :item_cd,
          :amount,
          :tax,
          :td_flag,
          :td_tenant_name,
        ],
        [
          :access_id,
          :access_pass,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞',
        [
          :shop_id,
          :shop_pass,
          :order_id,
          :job_cd,
          :item_cd,
          :amount,
          :tax,
          :td_flag,
          :td_tenant_name,
        ],
        [
          :access_id,
          :access_pass,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/EntryTran.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.entry_tran(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#exec_tran' do
    [
      [
        '2.1. カード番号を入力して決済する＜本人認証サービスを未使用＞',
        [
          :access_id,
          :access_pass,
          :order_id,
          :method,
          :pay_times,
          :card_no,
          :expire,
          :security_code,
          :pin,
          :client_field1,
          :client_field2,
          :client_field3,
          :client_field_flag,
        ],
        [
          :acs,
          :order_id,
          :forward,
          :method,
          :pay_times,
          :approve,
          :tran_id,
          :tran_date,
          :check_string,
          :client_field1,
          :client_field2,
          :client_field3,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.2. カード番号を入力して決済する＜本人認証サービスを使用＞',
        [
          :access_id,
          :access_pass,
          :order_id,
          :method,
          :pay_times,
          :card_no,
          :expire,
          :security_code,
          :http_accept,
          :http_user_agent,
          :device_category,
          :client_field1,
          :client_field2,
          :client_field3,
          :client_field_flag,
        ],
        [
          :acs,
          :acs_url,
          :pa_req,
          :md,
        ],
      ],
      [
        '2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞',
        [
          :access_id,
          :access_pass,
          :order_id,
          :method,
          :pay_times,
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
          :card_pass,
          :security_code,
          :client_field1,
          :client_field2,
          :client_field3,
          :client_field_flag,
        ],
        [
          :acs,
          :order_id,
          :forward,
          :method,
          :pay_times,
          :approve,
          :tran_id,
          :tran_date,
          :check_string,
          :client_field1,
          :client_field2,
          :client_field3,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞',
        [
          :access_id,
          :access_pass,
          :order_id,
          :method,
          :pay_times,
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
          :card_pass,
          :security_code,
          :http_accept,
          :http_user_agent,
          :device_category,
          :client_field1,
          :client_field2,
          :client_field3,
          :client_field_flag,
        ],
        [
          :acs,
          :acs_url,
          :pa_req,
          :md,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/ExecTran.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.exec_tran(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#secure_tran' do
    [
      [
        '2.2. カード番号を入力して決済する＜本人認証サービスを使用＞',
        [
          :pa_res,
          :md,
        ],
        [
          :order_id,
          :forward,
          :method,
          :pay_times,
          :approve,
          :tran_id,
          :tran_date,
          :check_string,
          :client_field1,
          :client_field2,
          :client_field3,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/SecureTran.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.secure_tran(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#alter_tran' do
    [
      [
        '2.12. 決済の内容を取り消す',
        [
          :shop_id,
          :shop_pass,
          :access_id,
          :access_pass,
          :job_cd,
        ],
        [
          :access_id,
          :access_pass,
          :forward,
          :approve,
          :tran_id,
          :tran_date,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.13. 取り消した決済に再度オーソリを行う',
        [
          :shop_id,
          :shop_pass,
          :access_id,
          :access_pass,
          :job_cd,
          :amount,
          :tax,
          :method,
          :pay_times,
        ],
        [
          :access_id,
          :access_pass,
          :forward,
          :approve,
          :tran_id,
          :tran_date,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.14. 売上の確定を行う',
        [
          :shop_id,
          :shop_pass,
          :access_id,
          :access_pass,
          :job_cd,
          :amount,
        ],
        [
          :access_id,
          :access_pass,
          :forward,
          :approve,
          :tran_id,
          :tran_date,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/AlterTran.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.alter_tran(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#change_tran' do
    [
      [
        '2.15. 完了した決済に金額の変更を行う',
        [
          :shop_id,
          :shop_pass,
          :access_id,
          :access_pass,
          :job_cd,
          :amount,
          :tax,
        ],
        [
          :access_id,
          :access_pass,
          :forward,
          :approve,
          :tran_id,
          :tran_date,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/ChangeTran.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.change_tran(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#search_trade' do
    [
      [
        '2.16. 決済結果を参照する',
        [
          :shop_id,
          :shop_pass,
          :order_id,
        ],
        [
          :order_id,
          :status,
          :process_date,
          :job_cd,
          :access_id,
          :access_pass,
          :item_cd,
          :amount,
          :tax,
          :site_id,
          :member_id,
          :card_no,
          :expire,
          :method,
          :pay_times,
          :forward,
          :tran_id,
          :approve,
          :client_field1,
          :client_field2,
          :client_field3,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/SearchTrade.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.search_trade(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#traded_card' do
    [
      [
        '2.17. カード番号決済に使用したカード番号を登録する',
        [
          :shop_id,
          :shop_pass,
          :order_id,
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
          :default_flag,
          :holder_name,
        ],
        [
          :card_seq,
          :card_no,
          :forward,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/TradedCard.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.traded_card(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#save_member' do
    [
      [
        '2.3. 会員情報を登録する',
        [
          :site_id,
          :site_pass,
          :member_id,
          :member_name,
        ],
        [
          :member_id,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/SaveMember.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.save_member(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#update_member' do
    [
      [
        '2.4. 会員情報を更新する',
        [
          :site_id,
          :site_pass,
          :member_id,
          :member_name,
        ],
        [
          :member_id,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/UpdateMember.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.update_member(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#delete_member' do
    [
      [
        '2.5. 会員情報を削除する',
        [
          :site_id,
          :site_pass,
          :member_id,
        ],
        [
          :member_id,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/DeleteMember.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.delete_member(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#search_member' do
    [
      [
        '2.6. 会員情報を参照する',
        [
          :site_id,
          :site_pass,
          :member_id,
        ],
        [
          :member_id,
          :member_name,
          :delete_flag,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/SearchMember.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.search_member(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#save_card' do
    [
      [
        '2.7. カード情報を登録または更新する',
        [
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
          :default_flag,
          :card_name,
          :card_no,
          :card_pass,
          :expire,
          :holder_name,
        ],
        [
          :card_seq,
          :card_no,
          :forward,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/SaveCard.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.save_card(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#delete_card' do
    [
      [
        '2.8. カード情報の削除をする',
        [
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
        ],
        [
          :card_seq,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/DeleteCard.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.delete_card(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end

  context '#search_card' do
    [
      [
        '2.9.  カード情報を参照する',
        [
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
        ],
        [
          :card_seq,
          :default_flag,
          :card_name,
          :card_no,
          :expire,
          :holder_name,
          :delete_flag,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞',
        [
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
        ],
        [
          :card_seq,
          :default_flag,
          :card_name,
          :card_no,
          :expire,
          :holder_name,
          :delete_flag,
          :err_code,
          :err_info,
        ],
      ],
      [
        '2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞',
        [
          :site_id,
          :site_pass,
          :member_id,
          :seq_mode,
          :card_seq,
        ],
        [
          :card_seq,
          :default_flag,
          :card_name,
          :card_no,
          :expire,
          :holder_name,
          :delete_flag,
          :err_code,
          :err_info,
        ],
      ],
    ].each do |(description, req, res)|
      context description do
        Given(:req_payload) { build_payload(*req) }
        Given(:res_payload) { build_payload(*res) }
        When (:response) {
          stub_request(:post, "#{stub_url}/payment/SearchCard.idPass").
            with(body: GMO::Payload.dump(req_payload)).
            to_return(status: 200, body: build_response_body(res_payload))
          client.search_card(req_payload)
        }
        Then { response.is_a? Faraday::Response }
        And  { response.body == res_payload }
      end
    end
  end
end
