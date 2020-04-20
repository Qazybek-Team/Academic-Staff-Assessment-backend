# frozen_string_literal: true

require 'sequel'
require_relative '../config'

module ASAAPI
  module Database
    DB_CONFIG = Config.db.current

    DB = Sequel.connect DB_CONFIG
  end
end
