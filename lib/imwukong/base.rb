require 'httpclient'
require 'digest'
require 'json'

module Imwukong
  class Base

    DEV_HOST        = 'https://sandbox-wkapi.laiwang.com'.freeze
    PRODUCTION_HOST = "https://wkapi.laiwang.com"

    def initialize(app_domain = Imwukong.config[:domain],
                   app_token = Imwukong.config[:server][:app_token])
      fail 'app domain/token is invalid' unless app_domain.present? && app_token.present?
      @app_domain  = app_domain.strip
      @app_token   = app_token.strip
      @http_client = HTTPClient.new
    end

    def wk_post(type, method, prefix='v1/im', params)
      prefix ||= 'v1/im'
      result = @http_client.post(get_request_url(type, method, prefix), params.to_json, wukong_header) rescue nil
      handle_response(result)
    end

    def wk_get(type, method, prefix='v1/im', params)
      prefix ||= 'v1/im'
      result = @http_client.get(get_request_url(type, method, prefix), params, wukong_header) rescue nil
      handle_response(result)
    end

    private

    def safe_json_parse(data)
      JSON.parse(data)
        # rescue TypeError which will cause 'no implicit conversion of HTTParty::Response into String'
    rescue JSON::ParserError, TypeError
      warn data.inspect
      {}
    end

    def handle_response(result)
      # warn result.inspect
      fail 'No respond from server' if result.nil?
      fail "Request fail, return code:#{result.code}" unless result.ok?
      r = safe_json_parse(result.body)
      fail "#{r['errorCode']}, #{r['errorMessage']}" if r['success'] == false
      r['data']
    end

    def wukong_host
      Imwukong.config[:env] == 'production' ? PRODUCTION_HOST : DEV_HOST
    end

    def get_request_url(type, method, prefix='v1/im')
      # warn "#{wukong_host}/#{prefix}/#{type}/#{method}"
      "#{wukong_host}/#{prefix}/#{type}/#{method}"
    end

    def wukong_sign(token = @app_token)
      @timestamp = Time.now.to_i.to_s
      @nonce     = rand(100000..200000).to_s
      array      = [token, @timestamp, @nonce].sort
      sign       = Digest::SHA1.hexdigest(array.join)
      sign
    end

    def wukong_header
      {
        'Authorization' => %Q(Wukong signature_method="sha1", domain="#{@app_domain}", signature="#{wukong_sign}", timestamp="#{@timestamp}", nonce="#{@nonce}", version="1.0"),
        'Content-Type'  => 'application/json'
      }
    end
  end
end
