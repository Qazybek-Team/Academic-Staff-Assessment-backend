# frozen_string_literal: true

require_relative '../database'

module ASAAPI
  module Database
    class User < Sequel::Model
      many_to_many :threads
      one_to_many :roles
    end
  end
end
