module Imwukong
  module User
  	# wukong API documents: https://imwukong.com/#doc/doc/server/index.htm??用户

  	# @param open_id, integer, unique user identifier of wukong
  	# @return, i.e. {"birthday":651337200000,"nick":"tianpeng","gender":1,"openid":100078,
  	#                "avatar":"http://laiwang.wukong.com/tianfeng.png"} 
  	def profile(open_id)
  		params = {openId: open_id.to_i}
  		wk_get('user', 'profile/get', params)
  	end

  	# @param params, hash
  	# i.e. avatar: "http://laiwang.wukong.com/tianpeng.png", birthday:651337200000,gender: 1, 
  	#      isActive: true, nick: "u1", nickPinyin: "testpinyin", openid: 1, ver: 1
  	def update_profile(params)
  		wk_post('user', 'profile/update', params)
  	end

  	# @param open_ids, array, open ids array
  	# @return user profiles in an array
  	def profiles(open_ids)
  		fail 'Invalid [profiles get] parameters' unless open_ids.is_a?(Array)
  		params = {openIds: open_ids}
  		wk_post('user', 'profiles/get', params)
  	end

  	def update_tag(open_id, tag, op)
  		params = {
  			openId: open_id,
  			tag: tag,
  			op: op
  		}
  		wk_post('user', 'tag/update', params)
  	end

  	
  end
end