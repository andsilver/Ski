class TrackedAction < ActiveRecord::Base
  enum action_type: {
    click: 0,
  }

  belongs_to :trackable, polymorphic: true
end
