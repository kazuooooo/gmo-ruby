require "faraday"

require "gmo/version"
require "gmo/errors"
require "gmo/faraday_middleware"
require "gmo/client"
require "gmo/payload"

module GMO
  class Configuration
    # @return [String] エンドポイントURL
    attr_accessor :url

    # @return [Hash] HTTPヘッダ
    attr_accessor :headers

    # @return [Hash] リクエストオプション
    #
    # @example リクエストタイムアウトを設定する
    #   config.request = {
    #     timeout:      ..., # 通信タイムアウト(秒)
    #     open_timeout: ..., # 接続タイムアウト(秒)
    #   }
    attr_accessor :request

    # @return [Hash] SSLオプション
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
    attr_accessor :ssl

    # @return [Hash] プロキシオプション
    #
    # @example プロキシを設定する
    #   config.proxy = {
    #     uri:      ...,
    #     user:     ..., # optional
    #     password: ..., # optional
    #   }
    attr_accessor :proxy

    def initialize
      @request = default_request
    end

    # デフォルトのリクエストオプションを取得
    #
    # @return [Hash] デフォルトのリクエストオプション
    def default_request
      {
        timeout: 90, # 90秒（本人認証サービスを利用する場合は120秒程度を推奨）
      }
    end
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
