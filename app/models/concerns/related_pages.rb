module RelatedPages
  extend ActiveSupport::Concern

  included do
    after_save :handle_name_change
    before_destroy :destroy_pages
  end

  def has_page?(page_name)
    !page(page_name).nil?
  end

  def page(page_name)
    Page.find_by_path(page_path(page_name))
  end

  def create_page(page_name)
    Page.create(path: page_path(page_name), title: page_title(page_name))
  end

  def page_path(page_name, object_name = nil)
    object_name ||= name
    "/#{self.class.to_s.pluralize.downcase}/#{id}-#{object_name.parameterize}/#{page_name}"
  end

  def handle_name_change
    if name_changed?
      page_names.each do |page_name|
        p = Page.find_by_path(page_path(page_name, name_was))
        if p
          p.path = page_path(page_name)
          p.save
        end
      end
    end
  end

  def destroy_pages
    page_names.each {|n| page.destroy if has_page?(n)}
  end

  def page_names
    self.class.page_names
  end
end
