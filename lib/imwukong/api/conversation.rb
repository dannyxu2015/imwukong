module Imwukong
  module Api
    module Conversation
      # refer to: https://imwukong.com/#doc/doc/server/index.htm??聊天会话
      CONVERSATION = 'conversation'.freeze

      # # Todo: DSL to implement apis
      # CONVERSATION_API = [
      #   {
      #     method_name: 'create',
      #     http_method: :post,
      #     url: 'create',
      #     args: params,
      #   },
      # ]
      #
      # instance_eval do
      #   CONVERSATION_API.each do |api|
      #     define_method api[:method_name].to_sym do |params|
      #       self.send "wk_#{api[:http_method]}", api[:url], api[:args]
      #     end
      #   end
      # end

      # 创建会话
      def create(params)
        wk_post(CONVERSATION, 'create', params)
      end

      # 查询会话概要信息
      def profiles(open_id, conversation_ids)
        params = {
          openId:          open_id,
          conversationIds: conversation_ids
        }
        wk_post(CONVERSATION, 'profiles/get', params)
      end

      # 查询会话信息(包括会话最近的消息和消息状态)
      def info(open_id, conversation_id)
        params = {
          openId:         open_id,
          conversationId: conversation_id
        }
        wk_post(CONVERSATION, 'get', params)
      end

      # 批量查询会话信息(包括会话最近的消息和消息状态)
      def infos(open_id, conversation_ids)
        params = {
          openId:          open_id,
          conversationIds: conversation_ids
        }
        # what a weired thing ~
        wk_post(CONVERSATION+'s', 'get', params)
      end

      # 无条件查询会话信息，首屏删除也可以取得(包括会话最近的消息和消息状态)
      def unlimit_infos(open_id, conversation_id)
        params = {
          openId:         open_id,
          conversationId: conversation_id
        }
        wk_post(CONVERSATION, 'unlimited/get', params)
      end

      # 分页查询群聊会话列表
      # @param open_id, integer, 用户id
      # @param cursor, integer, 会话时间戳起始时间，第一次取值为0,之后取最后一个会话的createAt值
      # @oaram count, 每次拉取的会话个数
      def page_group_infos(open_id, cursor, count)
        params = {
          openId: open_id,
          cursor: cursor,
          count:  count
        }
        wk_get(CONVERSATION, 'groups/get', params)
      end

      def page_infos(open_id, cursor, count)
        params = {
          openId: open_id,
          cursor: cursor,
          count:  count
        }
        wk_get(CONVERSATION+'s', 'list', params)
      end

      def add_member(open_id, cid, members, message)
        params = {
          openId: open_id,
          conversationId: cid,
          members: members,
          message: message
        }
        wk_post(CONVERSATION, 'member/add', params)
      end

      def remove_member(open_id, cid, members, message)
        params = {
          openId: open_id,
          conversationId: cid,
          members: members,
          message: message
        }
        wk_post(CONVERSATION, 'member/remove', params)
      end

      def update_tag(open_id, cid, tag)
        params = {
          openId: open_id,
          conversationId: cid,
          tag: tag
        }
        wk_post(CONVERSATION, 'tag/update', params)
      end
    end
  end
end