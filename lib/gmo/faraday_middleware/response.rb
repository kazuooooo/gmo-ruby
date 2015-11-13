module GMO
  class FaradayMiddleware::Response < Faraday::Response::Middleware
    # レスポンスデータを処理する
    #
    # @param [Faraday::Env] env レスポンスデータ
    def on_complete(env)
      env[:body] = GMO::Payload.load(env[:body]) if env[:body]
    end
  end
end
