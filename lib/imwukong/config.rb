module Imwukong

  @config = { env: 'development' }

  class << self
    attr_accessor :config

    def configure
      yield @config if block_given?
    end
  end
end