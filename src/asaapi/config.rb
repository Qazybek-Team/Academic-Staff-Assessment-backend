# frozen_string_literal: true

require 'mustache'
require 'yaml'

CONFIG_DIR = 'config'

module ASAAPI
  class Config
    class << self
      def db
        fpath = File.join ASAAPI_APP_ROOT, CONFIG_DIR, 'db.yml'

        @db_config ||= Config.new fpath
      end

      def credentials
        fpath = File.join ASAAPI_APP_ROOT, CONFIG_DIR, 'credentials.yml'

        @cred_config ||= Config.new fpath
      end
    end

    def initialize(path)
      @config = YAML.load(
        Mustache.render(
          IO.read(path),
          config_context
        )
      )
    end

    def current()
      env = ENV['RACK_ENV'] || 'development'

      self[env]
    end

    def [](env)
      @config[env]
    end

    private

    def config_context
      {
        app: {
          root: ASAAPI_APP_ROOT
        },
        env: ENV
      }

    end
  end
end
