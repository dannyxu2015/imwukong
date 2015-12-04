# imwukong
server APIs for imwukong
# Install
gem 'imwukong', github: 'dannyxu2015/imwukong', branch: 'master'
# Usage
wk = Imwukong::Base.new('app_domain','app_token')
wk.update_profile(avatar: "http://laiwang.wukong.com/tianpeng.png", birthday:651337200000,gender: 1, isActive: true, nick: "u1", nickPinyin: "testpinyin", openid: 1, ver: 1)
wk.profile(1)
wk.profiles([1,2,3,4])

