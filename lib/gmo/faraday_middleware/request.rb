module GMO
  class FaradayMiddleware::Request < Faraday::Middleware
    # リクエストデータを処理する
    #
    # @param [Faraday::Env] env リクエストデータ
    def call(env)
      env[:body] = GMO::Payload.dump(env[:body]) if env[:body]
      @app.call env
    end
  end
end
