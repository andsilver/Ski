module Brochures
  extend ActiveSupport::Concern

  included do
    has_many :holiday_type_brochures, dependent: :delete_all, as: :brochurable
    has_many :holiday_types, through: :holiday_type_brochures
  end

  def theme
    holiday_types.first.try(:slug)
  end
end
