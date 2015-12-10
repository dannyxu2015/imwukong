# Imwukong
:sunny:server APIs for [阿里悟空](https://imwukong.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imwukong'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imwukong

## Usage

### Configuration

```ruby
 Imwukong.configure do |config|
   config = {
     env:     'development',
     domain:  'your-domain',
     android: {
       app_key:    'android_app_key',
       app_secret: 'android_app_secret'
     },
     ios:     {
       app_key:    'ios_app_key',
       app_secret: 'ios_app_secret'
     },
     web:     {
       app_key:    'web_app_key',
       app_secret: 'web_app_secret'
     },
     server:  {
       app_token: 'server_app_token'
     }
   }
 end
```

### API info

```ruby
wk = Imwukong::Base.new
wk.wk_api_list
=> [:wk_api_info, :wk_api_list, :wk_conversation_add_members, :wk_conversation_clear, :wk_conversation_create, :wk_conversation_disband, :wk_conversation_info, :wk_conversation_members, :wk_conversation_page_group_infos, :wk_conversation_page_infos, :wk_conversation_profiles, :wk_conversation_query, :wk_conversation_quit, :wk_conversation_quit_silent, :wk_conversation_remove_members, :wk_conversation_role_list, :wk_conversation_set_top, :wk_conversation_unlimit_infos, :wk_conversation_update_ext, :wk_conversation_update_exts, :wk_conversation_update_icon, :wk_conversation_update_member_limit, :wk_conversation_update_notification, :wk_conversation_update_owner, :wk_conversation_update_status, :wk_conversation_update_super, :wk_conversation_update_tag, :wk_conversation_update_title, :wk_conversations_infos, :wk_conversations_newest, :wk_conversations_unread, :wk_message_query, :wk_message_recall, :wk_message_remove, :wk_message_send, :wk_message_set_read, :wk_message_unread_members, :wk_message_update_ext, :wk_message_update_member, :wk_push_to_user, :wk_relation_bi_follow_list, :wk_relation_follow, :wk_relation_follow_by_list, :wk_relation_follow_list, :wk_relation_list, :wk_relation_query, :wk_relation_unfollow, :wk_user_profile, :wk_user_profiles, :wk_user_update_profile, :wk_user_update_tag]

wk.wk_api_info(:wk_user_profile)
=> ["wk_user_profile, GET v1/user/profile/get, [:openId] "] 
```

### Reserverd extend methods

```ruby
wk_post(api_group, api_url, api_prefix, params)
wk_get(api_group, api_url, api_prefix, params)
# default api_prefix is 'v1/im'

wk.wk_get('user','profile/get','v1',openId:1)
```

### Sample

```ruby
# use default config
wk = Imwukong::Base.new

wk.wk_user_update_profile(avatar: "http://laiwang.wukong.com/tianpeng.png", birthday:651337200000,gender: 1, isActive: true, nick: "u1", nickPinyin: "testpinyin", openid: 1, ver: 1)

wk.wk_user_profile(1)

wk.wk_user_profiles([1,2,3,4])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dannyxu2015/imwukong.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Todo

## API

- [x] user
- [x] conversation
- [x] message
- [x] follow
- [ ] upload
- [x] push

## Client

- [x] client signature






