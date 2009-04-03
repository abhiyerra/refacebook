$:.push('../lib/')

require 'rubygems'
require 'sinatra'
require 'refacebook'
#require 'refacebook/sinatra'

enable :sessions

configure do
  set :facebook_api_key, ''
  set :facebook_secret_key, ''
  set :facebook_canvas_url, 'http://apps.facebook.com/traytwo/'
end

before do
  #facebook_require_login
  #facebook_require_install

  @fbsession = ReFacebook::Session.new(options.facebook_api_key, options.facebook_secret_key)
end

get '/' do
  redirect @fbsession.get_login_url :next => options.facebook_canvas_url, :canvas => true
end

