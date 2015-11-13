module GMO
  class Errors < StandardError
    include Enumerable

    # [String] 複数のエラーの接続文字
    SEPARATOR = '|'

    # [Array<String>] エラーコード
    attr_reader :err_code

    # [Array<String>] エラー詳細コード
    attr_reader :err_info

    # @param [String] err_code エラーコード(複数の場合は"|"で接続された文字列)
    # @param [String] err_info エラー詳細コード(複数の場合は"|"で接続された文字列)
    def initialize(err_code, err_info)
      @err_code = err_code.to_s.split(SEPARATOR) if err_code.respond_to?(:split)
      @err_info = err_info.to_s.split(SEPARATOR) if err_info.respond_to?(:split)
      super full_messages.join(' ')
    end

    # Enumerableの実装
    #
    # @yield [err_code, err_info, message] エラー情報
    #
    # @yieldparam [String] err_code エラーコード
    # @yieldparam [String] err_info エラー詳細コード
    # @yieldparam [String] message エラーメッセージ
    #
    # @return [Enumerator] Enumerator
    def each
      if block_given?
        @err_code.zip(@err_info) do |err_code, err_info|
          yield err_code, err_info, describe_message(err_code, err_info)
        end
      end
      to_enum(:each)
    end

    # エラーメッセージをすべて取得する
    #
    # @return [Array<String>] エラーメッセージ
    def full_messages
      map{ |_, _, message| message }
    end

    private

    # エラーコード、エラー詳細コードに応じたエラーメッセージを返却する
    #
    # @param [String] err_code エラーコード
    # @param [String] err_info エラー詳細コード
    #
    # @return [String] エラーメッセージ
    def describe_message(err_code, err_info)
      case err_code
      when /E01/
        # カード所有者に再入力を必要とするエラーに限り、細かいエラーの内容を返却
        case err_info
        when /E01160010/ then 'ボーナス分割回数に"2"以外を指定しています。'
        when /E01170001/ then 'カード番号が指定されていません。'
        when /E01170003/ then 'カード番号が最大文字数を超えています。'
        when /E01170006/ then 'カード番号に数字以外の文字が含まれています。'
        when /E01170011/ then 'カード番号が10桁〜16桁の範囲ではありません。'
        when /E01180001/ then '有効期限が指定されていません。'
        when /E01180003/ then '有効期限が4桁ではありません。'
        when /E01180006/ then '有効期限に数字以外の文字が含まれています。'
        when /E01180008/ then '有効期限の書式が正しくありません。'
        when /E01250008/ then 'カードパスワードの書式が正しくありません。'
        when /E01250010/ then 'カードパスワードが一致しません。'
        when /E01260001/ then '支払方法が指定されていません。'
        when /E01260002/ then '指定された支払方法が存在しません。'
        when /E01260010/ then '指定されたカード番号または支払方法が正しくありません。'
        when /E01270001/ then '支払回数が指定されていません。'
        when /E01270005/ then '支払回数が最大桁数を超えています。'
        when /E01270006/ then '支払回数の数字以外の文字が含まれています。'
        when /E01270010/ then '指定された支払回数はご利用できません。'
        when /E01320012/ then '加盟店自由項目1の値が最大バイト数を超えています。'
        when /E01330012/ then '加盟店自由項目2の値が最大バイト数を超えています。'
        when /E01340012/ then '加盟店自由項目3の値が最大バイト数を超えています。'
        when /E01430012/ then '会員名の値が最大バイト数を超えています。'
        when /E01460008/ then 'セキュリティコードの書式が正しくありません。'
        when /E01480008/ then '名義人の書式が正しくありません。'
        when /E01480008/ then '名義人の書式が正しくありません。'
        else                  "取引できません(#{err_code}|#{err_info})。"
        end
      when /E11/
        # カード所有者に通知が必要なエラーに限り、細かいエラーの内容を返却
        case err_info
        when /E11010001/ then 'この取引は既に決済が終了しています。'
        when /E11010002/ then 'この取引は決済が終了していませんので、変更する事が出来ません。'
        when /E11010003/ then 'この取引は指定処理区分処理を行う事が出来ません。'
        when /E11010010/ then '180日超えの取引のため、処理を行う事が出来ません。'
        when /E11010099/ then 'このカードはご利用になれません。'
        else                  "取引できません(#{err_code}|#{err_info})。"
        end
      when /E21/
        case err_info
        when /E21010001/, /E21010007/, /E21010999/, /E21020001/, /E21020007/, /E21020999/
          "3Dセキュア認証に失敗しました。もう一度、購入画面からやり直して下さい(#{err_code}|#{err_info})。"
        when /E21020002/
          "3Dセキュア認証がキャンセルされました。もう一度、購入画面からやり直して下さい(#{err_code}|#{err_info})。"
        when /E21010201/, /E21010202/
          "このカードでは取引をすることができません。3Dセキュア認証に対応したカードをお使いください(#{err_code}|#{err_info})。"
        else
          "取引できません(#{err_code}|#{err_info})。"
        end
      when /E41/
        case err_info
        when /E41170002/ then '入力されたカード会社に対応していません。別のカード番号を入力して下さい。'
        when /E41170099/ then 'カード番号に誤りがあります。再度確認して入力して下さい。'
        else                  "取引できません(#{err_code}|#{err_info})。"
        end
      when /E61/
        # カード所有者に再入力を必要とするエラーに限り、細かいエラーの内容を返却
        case err_info
        when /E61020001/ then '指定の決済方法は利用停止になっています。'
        when /E61020001/ then '指定の決済方法は利用停止になっています。'
        else                  "取引できません(#{err_code}|#{err_info})。"
        end
      when /E91/
        # カード所有者に取引失敗の通知が必要なエラーに限り、細かいエラーの内容を返却
        case err_info
        when /E91019999/, /E91029999/, /E91099999/
          "決済処理に失敗しました。申し訳ございませんが、しばらく時間をあけて購入画面からやり直してください(#{err_code}|#{err_info})。"
        when /E91020001/ then '通信タイムアウトが発生しました。申し訳ございませんが、しばらく時間をあけて購入画面からやり直してください。'
        when /E91029998/ then '決済処理に失敗しました。該当のお取引について、店舗までお問合せください。'
        when /E91060001/ then 'システムの内部エラーです。発生時刻や呼び出しパラメータをご確認のうえ、お問い合わせください。'
        else                  "取引できません(#{err_code}|#{err_info})。"
        end
      when /G[0-9]{2}/
        # カード会社返却エラーコード
        case err_info
        when /42G020000/, /42G040000/
          "カード残高が不足しているために、決済を完了する事が出来ませんでした(#{err_code}|#{err_info})。"
        when /42G030000/, /42G050000/, /42G550000/
          "カード限度額を超えているために、決決済を完了する事が出来ませんでした(#{err_code}|#{err_info})。"
        when /42G420000/ then 'セキュリティーコードが誤っていた為に、決済を完了する事が出来ませんでした。'
        when /42G450000/ then 'セキュリティーコードが入力されていない為に、決済を完了する事が出来ませんでした。'
        when /42G650000/ then 'カード番号に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G670000/ then '商品コードに誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G680000/ then '金額に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G690000/ then '税送料に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G700000/ then 'ボーナス回数に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G710000/ then 'ボーナス月に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G720000/ then 'ボーナス額に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G730000/ then '支払開始月に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G740000/ then '分割回数に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G750000/ then '分割金額に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G760000/ then '初回金額に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G770000/ then '業務区分に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G780000/ then '支払区分に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G790000/ then '照会区分に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G800000/ then '取消区分に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G810000/ then '取消取扱区分に誤りがあるために、決済を完了する事が出来ませんでした。'
        when /42G830000/ then '有効期限に誤りがあるために、決済を完了する事が出来ませんでした。'
        else
          "このカードでは取引をする事が出来ません(#{err_code}|#{err_info})。"
        end
      else
        "取引できません(#{err_code}|#{err_info})。"
      end
    end
  end
end
