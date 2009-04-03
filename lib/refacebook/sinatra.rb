require 'sinatra/base'
require 'refacebook'

module Sinatra
  module ReFacebook
    def fbml_redirect url
      body "<fb:redirect url=\"#{url}\" />"
    end
  end

  register ReFacebook
end
