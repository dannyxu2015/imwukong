# Imwukong
:sunny:server APIs for [阿里悟空](https://imwukong.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imwukong', github: 'dannyxu2015/imwukong', branch: 'master'
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
### Sample
```ruby
# use default config
wk = Imwukong::Base.new

wk.update_profile(avatar: "http://laiwang.wukong.com/tianpeng.png", birthday:651337200000,gender: 1, isActive: true, nick: "u1", nickPinyin: "testpinyin", openid: 1, ver: 1)

wk.profile(1)

wk.profiles([1,2,3,4])
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






