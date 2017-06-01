module RelatedPages
  extend ActiveSupport::Concern

  included do
    after_save :handle_slug_change
    before_destroy :destroy_pages
    has_many :pages
  end

  def has_page?(page_name)
    !page(page_name).nil?
  end

  def has_visible_page?(page_name)
    Page.where(path: page_path(page_name), visible: true).any?
  end

  def page(page_name)
    Page.find_by(path: page_path(page_name))
  end

  def create_page(page_name)
    pages.create(path: page_path(page_name), title: page_title(page_name))
  end

  def page_path(page_name, object_slug = nil)
    object_slug ||= slug
    "/#{self.class.to_s.pluralize.downcase}/#{object_slug}/#{page_name}"
  end

  def handle_slug_change
    if saved_change_to_attribute? :slug
      page_names.each do |page_name|
        p = Page.find_by(path: page_path(page_name, slug_before_last_save))
        if p
          p.path = page_path(page_name)
          p.save
        end
      end
    end
  end

  def destroy_pages
    page_names.each {|n| page(n).destroy if has_page?(n)}
  end

  def page_names
    self.class.page_names
  end
end
