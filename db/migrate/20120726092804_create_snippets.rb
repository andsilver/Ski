class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name, default: '', null: false
      t.text :snippet

      t.timestamps
    end

    add_index :snippets, :name
  end
end
