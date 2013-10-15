class CreatePages < ActiveRecord::Migration
  
  def change
    create_table :pages do |t|
      t.integer :parent_id
      t.integer :user_id
      t.string :slug
      t.string :title
      t.string :short_title
      t.text :text
      t.text :call_to_action
      t.text :pull_quote
      t.text :meta_description
      t.text :meta_keywords
      t.text :html_title
      t.boolean :published, :default => false
      t.integer :position
      t.string :view_name, :default => "basic"
      t.string :image_uid
      t.date :publication_date
      t.boolean :draft, :default => false
      t.boolean :delta, :default => true, :null => false
      t.timestamps
    end
    add_index :pages, :parent_id
    add_index :pages, :user_id
  end
  
end