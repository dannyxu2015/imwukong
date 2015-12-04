require 'httparty'
require 'digest'

module Imwukong

  @config = { env: 'development' }

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

    def initialize(app_domain, app_token)
      raise 'app domain/token is invalid' unless app_domain.is_a?(String) && app_token.is_a?(String) && app_domain.present? && app_token.present?
      @app_domain = app_domain.strip
      @app_token  = app_token.strip
      @options    = DEFAULT_OPTIONS
    end

    def wk_post(type, method, params)
      options = {
        body:    params.to_json,
        headers: wukong_header
      }
      result = self.class.send(:post, get_request_url(type, method), options) rescue nil

      # Fixme: Error handler
      fail 'No respond from server' if result.nil?
      warn ">>> Code: #{result.code}, " + result.inspect
      r = result.parsed_response
      fail result.inspect unless result.code == 200
      fail "#{r['errorCode']}, #{r['errorMessage']}" if r['success'] == false
      r['data']
    end

    def wk_get(type, method, params)
      options = {
        query:   params,
        headers: wukong_header
      }
      result = self.class.send(:get, get_request_url(type, method), options) rescue nil

      # Fixme: Error handler
      fail 'No respond from server' if result.nil?
      warn ">>> Code: #{result.code}, " + result.inspect
      r = result.parsed_response
      fail result.inspect unless result.code == 200
      fail "#{r['errorCode']}, #{r['errorMessage']}" if r['success'] == false
      r['data']
    end

    # def safe_json_parse(data)
    #   warn data.inspect
    #   JSON.parse(data)
    #     # rescue TypeError which will cause 'no implicit conversion of HTTParty::Response into String'
    # rescue JSON::ParserError, TypeError
    #   {}
    # end

    private
    
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
      sign       = Digest::SHA1.hexdigest(array.join)
      warn "Sign: #{sign}"
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
