module GMO
  class FaradayMiddleware < Faraday::Middleware
    # @return [GMO::Configuration] 設定情報
    # @see GMO::Configuration
    attr_accessor :options

    # @param [Hash|GMO::Configuration] options オプション
    #
    # @option options [Boolean] :raise_on_gmo_error
    #   GMOのレスポンスがエラーの場合に{GMO::Errors}を発生させるかどうか
    #
    # @see GMO::Configuration
    def initialize(app, options = nil)
      super app
      @options = GMO.config.merge(options || {})
    end

    # リクエスト/レスポンスのハンドリング
    #
    # @param [Faraday::Env] req_env リクエスト情報
    def call(req_env)
      req_env[:body] = GMO::Payload.dump(req_env[:body]) if req_env[:body]
      @app.call(req_env).on_complete do |res_env|
        if res_env[:body]
          res_env[:body] = GMO::Payload.load(res_env[:body])

          if options[:raise_on_gmo_error]
            body = res_env[:body]
            if body[:err_code] || body[:err_info]
              raise GMO::Errors.new(body[:err_code], body[:err_info])
            end
          end
        end
      end
    end
  end
end
