# frozen_string_literal: true

require 'sinatra/base'

RESOURCES_DIR = '%<root>s/resources'

module ASAAPI
  class App < Sinatra::Application
    helpers do
      def send_resource(path)
        res_dir = RESOURCES_DIR % {root: settings.root}

        send_file File.join(res_dir, path)
      end

      def load_resource(path)
        res_dir = RESOURCES_DIR % {root: settings.root}

        IO.read File.join(res_dir, path)
      end
    end
  end
end
