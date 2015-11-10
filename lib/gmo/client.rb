module GMO
  class Client
    # @param [Hash] options オプション
    #
    # @option options [String] :url エンドポイントURL
    # @option options [Hash] :headers HTTPヘッダ
    # @option options [Hash] :ssl SSLオプション
    # @option options [Hash] :proxy プロキシオプション
    #
    # @see Faraday#new
    def initialize(options)
      @options = options
    end

    # 取引登録
    # POST /payment/EntryTran.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.1.  カード番号を入力して決済する＜本人認証サービスを未使用＞
    # 2.2.  カード番号を入力して決済する＜本人認証サービスを使用＞
    # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
    # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
    #   @option payload [String] :ShopID ショップID
    #   @option payload [String] :ShopPass ショップパスワード
    #   @option payload [String] :OrderID オーダーID
    #   @option payload [String] :JobCd 処理区分
    #   @option payload [String] :ItemCd 商品コード
    #   @option payload [Number] :Amount 利用金額
    #   @option payload [Number] :Tax 税送料
    #   @option payload [String] :TdFlag 本人認証サービス利用フラグ
    #   @option payload [String] :TdTenantName 本人認証サービス利用フラグ
    #
    # @return [Faraday::Response] 取引登録結果
    def entry_tran(payload)
      # 2.1.  カード番号を入力して決済する＜本人認証サービスを未使用＞
      # 2.2.  カード番号を入力して決済する＜本人認証サービスを使用＞
      # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
      # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
      #   [String] :AccessID 取引ID
      #   [String] :AccessPass 取引パスワード
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/EntryTran.idPass', payload
    end

    # 決済実行
    # POST /payment/ExecTran.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.1. カード番号を入力して決済する＜本人認証サービスを未使用＞
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :OrderID オーダーID
    #   @option payload [String] :Method 支払方法
    #   @option payload [Number] :PayTimes 支払回数
    #   @option payload [String] :CardNo カード番号
    #   @option payload [String] :Expire 有効期限(YYMM形式)
    #   @option payload [String] :SecurityCode セキュリティコード
    #   @option payload [String] :PIN 暗証番号
    #   @option payload [String] :ClientField1 加盟店自由項目1
    #   @option payload [String] :ClientField2 加盟店自由項目2
    #   @option payload [String] :ClientField3 加盟店自由項目3
    #   @option payload [String] :ClientFieldFlag 加盟店自由項目返却フラグ
    #
    # 2.2. カード番号を入力して決済する＜本人認証サービスを使用＞
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :OrderID オーダーID
    #   @option payload [String] :Method 支払方法
    #   @option payload [Number] :PayTimes 支払回数
    #   @option payload [String] :CardNo カード番号
    #   @option payload [String] :Expire 有効期限(YYMM形式)
    #   @option payload [String] :SecurityCode セキュリティコード
    #   @option payload [String] :HttpAccept HTTP_ACCEPT
    #   @option payload [String] :HttpUserAgent HTTP_USER_AGENT
    #   @option payload [String] :DeviceCategory 使用端末情報
    #   @option payload [String] :ClientField1 加盟店自由項目1
    #   @option payload [String] :ClientField2 加盟店自由項目2
    #   @option payload [String] :ClientField3 加盟店自由項目3
    #   @option payload [String] :ClientFieldFlag 加盟店自由項目返却フラグ
    #
    # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :OrderID オーダーID
    #   @option payload [String] :Method 支払方法
    #   @option payload [Number] :PayTimes 支払回数
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :SeqMode カード登録連番モード
    #   @option payload [Number] :CardSeq カード登録連番
    #   @option payload [String] :CardPass カードパスワード
    #   @option payload [String] :SecurityCode セキュリティコード
    #   @option payload [String] :ClientField1 加盟店自由項目1
    #   @option payload [String] :ClientField2 加盟店自由項目2
    #   @option payload [String] :ClientField3 加盟店自由項目3
    #   @option payload [String] :ClientFieldFlag 加盟店自由項目返却フラグ
    #
    # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :OrderID オーダーID
    #   @option payload [String] :Method 支払方法
    #   @option payload [Number] :PayTimes 支払回数
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :SeqMode カード登録連番モード
    #   @option payload [Number] :CardSeq カード登録連番
    #   @option payload [String] :CardPass カードパスワード
    #   @option payload [String] :SecurityCode セキュリティコード
    #   @option payload [String] :HttpAccept HTTP_ACCEPT
    #   @option payload [String] :HttpUserAgent HTTP_USER_AGENT
    #   @option payload [String] :DeviceCategory 使用端末情報
    #   @option payload [String] :ClientField1 加盟店自由項目1
    #   @option payload [String] :ClientField2 加盟店自由項目2
    #   @option payload [String] :ClientField3 加盟店自由項目3
    #   @option payload [String] :ClientFieldFlag 加盟店自由項目返却フラグ
    #
    # @return [Faraday::Response] 決済実行結果
    def exec_tran(payload)
      # 2.1.  カード番号を入力して決済する＜本人認証サービスを未使用＞
      # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
      #   [String] :ACS ACS呼出判定
      #   [String] :OrderID オーダーID
      #   [String] :Forward 仕向先コード
      #   [String] :Method 支払方法
      #   [String] :PayTimes 支払回数
      #   [String] :Approve 承認番号
      #   [String] :TranID トランザクションID
      #   [String] :TranDate 決済日付(yyyyMMddHHmmss形式)
      #   [String] :CheckString MD5ハッシュ
      #   [String] :ClientField1 加盟店自由項目1
      #   [String] :ClientField2 加盟店自由項目2
      #   [String] :ClientField3 加盟店自由項目3
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      #
      # 2.2.  カード番号を入力して決済する＜本人認証サービスを使用＞
      # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
      #   [String] :ACS ACS呼出判定
      #   [String] :ACSUrl 本人認証パスワード入力画面URL
      #   [String] :PaReq 本人認証要求電文
      #   [String] :MD 取引ID
      conn.post '/payment/ExecTran.idPass', payload
    end

    # 認証後決済実行
    # POST /payment/SecureTran.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.2. カード番号を入力して決済する＜本人認証サービスを使用＞
    #   @option payload [String] :PaRes 本人認証サービス結果
    #   @option payload [String] :MD 取引ID
    #
    # @return [Faraday::Response] 認証後決済実行結果
    def secure_tran(payload)
      # 2.2. カード番号を入力して決済する＜本人認証サービスを使用＞
      #   [String] :OrderID オーダーID
      #   [String] :Forward 仕向先コード
      #   [String] :Method 支払方法
      #   [String] :PayTimes 支払回数
      #   [String] :Approve 承認番号
      #   [String] :TranID トランザクションID
      #   [String] :TranDate 決済日付(yyyyMMddHHmmss形式)
      #   [String] :CheckString MD5ハッシュ
      #   [String] :ClientField1 加盟店自由項目1
      #   [String] :ClientField2 加盟店自由項目2
      #   [String] :ClientField3 加盟店自由項目3
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/SecureTran.idPass', payload
    end

    # 決済変更
    # POST /payment/AlterTran.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.12. 決済の内容を取り消す
    #   @option payload [String] :ShopID ショップID
    #   @option payload [String] :ShopPass ショップパスワード
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :JobCd 処理区分
    #
    # 2.13. 取り消した決済に再度オーソリを行う
    #   @option payload [String] :ShopID ショップID
    #   @option payload [String] :ShopPass ショップパスワード
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :JobCd 処理区分
    #   @option payload [Number] :Amount 利用金額
    #   @option payload [Number] :Tax 税送料
    #   @option payload [String] :Method 支払方法
    #   @option payload [Number] :PayTimes 支払回数
    #
    # 2.14. 売上の確定を行う
    #   @option payload [String] :ShopID ショップID
    #   @option payload [String] :ShopPass ショップパスワード
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :JobCd 処理区分
    #   @option payload [Number] :Amount 利用金額
    #
    # @return [Faraday::Response] 決済変更結果
    def alter_tran(payload)
      # 2.12. 決済の内容を取り消す
      # 2.13. 取り消した決済に再度オーソリを行う
      # 2.14. 売上の確定を行う
      #   [String] :AccessID 取引ID
      #   [String] :AccessPass 取引パスワード
      #   [String] :Forward 仕向先コード
      #   [String] :Approve 承認番号
      #   [String] :TranID トランザクションID
      #   [String] :TranDate 決済日付(yyyyMMddHHmmss形式)
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/AlterTran.idPass', payload
    end

    # 金額変更
    # POST /payment/ChangeTran.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.15. 完了した決済に金額の変更を行う
    #   @option payload [String] :ShopID ショップID
    #   @option payload [String] :ShopPass ショップパスワード
    #   @option payload [String] :AccessID 取引ID
    #   @option payload [String] :AccessPass 取引パスワード
    #   @option payload [String] :JobCd 処理区分
    #   @option payload [Number] :Amount 利用金額
    #   @option payload [Number] :Tax 税送料
    #
    # @return [Faraday::Response] 金額変更結果
    def change_tran(payload)
      # 2.15. 完了した決済に金額の変更を行う
      #   [String] :AccessID 取引ID
      #   [String] :AccessPass 取引パスワード
      #   [String] :Forward 仕向先コード
      #   [String] :Approve 承認番号
      #   [String] :TranID トランザクションID
      #   [String] :TranDate 決済日付(yyyyMMddHHmmss形式)
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/ChangeTran.idPass', payload
    end

    # 取引状態参照
    # POST /payment/SearchTrade.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.16. 決済結果を参照する
    #   @option payload [String] :ShopID ショップID
    #   @option payload [String] :ShopPass ショップパスワード
    #   @option payload [String] :OrderID オーダーID
    #
    # @return [Faraday::Response] 取引状態参照結果
    def search_trade(payload)
      # 2.16. 決済結果を参照する
      #   [String] :OrderID オーダーID
      #   [String] :Status 現状態
      #   [String] :ProcessDate 処理日付(yyyyMMddHHmmss形式)
      #   [String] :JobCd 処理区分
      #   [String] :AccessID 取引ID
      #   [String] :AccessPass 取引パスワード
      #   [String] :ItemCd 商品コード
      #   [Number] :Amount 利用金額
      #   [Number] :Tax 税送料
      #   [String] :SiteID サイトID
      #   [String] :MemberID 会員ID
      #   [String] :CardNo カード番号
      #   [String] :Expire 有効期限(YYMM形式)
      #   [String] :Method 支払方法
      #   [Number] :PayTimes 支払回数
      #   [String] :Forward 仕向先コード
      #   [String] :TranID トランザクションID
      #   [String] :Approve 承認番号
      #   [String] :ClientField1 加盟店自由項目1
      #   [String] :ClientField2 加盟店自由項目2
      #   [String] :ClientField3 加盟店自由項目3
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/SearchTrade.idPass', payload
    end

    # 決済後カード登録
    # POST /payment/TradedCard.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.17. カード番号決済に使用したカード番号を登録する
    #   @option payload [String] :ShopID ショップID
    #   @option payload [String] :ShopPass ショップパスワード
    #   @option payload [String] :OrderID オーダーID
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :SeqMode カード登録連番モード
    #   @option payload [String] :DefaultFlag 洗替・継続課金フラグ
    #   @option payload [String] :HolderName 名義人
    #
    # @return [Faraday::Response] 決済後カード登録結果
    def traded_card(payload)
      # 2.17. カード番号決済に使用したカード番号を登録する
      #   [String] :CardSeq カード登録連番
      #   [String] :CardNo カード番号
      #   [String] :Forward 仕向先コード
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/TradedCard.idPass', payload
    end

    # 会員登録
    # POST /payment/SaveMember.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.3. 会員情報を登録する
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :MemberName 会員名
    #
    # @return [Faraday::Response] 会員登録結果
    def save_member(payload)
      # 2.3. 会員情報を登録する
      #   [String] :MemberID 会員ID
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/SaveMember.idPass', payload
    end

    # 会員更新
    # POST /payment/UpdateMember.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.4. 会員情報を更新する
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :MemberName 会員名
    #
    # @return [Faraday::Response] 会員更新結果
    def update_member(payload)
      # 2.4. 会員情報を更新する
      #   [String] :MemberID 会員ID
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/UpdateMember.idPass', payload
    end

    # 会員削除
    # POST /payment/DeleteMember.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.5. 会員情報を削除する
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #
    # @return [Faraday::Response] 会員削除結果
    def delete_member(payload)
      # 2.5. 会員情報を削除する
      #   [String] :MemberID 会員ID
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/DeleteMember.idPass', payload
    end

    # 会員参照
    # POST /payment/SearchMember.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.6. 会員情報を参照する
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #
    # @return [Faraday::Response] 会員参照結果
    def search_member(payload)
      # 2.6. 会員情報を参照する
      #   [String] :MemberID 会員ID
      #   [String] :MemberName 会員名
      #   [String] :DeleteFlag 削除フラグ
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/SearchMember.idPass', payload
    end

    # カード登録／更新
    # POST /payment/SaveCard.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.7. カード譲歩を登録または更新する
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :SeqMode カード登録連番モード
    #   @option payload [Number] :CardSeq カード登録連番
    #   @option payload [String] :DefaultFlag 洗替・継続課金フラグ
    #   @option payload [String] :CardName カード会社略称
    #   @option payload [String] :CardNo カード番号
    #   @option payload [String] :CardPass カードパスワード
    #   @option payload [String] :Expire 有効期限
    #   @option payload [String] :HolderName 名義人
    #
    # @return [Faraday::Response] カード登録／更新結果
    def save_card(payload)
      # 2.7. カード譲歩を登録または更新する
      #   [String] :CardSeq カード登録連番
      #   [String] :CardNo カード番号
      #   [String] :Forward 仕向先コード
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/SaveCard.idPass', payload
    end

    # カード削除
    # POST /payment/DeleteCard.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.8. カード情報の削除をする
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :SeqMode カード登録連番モード
    #   @option payload [Number] :CardSeq カード登録連番
    #
    # @return [Faraday::Response] カード削除結果
    def delete_card(payload)
      # 2.8. カード情報の削除をする
      #   [String] :CardSeq カード登録連番
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/DeleteCard.idPass', payload
    end

    # カード参照
    # POST /payment/SearchCard.idPass
    #
    # @param [Hash] payload 送信データ
    #
    # 2.9.  カード情報を参照する
    # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
    # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
    #   @option payload [String] :SiteID サイトID
    #   @option payload [String] :SitePass サイトパスワード
    #   @option payload [String] :MemberID 会員ID
    #   @option payload [String] :SeqMode カード登録連番モード
    #   @option payload [Number] :CardSeq カード登録連番
    #
    # @return [Faraday::Response] カード参照結果
    def search_card(payload)
      # 2.9.  カード情報を参照する
      # 2.10. 登録したカード情報で決済する＜本人認証サービスを未使用＞
      # 2.11. 登録したカード情報で決済する＜本人認証サービスを使用＞
      #   [String] :CardSeq カード登録連番
      #   [String] :DefaultFlag 洗替・継続課金フラグ
      #   [String] :CardName カード会社略称
      #   [String] :CardNo カード番号
      #   [String] :Expire 有効期限
      #   [String] :HolderName 名義人
      #   [String] :DeleteFlag 削除フラグ
      #   [String] :ErrCode エラーコード
      #   [String] :ErrInfo エラー詳細コード
      conn.post '/payment/SearchCard.idPass', payload
    end

    private

    # @return [Faraday::Connection] 通信コネクション
    def conn
      @conn ||= Faraday.new(@options) { |conn|
        conn.request :url_encoded
        conn.adapter Faraday.default_adapter
      }
    end
  end
end
