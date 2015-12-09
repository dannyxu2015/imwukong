module Imwukong
  # implement 阿里悟空支持的免导入登录方式
  # 根据客户端类型(ios, android, web)返回 signature、domain、appkey、timestamp 等数据给客户端
  # 客户端调用阿里悟空的SDK接口完成登录鉴权
  # 目前采用openid就是用户应用的userid, 其唯一性由用户应用系统保障
  class Client
    def signature()

    end
  end
end