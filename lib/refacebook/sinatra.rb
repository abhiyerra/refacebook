require 'sinatra/base'
require 'rack'
require 'refacebook'

module Sinatra
  module ReFacebookHelper
    def require_facebook *args
      settings = args[0]

      before do 
        # Passes the request to the correct request method since canvas requests
        # come in as POSTs.
        request.env['REQUEST_METHOD'] = 'GET' if params["fb_sig_in_canvas"].eql? "1" \
                                             and params["fb_sig_request_method"].eql? "GET"

        @fbsession = ReFacebook::Session.new(settings[:api_key], settings[:secret_key])

        if settings[:require_login] and !params['fb_sig_session_key']
          halt fbml_redirect(@fbsession.get_login_url(:next => settings[:canvas_url] + request.fullpath,
                                                      :canvas => true))
        end
      end
    end

    def fbml_redirect(url)
      "<fb:redirect url=\"#{url}\" />"
    end
  end

  register ReFacebookHelper
end
