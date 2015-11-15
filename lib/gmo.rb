require "faraday"

require "gmo/version"
require "gmo/errors"
require "gmo/faraday_middleware"
require "gmo/client"
require "gmo/payload"

module GMO
  class Configuration
    # [String] url エンドポイントURL
    attr_accessor :url
    # [Hash] headers HTTPヘッダ
    attr_accessor :headers
    # [Hash] request リクエストオプション
    attr_accessor :request
    # [Hash] ssl SSLオプション
    attr_accessor :ssl
    # [Hash] proxy プロキシオプション
    attr_accessor :proxy
  end

  class << self
    # [GMO::Configuration] 設定情報
    attr_accessor :config
  end

  # モジュールの設定を行う
  #
  # @yield [config] 設定情報
  #
  # @yieldparam [GMO::Configuration] config 設定情報
  #
  # @example リクエストタイムアウトを設定する
  #   config.request = {
  #     timeout:      ..., # 通信タイムアウト(秒)
  #     open_timeout: ..., # 接続タイムアウト(秒)
  #   }
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
  #
  # @example プロキシを設定する
  #   config.proxy = {
  #     uri:      ...,
  #     user:     ..., # optional
  #     password: ..., # optional
  #   }
  def self.configure
    self.config ||= Configuration.new
    yield config if block_given?
  end
end
