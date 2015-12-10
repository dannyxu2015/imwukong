require 'spec_helper'

describe Imwukong do
  it 'has a version number' do
    expect(Imwukong::VERSION).not_to be nil
  end

  it 'new an Imwukong object' do
    expect(Imwukong::Base.new('test-sjll', 'SpBzEmucvdmCYbzHJJ0js7MhVIlJsm00')).to be_a(Imwukong::Base)
  end

  it 'get api list' do
    wk = Imwukong::Base.new('test-sjll', 'SpBzEmucvdmCYbzHJJ0js7MhVIlJsm00')
    expect(wk.wk_api_list).to be_a_kind_of(Array)
  end

  it 'update a user profile and get updated profile' do
    wk = Imwukong::Base.new('test-sjll', 'SpBzEmucvdmCYbzHJJ0js7MhVIlJsm00')
    h  = wk.wk_user_update_profile(openid: 9, nick: '测试', ver: '1', city: '上海', extension: { special: 'test' })
    expect(h).to eq('')
    h = wk.wk_user_profile(openId: 9)
    expect(h['nick']).to eq('测试')
  end

  context 'Client test' do
    it 'ios client' do
      expect(Imwukong::Client.new.signature(1, 'ios')).to be_a(Hash)
    end
    it 'android client' do
      expect(Imwukong::Client.new.signature(1, 'android')).to be_a(Hash)
    end
    # Fixme, anyway, it's unknown ~
    # it 'unknown client' do
    #   expect(Imwukong::Client.new.signature(1, 'unknown')).to raise_error
    # end
  end
end
