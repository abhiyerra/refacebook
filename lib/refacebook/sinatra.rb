require 'sinatra/base'
require 'refacebook'

module Sinatra
  module ReFacebookHelper
    # If in the facebook canvas returns true
    def in_canvas?
      params["fb_sig_in_canvas"].eql? "1"
    end

    # Return a concatenated url with the canvas url and the path
    def link_from_canvas(path="")
      path = (path.empty? || path.eql?("/")) ? "" : "/#{path}"
      "#{options.canvas_url}#{path}"
    end

    # Since redirect doesn't work in the canvas since it relies
    # on JavaScript Location field. This is a replacement which
    # uses fbml as a means to redirect to the given url.
    def fbml_redirect(url)
      halt "<fb:redirect url=\"#{url}\" />"
    end
  end

  module ReFacebookRegister
    # ReFacebook configuration done at the beginning of a Sinatra file.
    #
    # An exaple:
    # <pre><code>
    # require_facebook(:api_key =>'MY_API_KEY',
    #                  :secret_key => 'MY_SECRET_KEY',
    #                  :canvas_url => 'http://apps.facebook.com/canvas-page',
    #                  :require_login => true,
    #                  :store => store)
    # </code></pre>
    #
    # [:api_key] Your application's Facebook API key.
    # [:secret_key] Your application's Facebook Secret key.
    # [:canvas_url] The full path to your canvas page.
    # [:require_login] If this is set to true then the user is redirected to
    #   the login page where she needs to authenticate.
    # [:store] This currently uses memcache-client as the session store since
    #   Rack doesn't currently have non cookie based session stores.
    def require_facebook *args
      settings = args[0]

      configure do
        set :canvas_url, settings[:canvas_url]
      end

      before do 
        # Passes the request to the correct request method since canvas requests
        # come in as POSTs.
        if params["fb_sig_in_canvas"].eql? "1" and params["fb_sig_request_method"].eql? "GET"
          request.env['REQUEST_METHOD'] = 'GET' 
        end

        if params['fb_sig_session_key']
          @fbsession = settings[:store].get(params['fb_sig_session_key'])
          @fbsession = ReFacebook::Session.new(settings[:api_key], settings[:secret_key]) unless @fbsession
          @fbsession.update_session_params(params)

          expiry = @fbsession.expires.to_i - @fbsession.time.to_i
          settings[:store].set(params['fb_sig_session_key'], @fbsession, expiry)
        else
          # Just return a session, even if it's not a lasting session.
          @fbsession = ReFacebook::Session.new(settings[:api_key], settings[:secret_key])
        end

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
