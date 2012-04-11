module YmCms
  module Generators
    class SlideshowsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)
      desc "Installs slideshows."

      def manifest
        copy_file "models/slide.rb", "app/models/slide.rb"
        copy_file "models/slideshow.rb", "app/models/slideshow.rb"
        copy_file "controllers/slideshows_controller.rb", "app/controllers/slideshows_controller.rb"
        migration_template "migrations/create_slideshows.rb", "db/migrate/create_slideshows"
        migration_template "migrations/create_slides.rb", "db/migrate/create_slides"
      end
      
      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end
      
    end
  end
end
