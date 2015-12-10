require 'digest/sha2'
module Imwukong
  # implement 阿里悟空支持的免导入登录方式
  # 根据客户端类型(ios, android, web)返回 signature、domain、appkey、timestamp 等数据给客户端
  # 客户端调用阿里悟空的SDK接口完成登录鉴权
  # 目前采用openid就是用户应用的userid, 其唯一性由用户应用系统保障
  class Client
    def signature(open_id, dev_type)
      fail %Q(unknown device type "#{dev_type}") unless %w(ios android).include?(dev_type)
      begin
        app_token  = Imwukong.config[:server][:app_token]
        app_key    = Imwukong.config[dev_type.to_sym][:app_key]
        app_secret = Imwukong.config[dev_type.to_sym][:app_secret]
      rescue
        raise 'Please check you configuration of imwukong'
      end
      nonce     = rand(100000..200000)
      timestamp = Time.now.to_i
      {
        signature: gen_signature(open_id, app_token, app_secret, nonce, timestamp),
        domain:    Imwukong.config[:domain],
        open_id:   open_id,
        app_key:   app_key,
        nonce:     nonce,
        timestamp: timestamp
      }
    end

    private

    def gen_signature(open_id, app_token, app_secret, nonce, timestamp)
      Digest::SHA256.hexdigest([app_token, app_secret, open_id.to_s, nonce.to_s, timestamp.to_s].sort.join(''))
    end
  end
end