class AddLocaleToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :locale, :string, default: 'en', null: false
  end
end
