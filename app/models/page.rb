# frozen_string_literal: true

class Page < ActiveRecord::Base
  validates :path, :title, presence: true

  validates :path, uniqueness: true

  validates :description, :keywords, :path, :title, length: {maximum: 255}

  belongs_to :footer, optional: true

  belongs_to :region, touch: true, optional: true
  belongs_to :resort, touch: true, optional: true

  def header_html(locale)
    Snippet.find_by(name: header_snippet_name, locale: locale).try(:snippet)
  end

  def sidebar_html(locale)
    Snippet.find_by(name: sidebar_snippet_name, locale: locale).try(:snippet)
  end

  # Checks the title and description for SEO best practices.
  def meta_ok?
    title.length <= 51 && description.present?
  end
end
