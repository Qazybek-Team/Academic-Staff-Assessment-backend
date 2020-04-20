# frozen_string_literal: true

require_relative '../database'
require_relative 'user'

module ASAAPI
  module Database
    class TeachingUnit < Sequel::Model
      many_to_one :teacher, class: Database::User
      many_to_one :course
      many_to_one :template
    end
  end
end
