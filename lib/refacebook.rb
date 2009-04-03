require 'open-uri'
require 'md5'

module ReFacebook
  VERSION = '1.0.0'

  APIRestServer = 'http://api.facebook.com/restserver.php'

  @session = nil

  class Session
    def initialize api_key, secret

    end

    def api

    end
  end

  class API
    def initialize secret
      @secret = secret
    end

    def method_missing method, *args
      request = {}

      args.each {|k,v| request[k.to_s] = v }

      request['method'] = method.to_s.gsub(/_/, '.')
      request['v'] = '1.0' unless request['v']
      request['sig'] = generate_sig request

      # FIXME: Implement.
      return if request['method'].eql? 'batch.run'

      open(APIRestServer, request).read
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

fb = ReFacebook.new ''
puts fb.test_setting :p => 'c', :g => 'd'
