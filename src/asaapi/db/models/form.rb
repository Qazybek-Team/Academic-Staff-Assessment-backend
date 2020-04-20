# frozen_string_literal: true

require_relative '../database'
require_relative 'user'

module ASAAPI
  module Database
    class Form < Sequel::Model
      many_to_one :template

      many_to_one :target, class: TeachingUnit
      many_to_one :author, class: User

      one_to_many :answers
    end
  end
end
