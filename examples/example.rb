$:.push('../lib/')

require 'rubygems'
require 'sinatra'
require 'refacebook'
require 'refacebook/sinatra'

enable :sessions

require_facebook(:api_key =>'2a7a86cd4ea39bb7ea4eaabb938acb86',
                 :secret_key => '662361041ddcb4b3f7df0f4b092249ee',
                 :canvas_url => 'http://apps.facebook.com/traytwo',
                 :require_login => true)

post '/' do
  body params.collect {|k,v| "#{k} = #{v}<br/>" }
end


post '/require_login' do
  params.each {|k,v| puts "#{k} = #{v}" }
end

post '/test/2' do
  request.fullpath
end
