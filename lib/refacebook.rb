require 'net/http'
require 'uri'
require 'md5'

module ReFacebook
  VERSION = '1.0.0'

  APIRestServer = 'http://api.facebook.com/restserver.php'
  LoginUrl = "http://www.facebook.com/login.php"

  class Session
    attr_reader :api_key, :secret, :api

    def initialize api_key, secret, *args
      @api_key = api_key
      @secret = secret

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

    def get_install_url *args
      
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

  class API
    def initialize api_key
      @api_key = api_key
    end

    def method_missing method, *args
      request = {}

      args[0].each {|k,v| request[k.to_s] = v } if args[0]

      request['method'] = method.to_s.gsub(/_/, '.')
      request['v'] = '1.0' unless request['v']
      request['format'] = 'json' unless request['json']
      request['api_key'] = @api_key

      request['sig'] = generate_sig(request.sort)

      # FIXME: Implement.
      return if request['method'].eql? 'batch.run'

      res = Net::HTTP.post_form(URI.parse(APIRestServer), request)
      res.body
    end
  end
end
