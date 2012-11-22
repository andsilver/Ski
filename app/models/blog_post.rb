class BlogPost < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 5

  def self.visible_posts
    where(visible: true).order('created_at DESC')
  end

  def summary
    (content.length < 500) ? content : content[0..400] + '...'
  end

  def to_param
    "#{id}-#{headline.parameterize}"
  end
end
