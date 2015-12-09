module Imwukong

  @config = {
    env:     'development',
    domain:  'test-sjll',
    android: {
      app_key:    'c3a2bdb574663c955f5bceeb95ad4eec',
      app_secret: 'Snnmp8aepflORdsWdTjuNLXHPv4FpJki'
    },
    ios:     {
      app_key:    '1f49803aa33122c8ed11df493f8d843f',
      app_secret: 'Sn0NwAYBIeUT8DPoR9IP9hhqTD1SBf0o'
    },
    web:     {
      app_key:    'c26cf651de1ef9f583677e73271c7396',
      app_secret: 'S0Iq3cBlJd91v0VvwiqziYmQx5hcsdIV'
    },
    server:  {
      app_token: 'SpBzEmucvdmCYbzHJJ0js7MhVIlJsm00'
    }
  }

  class << self
    attr_accessor :config

    def configure
      yield @config if block_given?
    end
  end
end