$:.push('../lib/')

require 'rubygems'
require 'sinatra'
require 'refacebook'
#require 'refacebook/sinatra'

enable :sessions

configure do
  set :facebook_api_key, '2a7a86cd4ea39bb7ea4eaabb938acb86'
  set :facebook_secret_key, '662361041ddcb4b3f7df0f4b092249ee'
  set :facebook_canvas_url, 'http://apps.facebook.com/traytwo/'
end

before do
  #facebook_require_login
  #facebook_require_install

  @fbsession = ReFacebook::Session.new(options.facebook_api_key, options.facebook_secret_key)
  if params[:auth_token]
    @fbsession.session
  end

end

get '/' do
  redirect @fbsession.get_login_url :next => options.facebook_canvas_url, :canvas => true
end

