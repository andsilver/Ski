# frozen_string_literal: true

class RenameWindowToWindowSpot < ActiveRecord::Migration[5.1]
  def change
    rename_column :adverts, :window, :window_spot
  end
end
