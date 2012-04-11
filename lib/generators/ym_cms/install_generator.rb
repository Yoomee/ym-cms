module YmCms
  module Generators    
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      desc "Installs YmCms."

      def manifest
        copy_file "models/page.rb", "app/models/page.rb"
        copy_file "models/snippet.rb", "app/models/snippet.rb"
        copy_file "controllers/pages_controller.rb", "app/controllers/pages_controller.rb"
        if File.exists?("#{Rails.root}/app/models/ability.rb")
          insert_into_file "app/models/ability.rb", "      can :show, Page, :published => true\n", :after => "can :manage, User, :id => user.id\n"
          insert_into_file "app/models/ability.rb", "      can :show, Page, :published => true\n      cannot [:mercury_update], Page\n", :after => "cannot [:create, :update, :destroy], :all\n"
        end
        
        try_migration_template "migrations/create_pages.rb", "db/migrate/create_pages"
        try_migration_template "migrations/add_short_title_to_pages.rb", "db/migrate/add_short_title_to_pages"
        try_migration_template "migrations/create_snippets.rb", "db/migrate/create_snippets"
      end
      
      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end
      
      private
      def try_migration_template(source, destination)
        begin
          migration_template source, destination
        rescue Rails::Generators::Error => e
          puts e
        end
      end
      
    end
  end
end
