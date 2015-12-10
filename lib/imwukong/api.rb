require 'active_support/core_ext/string'
module Imwukong
  class Base
    STATUS_FOLLOW = 0 # 关注
    STATUS_FOLLOW_BY = 1 # 被关注
    STATUS_BI_FOLLOW = 2 # 双向关系

    API_LIST = [
      # 用户
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
        args:       [:openId]
      },
      {
        method_group: 'user',
        method_name:  'profiles',
        http_method:  :post,
        prefix:       'v1',
        url:          'profiles/get',
        args:       [:openIds]
      },
      {
        method_group: 'user',
        method_name:  'update_tag',
        http_method:  :post,
        prefix:       'v1',
        url:          'tag/update',
        args:       [:openId, :tag, :op]
      },

      # 聊天会话
      {
        # 创建聊天会话
        method_group:     'conversation',
        method_name:      'create',
        method_pluralize: false,
        http_method:      :post,
        url:              'create'
      },
      {
        # 查询聊天会话的概要信息
        method_group: 'conversation',
        method_name:  'profiles',
        http_method:  :post,
        url:          'profiles/get',
        args:         [:openId, :conversationIds]
      },
      {
        # 查询会话信息(包括会话最近的消息和消息状态)
        method_group: 'conversation',
        method_name:  'info',
        http_method:  :get,
        url:          'get',
        args:         [:openId, :conversationId]
      },
      {
        # 批量查询会话信息(包括会话最近的消息和消息状态)
        method_group:     'conversation',
        method_name:      'infos',
        method_pluralize: true,
        http_method:      :post,
        url:              'get',
        args:             [:openId, :conversationIds]
      },
      {
        # 无条件查询会话信息，首屏删除也可以取得(包括会话最近的消息和消息状态)
        method_group: 'conversation',
        method_name:  'unlimit_infos',
        http_method:  :post,
        url:          'unlimited/get',
        args:         [:openId, :conversationId]
      },
      {
        # 分页查询用户的群聊会话列表
        method_group: 'conversation',
        method_name:  'page_group_infos',
        http_method:  :get,
        url:          'groups/get',
        args:         [:openId, :cursor, :count]
      },
      {
        # 分页查询用户的会话列表
        method_group: 'conversation',
        method_name:  'page_infos',
        http_method:  :get,
        url:          'list',
        args:         [:openId, :cursor, :count]
      },
      {
        # 增加会话成员
        method_group: 'conversation',
        method_name:  'add_members',
        http_method:  :post,
        url:          'member/add',
        args:         [:openId, :conversationId, :members, :message]
      },
      {
        # 群主删除会话成员
        method_group: 'conversation',
        method_name:  'remove_members',
        http_method:  :post,
        url:          'member/remove',
        args:         [:openId, :conversationId, :members, :message]
      },
      {
        # 修改群聊会话tag,用于通知会话信息发生变化
        method_group: 'conversation',
        method_name:  'update_tag',
        http_method:  :post,
        url:          'tag/update',
        args:         [:openId, :conversationId, :tag]
      },
      {
        # 修改群聊会话自定义扩展字段extension
        method_group: 'conversation',
        method_name:  'update_ext',
        http_method:  :post,
        url:          'extension/update',
        args:         [:openId, :conversationId, :extension]
      },
      {
        # 修改会话名称
        method_group: 'conversation',
        method_name:  'update_title',
        http_method:  :post,
        url:          'title/update',
        args:         [:openId, :conversationId, :extension]
      },
      {
        # 修改会话头像
        method_group: 'conversation',
        method_name:  'update_icon',
        http_method:  :post,
        url:          'icon/update',
        args:         [:openId, :conversationId, :newIcon, :message]
      },
      {
        # 修改XPN状态
        method_group: 'conversation',
        method_name:  'update_notification',
        http_method:  :post,
        url:          'notification/update',
        # status 0 接收通知, 1 不接收通知
        args:         [:openId, :conversationId, :status]
      },
      {
        # 解散群聊会话
        method_group: 'conversation',
        method_name:  'disband',
        http_method:  :post,
        url:          'disband',
        args:         [:openId, :conversationId]
      },
      {
        # 查询有未读消息的会话
        method_group:     'conversation',
        method_pluralize: true,
        method_name:      'unread',
        http_method:      :get,
        url:              'unread',
        args:             [:openId, :cursor, :count]
      },
      {
        # 查询会话成员列表
        method_group: 'conversation',
        method_name:  'members',
        http_method:  :get,
        url:          'members/get',
        args:         [:openId, :conversationId, :offset, :count]
      },
      {
        # 修改会话最大人数
        method_group: 'conversation',
        method_name:  'update_member_limit',
        http_method:  :post,
        url:          'member/limit/update',
        args:         [:openId, :conversationId, :memberLimit]
      },
      {
        # 修改会话为大群
        method_group: 'conversation',
        method_name:  'update_super',
        http_method:  :post,
        url:          'member/super/update',
        args:         [:openId, :conversationId, :superGroup]
      },
      {
        # 成员主动退出会话
        method_group: 'conversation',
        method_name:  'quit',
        http_method:  :post,
        url:          'quit',
        args:         [:openId, :conversationId, :message]
      },
      {
        # 会话成员主动退出会话，只给群主发消息
        method_group: 'conversation',
        method_name:  'quit_silent',
        http_method:  :post,
        url:          'quit/silent',
        args:         [:openId, :conversationId, :message]
      },
      {
        # 查询会话成员角色。角色的取值 1是群主，3 普通用户。返回data为空表示不是群成员
        method_group: 'conversation',
        method_name:  'role_list',
        http_method:  :post,
        url:          'list/role',
        args:         [:openId, :conversationId, :message]
      },
      {
        # 修改会话群主
        method_group: 'conversation',
        method_name:  'update_owner',
        http_method:  :post,
        url:          'owner/update',
        args:         [:openId, :conversationId, :message]
      },
      {
        # 查询最新的会话列表
        method_group: 'conversation',
        method_pluralize: true,
        method_name:  'newest',
        http_method:  :get,
        url:          'newest/get',
        args:         [:openId, :count]
      },
      {
        # 清空会话消息
        method_group: 'conversation',
        method_name:  'clear',
        http_method:  :post,
        url:          'message/clear',
        args:         [:openId, :conversationId]
      },
      {
        # 会话置顶
        method_group: 'conversation',
        method_name:  'set_top',
        http_method:  :post,
        url:          'top/set',
        args:         [:openId, :conversationId, :toTop]
      },
      {
        # 修改会话状态
        method_group: 'conversation',
        method_name:  'update_status',
        http_method:  :post,
        url:          'status/update',
        args:         [:openId, :conversationIds, :status]
      },
      {
        # 修改会话扩展信息的特定属性
        method_group: 'conversation',
        method_name:  'update_exts',
        http_method:  :post,
        url:          'extension/keys/update',
        args:         [:openId, :conversationIds, :extension]
      },

      # 聊天消息
      {
        # 向会话中发送消息,目前支持文字消息、图片消息、语音消息、语音图片消息、 文件消息、自定义消息。
        # 文本消息是直接发送
        # 图片、语音、文件等多媒体类型消息则是先上传文件然后再发送message
        method_group: 'message',
        method_name:  'send',
        http_method:  :post,
        url:          'send',
        # content封装不同的消息内容,具体json格式参阅 https://imwukong.com/#doc/doc/server/index.htm??聊天消息
        args:         [:senderId, :conversationId, :receivers, :msgType, :content,
                       :extension, :tag, :XpnParam, :priority]
      },
      {
        # 查询单条消息
        method_group: 'message',
        method_name:  'query',
        http_method:  :get,
        url:          'query',
        args:         [:openId, :messageId]
      },
      {
        # 其实应该属于'聊天会话'分组, 悟空文档这样放, 就这样放吧 ~
        # 查询会话的消息
        method_group: 'conversation',
        method_name:  'query',
        http_method:  :get,
        url:          'messages/query',
        args:         [:openId, :conversationId, :cursor, :forward, :count]
      },
      {
        # 设置消息为已读状态
        method_group: 'message',
        method_name:  'set_read',
        http_method:  :post,
        url:          'set/read',
        args:         [:openId, :messageIds]
      },
      {
        # 消息撤回
        method_group: 'message',
        method_name:  'recall',
        http_method:  :post,
        url:          'recall',
        args:         [:openId, :messageId]
      },
      # 暂未开通
      # {
      #   # 短信邮件发送消息
      #   # 会话好友没有安装应用时，可以通过短信邮件发送聊天消息
      #   method_group: 'message',
      #   method_name:  'sms',
      #   http_method:  :post,
      #   url:          'sms/notice',
      #   args:         [:openId, :openIds, :contacts, :conversationId, :type]
      # },
      {
        # 获取一条消息未读人的列表
        method_group: 'message',
        method_name:  'unread_members',
        http_method:  :get,
        url:          'member/unread',
        args:         [:openId, :messageId]
      },
      {
        # 删除消息
        method_group: 'message',
        method_name:  'remove',
        http_method:  :post,
        url:          'remove',
        args:         [:openId, :messageIds]
      },
      {
        # 修改用户消息的私有tag和扩展信息
        method_group: 'message',
        method_name:  'update_member',
        http_method:  :post,
        url:          'member/update',
        args:         [:openId, :messageId, :receiverIds, :tag, :extension]
      },
      {
        # 修改消息的扩展信息
        method_group: 'message',
        method_name:  'update_ext',
        http_method:  :post,
        url:          'ext/update',
        args:         [:openId, :messageId, :extension]
      },

      # 关注
      {
        # 加关注
        method_group: 'relation',
        method_name:  'follow',
        http_method:  :post,
        url:          'status/follow',
        args:         [:myOpenId, :tag, :openId]
      },
      {
        # 取消关注
        method_group: 'relation',
        method_name:  'unfollow',
        http_method:  :post,
        url:          'status/unfollow',
        args:         [:myOpenId, :tag, :openId]
      },
      {
        # 分页获取自己的关注列表
        method_group: 'relation',
        method_name:  'follow_list',
        http_method:  :get,
        url:          'following/query',
        # cursor, 第一次查询是0 ，后续查询取返回的nextCursor, nextCursor为-1表示无更多数据
        args:         [:openId, :tag, :cursor,:count]
      },
      {
        # 分页获取双向关注列表
        method_group: 'relation',
        method_name:  'bi_follow_list',
        http_method:  :get,
        url:          'binfollow/query',
        args:         [:openId, :tag, :cursor,:count]
      },
      {
        # 分页获取关注自己的人的列表
        method_group: 'relation',
        method_name:  'follow_by_list',
        http_method:  :get,
        url:          'followers/query',
        args:         [:openId, :tag, :cursor,:count]
      },
      {
        # 获取自己与其他用户的关系
        method_group: 'relation',
        method_name:  'query',
        http_method:  :get,
        url:          'status/query',
        args:         [:myOpenId, :tag, :peerOpenId]
      },
      {
        # 分页获取关注和被关注列表
        method_group: 'relation',
        method_name:  'list',
        http_method:  :get,
        url:          'all/query',
        args:         [:openId, :tag, :cursor,:count]
      },


      # 推送
      {
        # 修改会话扩展信息的特定属性
        method_group: 'push',
        prefix: 'v1',
        method_name:  'to_user',
        http_method:  :post,
        url:          'message/user',
        # NotifyDataModel, 用户不在线的情况下，通过IOS APN、华为、小米通道下发的消息内容, 长度不超过256字节
        # {
        #   alertContent 可选，推送到APN的内容,适用于华为、小米、IOS设备。 string
        #   badge 可选，app角标的增量数字，适用于IOS。 integer
        #   params 可选, 自定义传输参数， key-value列表,key和value都为字符串类型，适用于IOS json map对象
        #   sound 可选，推送消息提醒声音，应用中的音频资源名，支持aiff、wav、caf格式，适用于IOS。 string
        #   timeToLive 可选，APN保持持续时间，单位秒，适用于IOS，建议不要设置，使用默认的值。 integer
        # }
        # PushDataModel, 通过悟空PUSH长连接发下去的消息
        # {
        #   content 消息内容。不能为空 string
        #   toWeb 可选，是否只推送到web。默认是false,推送到所有终端，包括web。 boolean
        #   type 用户定义的消息类型。 integer
        #   persist 是否持久化存储,默认为持久化存储。 boolean
        # }
        args:         [:receiverId, :NotifyModel, :PushModel]
      }
        # 多个用户消息推送, 暂未开放
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

    # api detail info, include request url & arguments
    # @param api_method, string, default output information of all api
    # @return an array of match api info string, format: api_name, REQUEST url, arguments symbol array
    def wk_api_info(api_method='')
      api_method ||= ''
      fail 'Invalid wukong api' unless api_method == '' || api_method =~ WK_API_FORMAT
      if api_method.size > 0
        m            = api_method.to_s.match(/^wk_([a-zA-Z0-9]+)_(.+)/)
        method_group = m[1].singularize
        method_name  = m[2]
      end
      apis = api_method.size > 0 ? API_LIST.select { |a| a[:method_group]==method_group && method_name==a[:method_name] } : API_LIST
      fail 'api not found' unless apis.present?
      apis.map do |api|
        method_group = api[:method_pluralize] ? api[:method_group].pluralize : api[:method_group]
        method_name  = "wk_#{method_group}_#{api[:method_name]}"
        "#{method_name}, #{api_url(api)}, #{api[:args].inspect} "
      end
    end

    private

    def api_url(api)
      http_method = api[:http_method].to_s.upcase
      prefix      = api[:prefix] ? api[:prefix] : 'v1/im'
      group       = api[:method_pluralize] ? api[:method_group].pluralize : api[:method_group]
      url         = "#{prefix}/#{group}/#{api[:url]}"
      "#{http_method} #{url}"
    end

    def check_params(params, check_list=[])
      check_list.each do |key|
        fail "argument required: #{key}" unless params.has_key?(key) || params.has_key?(key.to_sym)
      end
    end
  end
end
