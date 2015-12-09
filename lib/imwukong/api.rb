require 'active_support/core_ext/string'
module Imwukong
  class Base
    API_LIST = [
      {
        method_group: 'user',
        method_name:  'update_profile',
        http_method:  :post,
        prefix:       'v1',
        url:          'profile/update'
      },
      {
        method_group: 'user',
        method_name:  'profile',
        http_method:  :get,
        prefix:       'v1',
        url:          'profile/get',
        params:       [:openId]
      },
      {
        method_group: 'user',
        method_name:  'profiles',
        http_method:  :post,
        prefix:       'v1',
        url:          'profiles/get',
        params:       [:openIds]
      },
      {
        method_group: 'user',
        method_name:  'update_tag',
        http_method:  :post,
        prefix:       'v1',
        url:          'tag/update',
        params:       [:openId, :tag, :op]
      },
      {
        method_group:     'conversation',
        method_name:      'create',
        method_pluralize: false,
        http_method:      :post,
        url:              'create'
      },
      {
        method_group: 'conversation',
        method_name:  'profiles',
        http_method:  :post,
        url:          'profiles/get',
        args:         [:openId, :conversationIds],
      },
      {
        method_group: 'conversation',
        method_name:  'info',
        http_method:  :get,
        url:          'get',
        args:         [:openId, :conversationId],
      },
      {
        method_group:     'conversation',
        method_name:      'infos',
        method_pluralize: true,
        http_method:      :post,
        url:              'get',
        args:             [:openId, :conversationIds],
      },
      {
        method_group: 'conversation',
        method_name:  'unlimit_infos',
        http_method:  :post,
        url:          'unlimited/get',
        args:         [:openId, :conversationId],
      },

    ]

    instance_eval do
      API_LIST.each do |api|
        method_group = api[:method_pluralize] ? api[:method_group].pluralize : api[:method_group]
        method_name  = "wk_#{method_group}_#{api[:method_name]}"
        fail "Method #{method_name} already defined" if respond_to?(method_name)
        define_method method_name do |params|
          check_params(params, api[:args]||[])
          self.send "wk_#{api[:http_method]}", method_group, api[:url], api[:prefix]||'v1/im', params
        end
      end
    end

    WK_API_FORMAT = /^wk_[a-zA-Z0-9]+_[a-zA-Z0-9]+/.freeze
    # output all APIs, format: wk_group_action
    def wk_api_list
      methods.grep(WK_API_FORMAT).sort
    end

    # output arguments info of an api method
    def wk_api_args(api_method)
      fail 'Invalid wukong api' unless api_method =~ WK_API_FORMAT
      m = api_method.to_s.match(/^wk_([a-zA-Z0-9]+)_(.+)/)
      method_group = m[1].singularize
      method_name = m[2]
      # warn method_group + '-->' + method_name
      api = API_LIST.select { |a| a[:method_group]==method_group && method_name==a[:method_name] }.first
      fail 'api not found' unless api.present?
      api[:params]
    end

    private

    def check_params(params, check_list=[])
      check_list.each do |key|
        fail "argument required: #{key}" unless params.has_key?(key) || params.has_key?(key.to_sym)
      end
    end
  end
end
