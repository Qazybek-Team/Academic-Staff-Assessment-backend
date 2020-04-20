# frozen_string_literal: true

require_relative '../database'

module ASAAPI
  module Database
    class Course < Sequel::Model
      many_to_one :form
      many_to_one :question
    end
  end
end
