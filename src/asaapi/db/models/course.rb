# frozen_string_literal: true

require_relative '../database'
require_relative 'teaching_unit'

module ASAAPI
  module Database
    class Course < Sequel::Model
      one_to_one :lecture, class: TeachingUnit
      one_to_one :tutorial, class: TeachingUnit
      one_to_many :labs, class: TeachingUnit

      one_to_many :forms
    end
  end
end
