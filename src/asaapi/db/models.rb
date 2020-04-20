# frozen_string_literal: true

module ASAAPI
  module Database
    MODELS_DIR = File.join File.dirname(__FILE__), 'models'
  end
end

Dir["#{ASAAPI::Database::MODELS_DIR}/*.rb"].each { |f| require f }
