class FlipKeyLocation < ActiveRecord::Base
  acts_as_tree

  belongs_to :resort

  # Sets the resort ID for this location and all children recursively.
  def cascade_resort_id=(resort_id)
    self.resort_id = resort_id
    save
    children.each {|c| c.cascade_resort_id = resort_id}
  end
end
