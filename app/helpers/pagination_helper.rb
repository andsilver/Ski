module PaginationHelper
  def pagination_start(collection)
    (((collection.current_page || 1).to_i * collection.first.class.per_page) - (collection.first.class.per_page - 1))
  end

  def pagination_end(collection)
    [(pagination_start(collection) + collection.first.class.per_page - 1), collection.count].min
  end
end
