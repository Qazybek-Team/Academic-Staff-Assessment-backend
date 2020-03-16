# frozen_string_literal: true

module ASAAPI
  DB = Sequel.connect Config.db.current
end
