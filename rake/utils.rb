module ASAAPI
  module Rake
    module Utils
      UTILS_DIR = File.join ASAAPI::Rake::RAKE_DIR, 'utils'
    end
  end
end

Dir["#{ASAAPI::Rake::Utils::UTILS_DIR}/*.rb"].each { |f| require f }