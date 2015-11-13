module GMO
  module FaradayMiddleware
    autoload :Request,  'gmo/faraday_middleware/request'
    autoload :Response, 'gmo/faraday_middleware/response'
    autoload :RaiseGMOError, 'gmo/faraday_middleware/raise_gmo_error'

    Faraday::Request.register_middleware  gmo: Request
    Faraday::Response.register_middleware gmo: Response
    Faraday::Response.register_middleware raise_gmo_error: RaiseGMOError
  end
end
