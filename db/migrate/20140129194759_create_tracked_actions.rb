class CreateTrackedActions < ActiveRecord::Migration
  def change
    create_table :tracked_actions do |t|
      t.string :remote_ip, default: '', null: false
      t.references :trackable, polymorphic: true, null: false
      t.integer :action_type, null: false
      t.string :http_user_agent, default: '', null: false

      t.timestamps
    end

    add_index :tracked_actions, :trackable_id
    add_index :tracked_actions, [:trackable_id, :action_type]
    add_index :tracked_actions, :created_at
  end
end
