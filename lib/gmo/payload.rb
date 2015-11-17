module GMO
  class Payload < Hash
    include Hashie::Extensions::MethodAccessWithOverride

    # Rubyハッシュキー→送信データ変換テーブル
    KEY_TO_PAYLOAD = {
      amount:            'Amount',          # 利用金額
      card_seq:          'CardSeq',         # カード登録連番
      pay_times:         'PayTimes',        # 支払回数
      tax:               'Tax',             # 税送料
      access_id:         'AccessID',        # 取引ID
      access_pass:       'AccessPass',      # 取引パスワード
      card_name:         'CardName',        # カード会社略称
      card_no:           'CardNo',          # カード番号
      card_pass:         'CardPass',        # カードパスワード
      client_field1:     'ClientField1',    # 加盟店自由項目1
      client_field2:     'ClientField2',    # 加盟店自由項目2
      client_field3:     'ClientField3',    # 加盟店自由項目3
      client_field_flag: 'ClientFieldFlag', # 加盟店自由項目返却フラグ
      default_flag:      'DefaultFlag',     # 洗替・継続課金フラグ
      device_category:   'DeviceCategory',  # 使用端末情報
      expire:            'Expire',          # 有効期限(YYMM形式)
      holder_name:       'HolderName',      # 名義人
      http_accept:       'HttpAccept',      # HTTP_ACCEPT
      http_user_agent:   'HttpUserAgent',   # HTTP_USER_AGENT
      item_cd:           'ItemCd',          # 商品コード
      job_cd:            'JobCd',           # 処理区分
      md:                'MD',              # 取引ID
      member_id:         'MemberID',        # 会員ID
      member_name:       'MemberName',      # 会員名
      method:            'Method',          # 支払方法
      order_id:          'OrderID',         # オーダーID
      pa_res:            'PaRes',           # 本人認証サービス結果
      pin:               'PIN',             # 暗証番号
      security_code:     'SecurityCode',    # セキュリティコード
      seq_mode:          'SeqMode',         # カード登録連番モード
      shop_id:           'ShopID',          # ショップID
      shop_pass:         'ShopPass',        # ショップパスワード
      site_id:           'SiteID',          # サイトID
      site_pass:         'SitePass',        # サイトパスワード
      td_flag:           'TdFlag',          # 本人認証サービス利用フラグ
      td_tenant_name:    'TdTenantName',    # 本人認証サービス利用フラグ
    }

    # 受信データ→Rubyハッシュキー変換テーブル
    PAYLOAD_TO_KEY = {
      'AccessID'     => :access_id,     # 取引ID
      'AccessPass'   => :access_pass,   # 取引パスワード
      'ACS'          => :acs,           # ACS呼出判定
      'ACSUrl'       => :acs_url,       # 本人認証パスワード入力画面URL
      'Amount'       => :amount,        # 利用金額
      'Approve'      => :approve,       # 承認番号
      'CardName'     => :card_name,     # カード会社略称
      'CardNo'       => :card_no,       # カード番号
      'CardSeq'      => :card_seq,      # カード登録連番
      'CheckString'  => :check_string,  # MD5ハッシュ
      'ClientField1' => :client_field1, # 加盟店自由項目1
      'ClientField2' => :client_field2, # 加盟店自由項目2
      'ClientField3' => :client_field3, # 加盟店自由項目3
      'DefaultFlag'  => :default_flag,  # 洗替・継続課金フラグ
      'DeleteFlag'   => :delete_flag,   # 削除フラグ
      'ErrCode'      => :err_code,      # エラーコード
      'ErrInfo'      => :err_info,      # エラー詳細コード
      'Expire'       => :expire,        # 有効期限(YYMM形式)
      'Forward'      => :forward,       # 仕向先コード
      'HolderName'   => :holder_name,   # 名義人
      'ItemCd'       => :item_cd,       # 商品コード
      'JobCd'        => :job_cd,        # 処理区分
      'MD'           => :md,            # 取引ID
      'MemberID'     => :member_id,     # 会員ID
      'MemberName'   => :member_name,   # 会員名
      'Method'       => :method,        # 支払方法
      'OrderID'      => :order_id,      # オーダーID
      'PaReq'        => :pa_req,        # 本人認証要求電文
      'PayTimes'     => :pay_times,     # 支払回数
      'ProcessDate'  => :process_date,  # 処理日付(yyyyMMddHHmmss形式)
      'SiteID'       => :site_id,       # サイトID
      'Status'       => :status,        # 現状態
      'Tax'          => :tax,           # 税送料
      'TranDate'     => :tran_date,     # 決済日付(yyyyMMddHHmmss形式)
      'TranID'       => :tran_id,       # トランザクションID
    }

    # ハッシュをGMOのリクエストBODY形式に変換
    #
    # @param [Hash|GMO::Payload] payload 送信データBODY
    #
    # @return [String] 送信データBODY
    def self.dump(payload)
      URI.encode_www_form(Hash[payload.
        map{ |k, v| [KEY_TO_PAYLOAD[k] || k, v] }
      ])
    end

    # レスポンスのBODYデータを読み込み、オブジェクトにして返却
    #
    # @param [String] payload 受信データBODY
    #
    # @return [GMO::Payload] 受信データBODY
    def self.load(payload)
      self[URI.decode_www_form(payload).
        map{ |k, v| [PAYLOAD_TO_KEY[k], v] if PAYLOAD_TO_KEY.key?(k) }
      ]
    end

    # エラーがあるか判定
    #
    # @return [Boolean] エラーがあるかどうか
    def error?
      !!(err_code? || err_info?)
    end

    # エラーがある場合、{GMO::Errors}を返す
    #
    # @return [GMO::Errors] エラー情報
    # @return [nil] エラーがない場合
    def errors
      GMO::Errors.new(self[:err_code], self[:err_info]) if error?
    end
  end
end
