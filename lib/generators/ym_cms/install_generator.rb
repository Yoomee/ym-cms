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
        if should_add_abilities?('Page')
          add_ability(:open, "can :show, Page, :draft => false")
        end
        
        try_migration_template "migrations/create_pages.rb", "db/migrate/create_pages"
        try_migration_template "migrations/add_short_title_to_pages.rb", "db/migrate/add_short_title_to_pages"
        try_migration_template "migrations/add_user_id_to_pages.rb", "db/migrate/add_user_id_to_pages"
        try_migration_template "migrations/create_snippets.rb", "db/migrate/create_snippets"
        try_migration_template "migrations/add_published_at_to_pages.rb", "db/migrate/add_published_at_to_pages"
        try_migration_template "migrations/replace_published_at_with_draft_in_pages.rb", "db/migrate/replace_published_at_with_draft_in_pages"        
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

      def should_add_abilities?(model_name)
        File.exists?("#{Rails.root}/app/models/ability.rb") && !File.open("#{Rails.root}/app/models/ability.rb").read.include?(model_name)
      end

      def add_ability(roles, abilities)
        [*roles].each do |role|
          tabbed_space = role==:open ? "\n    " : "\n      "
          ability_string = tabbed_space + [*abilities].join(tabbed_space)
          insert_into_file "app/models/ability.rb", ability_string, :after => "#{role} ability", :force => true
        end
      end
      
    end
  end
end
