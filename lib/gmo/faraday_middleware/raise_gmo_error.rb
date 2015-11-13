module GMO
  class FaradayMiddleware::RaiseGMOError < Faraday::Response::Middleware
    # レスポンスデータを処理する
    #
    # @param [Faraday::Env] env レスポンスデータ
    def on_complete(env)
      body = env[:body]
      if !!body && body.respond_to?(:[])
        if body[:err_code] || body[:err_info]
          raise GMO::Errors.new(body[:err_code], body[:err_info])
        end
      end
    end
  end
end
