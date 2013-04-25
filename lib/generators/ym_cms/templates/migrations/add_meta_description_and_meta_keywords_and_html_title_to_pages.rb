class AddMetaDescriptionAndMetaKeywordsAndHtmlTitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :meta_description, :text
    add_column :pages, :meta_keywords, :text
    add_column :pages, :html_title, :string
  end
end
