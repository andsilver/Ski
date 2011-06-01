class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path, :null => false
      t.string :title, :null => false
      t.string :description, :default => '', :null => false
      t.string :keywords, :default => '', :null => false

      t.timestamps
    end

    add_index :pages, :path
  end
end
