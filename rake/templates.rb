# frozen_string_literal: true

module ASAAPI
  module Rake
    module Templates
      TEMPLATES_DIR = File.join ASAAPI::Rake::RAKE_DIR, 'templates'

      def self.template(name)
        File.join TEMPLATES_DIR, name
      end
    end
  end
end
