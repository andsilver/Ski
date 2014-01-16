class AddHeaderSnippetNameToPages < ActiveRecord::Migration
  def change
    add_column :pages, :header_snippet_name, :string
  end
end
