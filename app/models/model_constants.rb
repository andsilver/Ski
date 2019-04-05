module ModelConstants
  FLAT_NAMESPACE_SLUG_FORMAT = /\A[-a-z0-9]+\z/
  FLAT_NAMESPACE_SLUG_VALIDATIONS = {
    presence: true,
    uniqueness: true,
    format: ModelConstants::FLAT_NAMESPACE_SLUG_FORMAT,
  }.freeze
end
