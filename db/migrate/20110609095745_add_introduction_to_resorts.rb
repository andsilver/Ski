class AddIntroductionToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :introduction, :text, :default => ''
  end
end
