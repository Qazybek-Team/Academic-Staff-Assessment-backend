# frozen_string_literal: true

require_relative '../database'

module ASAAPI
  module Database
    class Question < Sequel::Model
      many_to_one :template

      one_to_many :answers
    end
  end
end
