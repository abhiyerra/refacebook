require 'net/http'
require 'uri'
require 'md5'
require 'json'

module ReFacebook
  APIRestServer = 'http://api.facebook.com/restserver.php'
  LoginUrl = "http://www.facebook.com/login.php"

  class Session
    attr_reader :api_key, :secret, :api

    attr_accessor :user, :friends, :session_key, 
                  :expires, :time, :profile_update_time

    def initialize api_key, secret
      @api_key = api_key
      @secret = secret
      @api = API.new(api_key, secret)

      %w{user friends session_key expires time profile_update_time}.each do |var|
        instance_variable_set "@#{var}", nil
      end
    end

    def self.create api_key, secret, args
      session = nil

      if args['fb_sig_session_key']
        if args['auth_token']
          # Brand new sesion since token is given.
          session = new(api_key, secret)
        else
          # Session exists. Find it
          session = nil# args['fb_sig_session_key']

          session = new(api_key, secret) if session.nil?
        end

          # if( isset($_REQUEST[$prefix.'_session_key']) ){
          #    session_name( $_REQUEST[$prefix.'_session_key'] );
          #    session_start();
          #
        puts session

        session.user = args['fb_sig_user']
        session.friends = args['fb_sig_friends'].split(',')

        session.session_key = args['fb_sig_session_key']
        session.expires = args['fb_sig_expires']
        session.time = args['fb_sig_time']

        session.profile_update_time = args['fb_sig_profile_update_time']
      else
        # Just return a session, even if it's not a lasting session.
        session = new(api_key, secret)
      end

      session
    end

    def get_login_url *args
      params = {}
      params['v'] = '1.0'
      params['api_key'] = @api_key
      params['next'] = args[0][:next]

      if args[0][:canvas]
        params['canvas'] = '1'
      end

      LoginUrl + '?' + params.collect {|k,v| "#{k}=#{v}"}.join('&')
    end

    def auth_session auth_token
      @session = JSON.parse(@api.auth_getSession(:auth_token => auth_token))
    end
  end

  class API
    def initialize api_key, secret
      @api_key = api_key
      @secret = secret
    end

    def method_missing method, *args
      request = {}

      args[0].each {|k,v| request[k.to_s] = v } if args[0]

      request['api_key'] = @api_key
      request['format'] = 'json' unless request['json']
      request['method'] = method.to_s.gsub(/_/, '.')
      request['v'] = '1.0' unless request['v']

      request['sig'] = generate_sig(request.sort)

      # FIXME: Implement.
      return if request['method'].eql? 'batch.run'
  
      req = Net::HTTP.post_form(URI.parse(APIRestServer), request)
      JSON.parse("[#{req.body}]")
    end

    private
      # args = array of args to the request, not counting sig, formatted in non-urlencoded arg=val pairs
      # sorted_array = alphabetically_sort_array_by_keys(args);
      # request_str = concatenate_in_order(sorted_array);
      # signature = md5(concatenate(request_str, secret))
      def generate_sig args
        request_str = args.collect { |k,v| "#{k}=#{v}" }.join ''
        MD5.hexdigest(request_str.concat(@secret));
      end
  end
end
