class AddIntroductionToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :introduction, :text
  end
end
