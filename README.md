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

```ruby
wk = Imwukong::Base.new('*app_domain*','*app_token*')

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
- [x] user APIs
- [x] session APIs
- [ ] message APIs
- [ ] follow APIs
- [ ] upload APIs
- [ ] push APIs






