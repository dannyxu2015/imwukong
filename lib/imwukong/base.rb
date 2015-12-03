require 'httparty'
require 'digest'

module Imwukong

  @imwukong_config = { env: 'development' }

  class << self
    attr_accessor :config

    def configure
      yield @config if block_given?
    end
  end

  class Base
    include HTTParty

    DEFAULT_OPTIONS = {
      api_version: 'v1'
    }
    DEV_HOST        = 'https://sandbox-wkapi.laiwang.com'.freeze
    PRODUCTION_HOST = "https://wkapi.laiwang.com"
    HTTP_METHOD     = :post

    def initialize(app_domain, app_token)
      raise 'app domain/token is invalid' unless app_domain.is_a?(String) && app_token.is_a?(String) && app_domain.present? && app_token.present?
      @app_domain = app_domain.strip
      @app_token  = app_token.strip
      @options    = DEFAULT_OPTIONS
    end

    def post_request(type, method, params)
      # options = { body: params }
      result = safe_json_parse(self.class.send(HTTP_METHOD, self.get_request_url(type, method), body: params, headers: wukong_header))
      # Todo: Error handler
      warn result.inspect
    end

    def safe_json_parse(data)
      JSON.parse(data)
        # rescue TypeError which will cause 'no implicit conversion of HTTParty::Response into String'
    rescue JSON::ParserError, TypeError
      {}
    end

    def wukong_host
      Imwukong.config[:env] == 'production' ? PRODUCTION_HOST : DEV_HOST
    end

    def get_request_url(type, method)
      warn "#{wukong_host}/#{@options[:api_version]}/#{type}/#{method}"
      "#{wukong_host}/#{@options[:api_version]}/#{type}/#{method}"
    end

    def wukong_sign(token = @app_token)
      @timestamp = Time.now.to_i.to_s
      @nonce     = rand(100000..200000).to_s
      array      = [token, @timestamp, @nonce].sort
      Digest::SHA1.hexdigest(array.join)
    end

    def wukong_header
      {
        'Authorization' => %Q(Wukong signature_method="sha1", domain="#{@app_domain}", signature="#{wukong_sign}", timestamp="#{@timestamp}", nonce="#{@nonce}", version="1.0"),
        'Content_Type'  => 'application/json'
      }
    end
  end
end
