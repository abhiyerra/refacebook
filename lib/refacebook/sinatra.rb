require 'sinatra/base'
require 'rack'
require 'refacebook'

module Sinatra
  module ReFacebookHelper
    def in_canvas?
      params["fb_sig_in_canvas"].eql? "1"
    end

    # Return a url prefixed with the canvas url with a path given as an argument.
    def link_from_canvas(path="")
      path = (path.empty? || path.eql?("/")) ? "" : "/#{path}"
      "#{options.canvas_url}#{path}"
    end

    def fbml_redirect(url)
      halt "<fb:redirect url=\"#{url}\" />"
    end
  end

  module ReFacebookRegister
    def require_facebook *args
      settings = args[0]

      configure do
        set :canvas_url, settings[:canvas_url]
      end

      before do 
        # Passes the request to the correct request method since canvas requests
        # come in as POSTs.
        request.env['REQUEST_METHOD'] = 'GET' if params["fb_sig_in_canvas"].eql? "1" \
                                             and params["fb_sig_request_method"].eql? "GET"

        @fbsession = ReFacebook::Session.new(settings[:api_key], settings[:secret_key])

        if settings[:require_login] and !params['fb_sig_session_key']
          fbml_redirect(@fbsession.get_login_url(:next => link_from_canvas(request.fullpath),
                                                 :canvas => true))
        end
      end
    end
  end

  helpers ReFacebookHelper
  register ReFacebookRegister
end
