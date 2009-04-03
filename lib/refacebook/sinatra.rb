require 'sinatra/base'
require 'refacebook'

module Sinatra
  module ReFacebook
    
    def fbsession
      @session
    end

    def facebook_require_login
      unless session[:fbsession]

      end
    end

    def facebook_require_install
      unless session[:fbsession]

      end
    end
  end

  register ReFacebook
end
