# frozen_string_literal: true

require_relative '../database'
require_relative 'user'

module ASAAPI
  module Database
    class Message < Sequel::Model
      many_to_one :thread
      many_to_one :author, class: User
    end
  end
end
