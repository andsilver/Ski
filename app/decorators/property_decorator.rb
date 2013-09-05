class PropertyDecorator < Draper::Decorator
  delegate_all

  def nearest_lift
    metres_from_lift == 1001 ? '> 1km' : "#{metres_from_lift}m"
  end
end
