# frozen_string_literal: true

require_relative 'rake/rake'

include ASAAPI::Rake

namespace :db do
  namespace :migrations do
    desc 'Create new migration'
    task :new, %i[name] do |_, args|
      fn = Utils.migration_filename args[:name]
      tmpl = Templates.template 'migration.rb'

      cp tmpl, fn
    end
  end
end
