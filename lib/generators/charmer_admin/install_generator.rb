require 'rails/generators'
require File.expand_path('utils', __dir__)

module CharmerAdmin
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    include Generators::Utils::InstanceMethods

    desc 'CharmerUtils installation generator'

    def install
      rake 'railties:install:migrations FROM=charmer_admin'
      rake 'db:migrate'
      template('admin.rb', 'app/models/admin.rb')
      template('ability.rb', 'app/models/ability.rb')
      template('img_proxy_compose.yml', 'docker-compose.yml')
      template('application_controller.rb', 'app/controllers/application_controller.rb')
      template('api_controller.rb', 'app/controllers/api_controller.rb')
      template('application_record.rb', 'app/models/application_record.rb')
      template('plurals.rb', 'config/locales/plurals.rb')
      template('base_serializer.rb', 'app/serializers/base_serializer.rb')
      template('admin_serializer.rb', 'app/serializers/admin_serializer.rb')
      template('seeds.rb', 'db/seeds.rb')
      template('relation_generator.rb', 'lib/generators/relation_generator.rb')
    end
  end
end
