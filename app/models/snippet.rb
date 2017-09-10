# frozen_string_literal: true

# A Snippet is a container for short pieces of content-managed copy. The same
# snippet can be provided for a number of locales.
class Snippet < ActiveRecord::Base
  LOCALES = %w[de en fr it].freeze
  validates_inclusion_of :locale, in: LOCALES
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :locale
end
