require 'sinatra/base'
require 'refacebook'

module Sinatra
  module ReFacebook
    attr_accessor :fbsession

    @fbsession = nil

    def facebook_require_login
      create_session do
        redirect @fbsession.get_login_url(request.url)
      end
    end

    def facebook_require_install
      create_session do 
        redirect @fbsession.get_install_url(request.url)
      end
    end

    private
      def create_session &block
        unless session[:facebook]
          if block_given?
          end
        end
      end
  end

  register ReFacebook
end
