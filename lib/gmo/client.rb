module GMO
  class Client
    # @return [Hash] 設定情報
    # @see GMO::Configuration
    attr_accessor :options

    # @param [Hash] options オプション
    #
    # @option options [String] :url エンドポイントURL
    # @option options [Hash] :headers HTTPヘッダ
    # @option options [Hash] :request リクエストオプション
    # @option options [Hash] :ssl SSLオプション
    # @option options [Hash] :proxy プロキシオプション
    # @option options [Boolean] :raise_on_gmo_error
    #   GMOのレスポンスがエラーの場合に{GMO::Errors}を発生させるかどうか
    #
    # @see GMO::Configuration
    # @see Faraday#new
    def initialize(options = nil)
      @options = GMO.config.to_hash.merge(options || {})
    end

    # 取引登録
    # POST /payment/EntryTran.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 取引登録結果
    #
    # @example
    #   # 2.1.  カード番号を入力して決済する＜本人認証サービスを未使用＞
    #   # 2.2.  カード番号を入力して決済する＜本人認証サービスを使用＞
    #   # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
    #   # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
    #   res = client.entry_tran(
    #     shop_id:        ..., # ショップID
    #     shop_pass:      ..., # ショップパスワード
    #     order_id:       ..., # オーダーID
    #     job_cd:         ..., # 処理区分
    #     item_cd:        ..., # 商品コード
    #     amount:         ..., # 利用金額
    #     tax:            ..., # 税送料
    #     td_flag:        ..., # 本人認証サービス利用フラグ
    #     td_tenant_name: ..., # 3Dセキュア表示店舗名
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   access_id:   ..., # 取引ID
    #     #   access_pass: ..., # 取引パスワード
    #     #   err_code:    ..., # エラーコード
    #     #   err_info:    ..., # エラー詳細コード
    #     # }
    def entry_tran(payload)
      conn.post('/payment/EntryTran.idPass', payload)
    end

    # 決済実行
    # POST /payment/ExecTran.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 決済実行結果
    #
    # @example
    #   # 2.1. カード番号を入力して決済する＜本人認証サービスを未使用＞
    #   res = client.exec_tran(
    #     access_id:         ..., # 取引ID
    #     access_pass:       ..., # 取引パスワード
    #     order_id:          ..., # オーダーID
    #     method:            ..., # 支払方法
    #     pay_times:         ..., # 支払回数
    #     card_no:           ..., # カード番号
    #     expire:            ..., # 有効期限(YYMM形式)
    #     security_code:     ..., # セキュリティコード
    #     pin:               ..., # 暗証番号
    #     client_field1:     ..., # 加盟店自由項目1
    #     client_field2:     ..., # 加盟店自由項目2
    #     client_field3:     ..., # 加盟店自由項目3
    #     client_field_flag: ..., # 加盟店自由項目返却フラグ
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   acs:           ..., # ACS呼出判定
    #     #   order_id:      ..., # オーダーID
    #     #   forward:       ..., # 仕向先コード
    #     #   method:        ..., # 支払方法
    #     #   pay_times:     ..., # 支払回数
    #     #   approve:       ..., # 承認番号
    #     #   tran_id:       ..., # トランザクションID
    #     #   tran_date:     ..., # 決済日付(yyyyMMddHHmmss形式)
    #     #   check_string:  ..., # MD5ハッシュ
    #     #   client_field1: ..., # 加盟店自由項目1
    #     #   client_field2: ..., # 加盟店自由項目2
    #     #   client_field3: ..., # 加盟店自由項目3
    #     #   err_code:      ..., # エラーコード
    #     #   err_info:      ..., # エラー詳細コード
    #     # }
    #
    # @example
    #   # 2.2. カード番号を入力して決済する＜本人認証サービスを使用＞
    #   res = client.exec_tran(
    #     access_id:         ..., # 取引ID
    #     access_pass:       ..., # 取引パスワード
    #     order_id:          ..., # オーダーID
    #     method:            ..., # 支払方法
    #     pay_times:         ..., # 支払回数
    #     card_no:           ..., # カード番号
    #     expire:            ..., # 有効期限(YYMM形式)
    #     security_code:     ..., # セキュリティコード
    #     http_accept:       ..., # HTTP_ACCEPT
    #     http_user_agent:   ..., # HTTP_USER_AGENT
    #     device_category:   ..., # 使用端末情報
    #     client_field1:     ..., # 加盟店自由項目1
    #     client_field2:     ..., # 加盟店自由項目2
    #     client_field3:     ..., # 加盟店自由項目3
    #     client_field_flag: ..., # 加盟店自由項目返却フラグ
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   acs:     ..., # ACS呼出判定
    #     #   acs_url: ..., # 本人認証パスワード入力画面URL
    #     #   pa_req:  ..., # 本人認証要求電文
    #     #   md:      ..., # 取引ID
    #     # }
    #
    # @example
    #   # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
    #   res = client.exec_tran(
    #     access_id:         ..., # 取引ID
    #     access_pass:       ..., # 取引パスワード
    #     order_id:          ..., # オーダーID
    #     method:            ..., # 支払方法
    #     pay_times:         ..., # 支払回数
    #     site_id:           ..., # サイトID
    #     site_pass:         ..., # サイトパスワード
    #     member_id:         ..., # 会員ID
    #     seq_mode:          ..., # カード登録連番モード
    #     card_seq:          ..., # カード登録連番
    #     card_pass:         ..., # カードパスワード
    #     security_code:     ..., # セキュリティコード
    #     client_field1:     ..., # 加盟店自由項目1
    #     client_field2:     ..., # 加盟店自由項目2
    #     client_field3:     ..., # 加盟店自由項目3
    #     client_field_flag: ..., # 加盟店自由項目返却フラグ
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   acs:           ..., # ACS呼出判定
    #     #   order_id:      ..., # オーダーID
    #     #   forward:       ..., # 仕向先コード
    #     #   method:        ..., # 支払方法
    #     #   pay_times:     ..., # 支払回数
    #     #   approve:       ..., # 承認番号
    #     #   tran_id:       ..., # トランザクションID
    #     #   tran_date:     ..., # 決済日付(yyyyMMddHHmmss形式)
    #     #   check_string:  ..., # MD5ハッシュ
    #     #   client_field1: ..., # 加盟店自由項目1
    #     #   client_field2: ..., # 加盟店自由項目2
    #     #   client_field3: ..., # 加盟店自由項目3
    #     #   err_code:      ..., # エラーコード
    #     #   err_info:      ..., # エラー詳細コード
    #     # }
    #
    # @example
    #   # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
    #   res = client.exec_tran(
    #     access_id:         ..., # 取引ID
    #     access_pass:       ..., # 取引パスワード
    #     order_id:          ..., # オーダーID
    #     method:            ..., # 支払方法
    #     pay_times:         ..., # 支払回数
    #     site_id:           ..., # サイトID
    #     site_pass:         ..., # サイトパスワード
    #     member_id:         ..., # 会員ID
    #     seq_mode:          ..., # カード登録連番モード
    #     card_seq:          ..., # カード登録連番
    #     card_pass:         ..., # カードパスワード
    #     security_code:     ..., # セキュリティコード
    #     http_accept:       ..., # HTTP_ACCEPT
    #     http_user_agent:   ..., # HTTP_USER_AGENT
    #     device_category:   ..., # 使用端末情報
    #     client_field1:     ..., # 加盟店自由項目1
    #     client_field2:     ..., # 加盟店自由項目2
    #     client_field3:     ..., # 加盟店自由項目3
    #     client_field_flag: ..., # 加盟店自由項目返却フラグ
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   acs:     ..., # ACS呼出判定
    #     #   acs_url: ..., # 本人認証パスワード入力画面URL
    #     #   pa_req:  ..., # 本人認証要求電文
    #     #   md:      ..., # 取引ID
    #     # }
    def exec_tran(payload)
      conn.post '/payment/ExecTran.idPass', payload
    end

    # 認証後決済実行
    # POST /payment/SecureTran.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 認証後決済実行結果
    #
    # @example
    #   # 2.2. カード番号を入力して決済する＜本人認証サービスを使用＞
    #   res = client.secure_tran(
    #     pa_res: ..., # 本人認証サービス結果
    #     md:     ..., # 取引ID
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   order_id:      ..., # オーダーID
    #     #   forward:       ..., # 仕向先コード
    #     #   method:        ..., # 支払方法
    #     #   pay_times:     ..., # 支払回数
    #     #   approve:       ..., # 承認番号
    #     #   tran_id:       ..., # トランザクションID
    #     #   tran_date:     ..., # 決済日付(yyyyMMddHHmmss形式)
    #     #   check_string:  ..., # MD5ハッシュ
    #     #   client_field1: ..., # 加盟店自由項目1
    #     #   client_field2: ..., # 加盟店自由項目2
    #     #   client_field3: ..., # 加盟店自由項目3
    #     #   err_code:      ..., # エラーコード
    #     #   err_info:      ..., # エラー詳細コード
    #     # }
    def secure_tran(payload)
      conn.post('/payment/SecureTran.idPass', payload)
    end

    # 決済変更
    # POST /payment/AlterTran.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 決済変更結果
    #
    # @example
    #   # 2.12. 決済の内容を取り消す
    #   res = client.alter_tran(
    #     shop_id:     ..., # ショップID
    #     shop_pass:   ..., # ショップパスワード
    #     access_id:   ..., # 取引ID
    #     access_pass: ..., # 取引パスワード
    #     job_cd:      ..., # 処理区分
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   access_id:   ..., # 取引ID
    #     #   access_pass: ..., # 取引パスワード
    #     #   forward:     ..., # 仕向先コード
    #     #   approve:     ..., # 承認番号
    #     #   tran_id:     ..., # トランザクションID
    #     #   tran_date:   ..., # 決済日付(yyyyMMddHHmmss形式)
    #     #   err_code:    ..., # エラーコード
    #     #   err_info:    ..., # エラー詳細コード
    #     # }
    #
    # @example
    #   # 2.13. 取り消した決済に再度オーソリを行う
    #   res = client.alter_tran(
    #     shop_id:     ..., # ショップID
    #     shop_pass:   ..., # ショップパスワード
    #     access_id:   ..., # 取引ID
    #     access_pass: ..., # 取引パスワード
    #     job_cd:      ..., # 処理区分
    #     amount:      ..., # 利用金額
    #     tax:         ..., # 税送料
    #     method:      ..., # 支払方法
    #     pay_times:   ..., # 支払回数
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   access_id:   ..., # 取引ID
    #     #   access_pass: ..., # 取引パスワード
    #     #   forward:     ..., # 仕向先コード
    #     #   approve:     ..., # 承認番号
    #     #   tran_id:     ..., # トランザクションID
    #     #   tran_date:   ..., # 決済日付(yyyyMMddHHmmss形式)
    #     #   err_code:    ..., # エラーコード
    #     #   err_info:    ..., # エラー詳細コード
    #     # }
    #
    # @example
    #   # 2.14. 売上の確定を行う
    #   res = client.alter_tran(
    #     shop_id:     ..., # ショップID
    #     shop_pass:   ..., # ショップパスワード
    #     access_id:   ..., # 取引ID
    #     access_pass: ..., # 取引パスワード
    #     job_cd:      ..., # 処理区分
    #     amount:      ..., # 利用金額
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   access_id:   ..., # 取引ID
    #     #   access_pass: ..., # 取引パスワード
    #     #   forward:     ..., # 仕向先コード
    #     #   approve:     ..., # 承認番号
    #     #   tran_id:     ..., # トランザクションID
    #     #   tran_date:   ..., # 決済日付(yyyyMMddHHmmss形式)
    #     #   err_code:    ..., # エラーコード
    #     #   err_info:    ..., # エラー詳細コード
    #     # }
    def alter_tran(payload)
      conn.post('/payment/AlterTran.idPass', payload)
    end

    # 金額変更
    # POST /payment/ChangeTran.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 金額変更結果
    #
    # @example
    #   # 2.15. 完了した決済に金額の変更を行う
    #   res = client.change_tran(
    #     shop_id:     ..., # ショップID
    #     shop_pass:   ..., # ショップパスワード
    #     access_id:   ..., # 取引ID
    #     access_pass: ..., # 取引パスワード
    #     job_cd:      ..., # 処理区分
    #     amount:      ..., # 利用金額
    #     tax:         ..., # 税送料
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   access_id:   ..., # 取引ID
    #     #   access_pass: ..., # 取引パスワード
    #     #   forward:     ..., # 仕向先コード
    #     #   approve:     ..., # 承認番号
    #     #   tran_id:     ..., # トランザクションID
    #     #   tran_date:   ..., # 決済日付(yyyyMMddHHmmss形式)
    #     #   err_code:    ..., # エラーコード
    #     #   err_info:    ..., # エラー詳細コード
    #     # }
    def change_tran(payload)
      conn.post('/payment/ChangeTran.idPass', payload)
    end

    # 取引状態参照
    # POST /payment/SearchTrade.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 取引状態参照結果
    #
    # @example
    #   # 2.16. 決済結果を参照する
    #   res = client.search_trade(
    #     shop_id:   ..., # ショップID
    #     shop_pass: ..., # ショップパスワード
    #     order_id:  ..., # オーダーID
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   order_id:      ..., # オーダーID
    #     #   status:        ..., # 現状態
    #     #   process_date:  ..., # 処理日付(yyyyMMddHHmmss形式)
    #     #   job_cd:        ..., # 処理区分
    #     #   access_id:     ..., # 取引ID
    #     #   access_pass:   ..., # 取引パスワード
    #     #   item_cd:       ..., # 商品コード
    #     #   amount:        ..., # 利用金額
    #     #   tax:           ..., # 税送料
    #     #   site_id:       ..., # サイトID
    #     #   member_id:     ..., # 会員ID
    #     #   card_no:       ..., # カード番号
    #     #   expire:        ..., # 有効期限(YYMM形式)
    #     #   method:        ..., # 支払方法
    #     #   pay_times:     ..., # 支払回数
    #     #   forward:       ..., # 仕向先コード
    #     #   tran_id:       ..., # トランザクションID
    #     #   approve:       ..., # 承認番号
    #     #   client_field1: ..., # 加盟店自由項目1
    #     #   client_field2: ..., # 加盟店自由項目2
    #     #   client_field3: ..., # 加盟店自由項目3
    #     #   err_code:      ..., # エラーコード
    #     #   err_info:      ..., # エラー詳細コード
    #     # }
    def search_trade(payload)
      conn.post('/payment/SearchTrade.idPass', payload)
    end

    # 決済後カード登録
    # POST /payment/TradedCard.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 決済後カード登録結果
    #
    # @example
    #   # 2.17. カード番号決済に使用したカード番号を登録する
    #   res = client.traded_card(
    #     shop_id:      ..., # ショップID
    #     shop_pass:    ..., # ショップパスワード
    #     order_id:     ..., # オーダーID
    #     site_id:      ..., # サイトID
    #     site_pass:    ..., # サイトパスワード
    #     member_id:    ..., # 会員ID
    #     seq_mode:     ..., # カード登録連番モード
    #     card_seq:     ..., # カード登録連番
    #     default_flag: ..., # 洗替・継続課金フラグ
    #     holder_name:  ..., # 名義人
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   card_seq: ..., # カード登録連番
    #     #   card_no:  ..., # カード番号
    #     #   forward:  ..., # 仕向先コード
    #     #   err_code: ..., # エラーコード
    #     #   err_info: ..., # エラー詳細コード
    #     # }
    def traded_card(payload)
      conn.post('/payment/TradedCard.idPass', payload)
    end

    # 会員登録
    # POST /payment/SaveMember.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 会員登録結果
    #
    # @example
    #   # 2.3. 会員情報を登録する
    #   res = client.save_member(
    #     site_id:     ..., # サイトID
    #     site_pass:   ..., # サイトパスワード
    #     member_id:   ..., # 会員ID
    #     member_name: ..., # 会員名
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   member_id: ..., # 会員ID
    #     #   err_code:  ..., # エラーコード
    #     #   err_info:  ..., # エラー詳細コード
    #     # }
    def save_member(payload)
      conn.post('/payment/SaveMember.idPass', payload)
    end

    # 会員更新
    # POST /payment/UpdateMember.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 会員更新結果
    #
    # @example
    #   # 2.4. 会員情報を更新する
    #   res = client.update_member(
    #     site_id:     ..., # サイトID
    #     site_pass:   ..., # サイトパスワード
    #     member_id:   ..., # 会員ID
    #     member_name: ..., # 会員名
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   member_id: ..., # 会員ID
    #     #   err_code:  ..., # エラーコード
    #     #   err_info:  ..., # エラー詳細コード
    #     # }
    def update_member(payload)
      conn.post('/payment/UpdateMember.idPass', payload)
    end

    # 会員削除
    # POST /payment/DeleteMember.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 会員削除結果
    #
    # @example
    #   # 2.5. 会員情報を削除する
    #   res = client.delete_member(
    #     site_id:     ..., # サイトID
    #     site_pass:   ..., # サイトパスワード
    #     member_id:   ..., # 会員ID
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   member_id: ..., # 会員ID
    #     #   err_code:  ..., # エラーコード
    #     #   err_info:  ..., # エラー詳細コード
    #     # }
    def delete_member(payload)
      conn.post('/payment/DeleteMember.idPass', payload)
    end

    # 会員参照
    # POST /payment/SearchMember.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] 会員参照結果
    #
    # @example
    #   # 2.6. 会員情報を参照する
    #   res = client.search_member(
    #     site_id:   ..., # サイトID
    #     site_pass: ..., # サイトパスワード
    #     member_id: ..., # 会員ID
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   member_id:   ..., # 会員ID
    #     #   member_name: ..., # 会員名
    #     #   delete_flag: ..., # 削除フラグ
    #     #   err_code:    ..., # エラーコード
    #     #   err_info:    ..., # エラー詳細コード
    #     # }
    def search_member(payload)
      conn.post('/payment/SearchMember.idPass', payload)
    end

    # カード登録／更新
    # POST /payment/SaveCard.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] カード登録／更新結果
    #
    # @example
    #   # 2.7. カード譲歩を登録または更新する
    #   res = client.save_card(
    #     site_id:      ..., # サイトID
    #     site_pass:    ..., # サイトパスワード
    #     member_id:    ..., # 会員ID
    #     seq_mode:     ..., # カード登録連番モード
    #     card_seq:     ..., # カード登録連番
    #     default_flag: ..., # 洗替・継続課金フラグ
    #     card_name:    ..., # カード会社略称
    #     card_no:      ..., # カード番号
    #     card_pass:    ..., # カードパスワード
    #     expire:       ..., # 有効期限(YYMM形式)
    #     holder_name:  ..., # 名義人
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   card_seq: ..., # カード登録連番
    #     #   card_no:  ..., # カード番号
    #     #   forward:  ..., # 仕向先コード
    #     #   err_code: ..., # エラーコード
    #     #   err_info: ..., # エラー詳細コード
    #     # }
    def save_card(payload)
      conn.post('/payment/SaveCard.idPass', payload)
    end

    # カード削除
    # POST /payment/DeleteCard.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] カード削除結果
    #
    # @example
    #   # 2.8. カード情報の削除をする
    #   res = client.delete_card(
    #     site_id:   ..., # サイトID
    #     site_pass: ..., # サイトパスワード
    #     member_id: ..., # 会員ID
    #     seq_mode:  ..., # カード登録連番モード
    #     card_seq:  ..., # カード登録連番
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   card_seq: ..., # カード登録連番
    #     #   err_code: ..., # エラーコード
    #     #   err_info: ..., # エラー詳細コード
    #     # }
    def delete_card(payload)
      # 2.8. カード情報の削除をする
      conn.post('/payment/DeleteCard.idPass', payload)
    end

    # カード参照
    # POST /payment/SearchCard.idPass
    #
    # @param [Hash] payload 送信データ
    # @return [Faraday::Response] カード参照結果
    #
    # @example
    #   # 2.9.  カード情報を参照する
    #   # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
    #   # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
    #   res = client.search_card(
    #     site_id:      ..., # サイトID
    #     site_pass:    ..., # サイトパスワード
    #     member_id:    ..., # 会員ID
    #     seq_mode:     ..., # カード登録連番モード
    #     card_seq:     ..., # カード登録連番
    #   )
    #
    #   res.body
    #     # =>
    #     # {
    #     #   card_seq:     ..., # カード登録連番
    #     #   default_flag: ..., # 洗替・継続課金フラグ
    #     #   card_name:    ..., # カード会社略称
    #     #   card_no:      ..., # カード番号
    #     #   expire:       ..., # 有効期限(YYMM形式)
    #     #   holder_name:  ..., # 名義人
    #     #   delete_flag:  ..., # 削除フラグ
    #     #   err_code:     ..., # エラーコード
    #     #   err_info:     ..., # エラー詳細コード
    #     # }
    def search_card(payload)
      conn.post('/payment/SearchCard.idPass', payload)
    end

    private

    # @return [Hash] 通信コネクション用のオプション
    def connection_options
      options.
        select{ |k, _| ![:raise_on_gmo_error].include?(k) }
    end

    # @return [Hash] {GMO::FaradayMiddleware}用のオプション
    def middleware_options
      options.
        select{ |k, _| [:raise_on_gmo_error].include?(k) }
    end

    # @return [Faraday::Connection] 通信コネクション
    def conn
      @conn ||= Faraday.new(connection_options) { |conn|
        conn.use     GMO::FaradayMiddleware, middleware_options
        conn.adapter Faraday.default_adapter
      }
    end
  end
end
