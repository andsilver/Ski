class TrackedAction < ActiveRecord::Base
  enum action_type: {
    click: 0
  }
end
