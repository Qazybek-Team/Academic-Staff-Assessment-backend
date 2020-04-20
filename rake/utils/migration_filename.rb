# frozen_string_literal: true

require 'date'
require 'active_support/core_ext/string'

module ASAAPI
  module Rake
    module Utils
      RB_EXT = 'rb'
      MIGRATIONS_DIR = File.join ASAAPI::Rake::RAKE_DIR, '..', 'migrations'

      def self.migration_filename(migration_name)
        parts = migration_name.underscore.split(/[\s]+/)
        version = Time.now.to_i

        filename = [version, *parts].join '_'

        filename = [filename, RB_EXT].join '.'

        File.absolute_path File.join(MIGRATIONS_DIR, filename)
      end
    end
  end
end
