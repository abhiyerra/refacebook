$:.push('../lib/')

require 'rubygems'
require 'sinatra'
require 'refacebook'
require 'refacebook/sinatra'
require 'memcache'

enable :sessions

store = MemCache.new 'localhost:11211'

require_facebook(:api_key =>'2a7a86cd4ea39bb7ea4eaabb938acb86',
                 :secret_key => '662361041ddcb4b3f7df0f4b092249ee',
                 :canvas_url => 'http://apps.facebook.com/traytwo',
                 :require_login => true,
                 :store => store)

get '/' do
  body params.collect {|k,v| "#{k} = #{v}<br/>" }
end

get '/require_login' do
  params.each {|k,v| puts "#{k} = #{v}" }
end

get '/link_from_canvas' do
  body link_from_canvas(request.fullpath)
end

get '/in_canvas' do
  if in_canvas?
    body "yes"
  else
    body "no"
  end
end
