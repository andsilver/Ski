module EditRelatedPages
  extend ActiveSupport::Concern

  def edit_page
    page_name = params[:page_name]
    if klass.page_names.include?(page_name)
      object.create_page(page_name) unless object.has_page?(page_name)
      redirect_to edit_page_path(object.page(page_name))
    else
      raise "#{klass} does not have the page name #{params[:page_name]}"
    end
  end
end
