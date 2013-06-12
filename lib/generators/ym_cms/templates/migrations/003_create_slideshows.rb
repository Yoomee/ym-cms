class CreateSlideshows < ActiveRecord::Migration
  
  def change
    create_table :slideshows do |t|
      t.belongs_to :attachable, :polymorphic => true
      t.string :slug
      t.timestamps
    end
    add_index :slideshows, [:attachable_type, :attachable_id]
    add_index :slideshows, :slug
  end
  
end