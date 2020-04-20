# frozen_string_literal: true

require_relative '../../jsonrpc/sinatra_helper'

module ASAAPI
  class App < Sinatra::Application
    class << self
      include RPC::SinatraHelper
    end
  end
end
