require 'sinatra/base'
require 'refacebook'

module Sinatra
  module ReFacebookHelper
    def require_facebook *args
      settings = args[0]

      before do 
        @fbsession = ReFacebook::Session.new(settings[:api_key], settings[:secret_key])

        puts request.fullpath

        if settings[:require_login] and !params['fb_sig_session_key']
          halt 200, fbml_redirect(@fbsession.get_login_url(:next => settings[:canvas_url] + request.fullpath,
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
