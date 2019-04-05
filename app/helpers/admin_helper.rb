module AdminHelper
  def admin_menu_links(links)
    links.map { |text, path| admin_menu_link(text, path) }.join.html_safe
  end

  def admin_menu_link(text, path)
    link_to(text, path, current_page?(path) ? {class: "active dropdown-item"} : {class: "dropdown-item"})
  end

  # Provides a button in a table cell to move the object up if it is not
  # already first in the list, or an empty cell if it is.
  def move_up_cell(path_helper, object)
    if object.first?
      content_tag(:td, "&nbsp;".html_safe)
    else
      content_tag(:td, link_to("Move Up", send(path_helper, object), class: "btn btn-secondary", method: :post))
    end
  end

  # Provides a button in a table cell to move the object down if it is not
  # already last in the list, or an empty cell if it is.
  def move_down_cell(path_helper, object)
    if object.last?
      content_tag(:td, "&nbsp;".html_safe)
    else
      content_tag(:td, link_to("Move Down", send(path_helper, object), class: "btn btn-secondary", method: :post))
    end
  end

  def delayed_job_workers
    `ps x | grep delayed_job`
      .split("\n")
      .reject {|l| l.include?("grep")}
      .count
  end
end
