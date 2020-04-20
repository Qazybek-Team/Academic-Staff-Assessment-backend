# frozen_string_literal: true

require_relative '../database'

module ASAAPI
  module Database
    class Role < Sequel::Model
      many_to_one :user
    end
  end
end
