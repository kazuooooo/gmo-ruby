require "faraday"
require "hashie"

require "gmo/version"
require "gmo/consts"
require "gmo/errors"
require "gmo/faraday_middleware"
require "gmo/client"
require "gmo/payload"

module GMO
  include Consts

  class Configuration < Hashie::Trash
    # @!attribute url
    #   @return [String] エンドポイントURL
    property :url

    # @!attribute headers
    #   @return [Hash] HTTPヘッダ
    property :headers

    # @!attribute request
    #   @return [Hash] リクエストオプション
    #
    # @example リクエストタイムアウトを設定する
    #   config.request = {
    #     timeout:      ..., # 通信タイムアウト(秒)
    #     open_timeout: ..., # 接続タイムアウト(秒)
    #   }
    property :request,
      default: {
        timeout: 90, # 90秒（本人認証サービスを利用する場合は120秒程度を推奨）
      }

    # @!attribute ssl
    #   @return [Hash] SSLオプション
    #
    # @example SSLを無効にする
    #   config.ssl = false
    #
    # @example 通信先のSSL証明書の検証を無効にする
    #   config.ssl = {verify: false}
    #
    # @example その他のSSLオプションを設定する
    #   config.ssl = {
    #     client_cert: ...,
    #     client_key:  ...,
    #     ca_file:     ...,
    #     ca_path:     ...,
    #     cert_store:  ...,
    #   }
    property :ssl

    # @!attribute proxy
    #   @return [Hash] プロキシオプション
    #
    # @example プロキシを設定する
    #   config.proxy = {
    #     uri:      ...,
    #     user:     ..., # optional
    #     password: ..., # optional
    #   }
    property :proxy

    # @!attribute raise_on_gmo_error
    #   @return [Boolean] GMOのレスポンスがエラーの場合に{GMO::Errors}を発生させるかどうか
    property :raise_on_gmo_error, required: true, default: true,
      transform_with: ->(v) { !!v }
  end

  # 設定情報を取得
  #
  # @return [GMO::Configuration] 設定情報
  def self.config
    @config ||= Configuration.new
  end

  # モジュールの設定を行う
  #
  # @yield [config] 設定情報
  #
  # @yieldparam [GMO::Configuration] config 設定情報
  #
  # @see GMO::Configuration
  def self.configure
    yield config if block_given?
  end
end
