module GMO
  module Consts
    # 処理区分
    JOB_CDS = [
      JOB_CD_CHECK   = 'CHECK',   # 有効性チェック
      JOB_CD_CAPTURE = 'CAPTURE', # 即時売上
      JOB_CD_AUTH    = 'AUTH',    # 仮売上
      JOB_CD_SAUTH   = 'SAUTH',   # 簡易オーソリ
      JOB_CD_SALES   = 'SALES',   # 実売上
      JOB_CD_VOID    = 'VOID',    # 取消
      JOB_CD_RETURN  = 'RETURN',  # 返品
      JOB_CD_RETURNX = 'RETURNX', # 月跨ぎ返品
    ]

    # 本人認証サービス利用フラグ
    TD_FLAGS = [
      TD_FLAG_OFF = '0', # 行わない
      TD_FLAG_ON  = '1', # 行う
    ]

    # 支払方法
    METHODS = [
      METHOD_ONE_TIME          = '1', # 一括
      METHOD_INSTALLMENT       = '2', # 分割
      METHOD_BONUS_ONE_TIME    = '3', # ボーナス一括
      METHOD_BONUS_INSTALLMENT = '4', # ボーナス分割
      METHOD_REVOLVING         = '5', # リボ
    ]

    # 加盟店自由項目返却フラグ
    CLIENT_FIELD_FLAGS = [
      CLIENT_FIELD_FLAG_OFF = '0', # 返却しない
      CLIENT_FIELD_FLAG_ON  = '1', # 返却する
    ]

    # ACS呼出判定
    ACSES = [
      ACS_WITHOUT = '0', # ACS呼出不要
      ACS_WITH    = '1', # ACS呼出要
    ]

    # 使用端末情報
    DEVICE_CATEGORIES = [
      DEVICE_CATEGORY_PC     = '0', # PC
      DEVICE_CATEGORY_MOBILE = '1', # 携帯装置(2008年9月現在 未対応)
    ]

    # 削除フラグ
    DELETE_FLAGS = [
      DELETE_FLAG_OFF = '0', # 未削除
      DELETE_FLAG_ON  = '1', # 削除済
    ]

    # カード登録連番モード
    SEQ_MODES = [
      SEQ_MODE_LOGICAL  = '0', # 論理モード
      SEQ_MODE_PHYSICAL = '1', # 物理モード
    ]

    # 洗替・継続課金フラグ
    DEFAULT_FLAGS = [
      DEFAULT_FLAG_OFF = '0', # 継続課金対象としない
      DEFAULT_FLAG_ON  = '1', # 継続課金対象とする
    ]

    # 現状態
    STATUSES = [
      STATUS_UNPROCESSED   = 'UNPROCESSED',   # 未決済
      STATUS_AUTHENTICATED = 'AUTHENTICATED', # 未決済(3D登録済)
      STATUS_CHECK         = 'CHECK',         # 有効性チェック
      STATUS_CAPTURE       = 'CAPTURE',       # 即時売上
      STATUS_AUTH          = 'AUTH',          # 仮売上
      STATUS_SALES         = 'SALES',         # 実売上
      STATUS_VOID          = 'VOID',          # 取消
      STATUS_RETURN        = 'RETURN',        # 返品
      STATUS_RETURNX       = 'RETURNX',       # 月跨ぎ返品
      STATUS_SAUTH         = 'SAUTH',         # 簡易オーソリ
    ]
  end
end
