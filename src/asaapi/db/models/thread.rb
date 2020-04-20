# frozen_string_literal: true

require_relative '../database'

module ASAAPI
  module Database
    class Thread < Sequel::Model
      many_to_many :users
    end
  end
end
