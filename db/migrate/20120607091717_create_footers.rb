class CreateFooters < ActiveRecord::Migration
  def change
    create_table :footers do |t|
      t.string :name, null: false
      t.text :content

      t.timestamps
    end

    add_index :footers, :name
  end
end
