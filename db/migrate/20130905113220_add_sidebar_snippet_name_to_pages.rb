class AddSidebarSnippetNameToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sidebar_snippet_name, :string
  end
end
