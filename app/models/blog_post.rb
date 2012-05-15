class BlogPost < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 5

  def summary
    (content.length < 500) ? content : content[0..400] + '...'
  end

  def to_param
    "#{id}-#{headline.parameterize}"
  end
end
