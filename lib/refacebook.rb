require 'net/http'
require 'uri'
require 'md5'
require 'json'

# ReFacebook the main store for a facebook session.
module ReFacebook
  APIRestServer = "http://api.facebook.com/restserver.php"
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

    def update_session_params params
      @user = params['fb_sig_user']
      @friends = params['fb_sig_friends'].split(',')

      @session_key = params['fb_sig_session_key']

      @expires = params['fb_sig_expires']
      @time = params['fb_sig_time']

      @profile_update_time = params['fb_sig_profile_update_time']
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

    def session_key=(session_key)
      @session_key = @api.session_key = session_key
    end
  end

  class API
    attr_accessor :session_key

    def initialize api_key, secret
      @api_key = api_key
      @secret = secret
      @session_key = nil
    end

    # FIXME: Implement.
    def batch_run *args
      raise 
    end

    def method_missing method, *args
      request = {}

      args[0].each do |k,v| 
        request[k.to_s] = v.kind_of?(Array) ? v.to_json : v
      end if args[0]

      request['api_key'] = @api_key
      request['format'] = 'json' unless request['format']
      request['method'] = method.to_s.gsub(/_/, '.')
      request['session_key'] = @session_key if @session_key
      request['v'] = '1.0' unless request['v']

      request['sig'] = generate_sig(request.sort)

      req = Net::HTTP.post_form(URI.parse(APIRestServer), request)
      ret = JSON.parse("[#{req.body}]")[0]

      if ret.class == Hash && ret.has_key?('error_code')
        raise APIError.new(ret), ret['error_msg']
      end

      ret
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

  class APIError < StandardError
    attr_reader :error_code, :error_msg

    def initialize(response)
      @error_code = response['error_code']
      @error_msg = response['error_msg']
    end
  end
end
