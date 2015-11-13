module GMO
  module FaradayMiddleware
    autoload :Request,  'gmo/faraday_middleware/request'
    autoload :Response, 'gmo/faraday_middleware/response'

    Faraday::Request.register_middleware  gmo: Request
    Faraday::Response.register_middleware gmo: Response
  end
end
