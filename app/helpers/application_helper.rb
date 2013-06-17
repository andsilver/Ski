# coding: utf-8

module ApplicationHelper
  def flash_notice
    notice = ''
    if flash[:now]
      notice = flash[:now]
      flash[:now] = nil
    end
    if flash[:notice]
      notice += ' ' + flash[:notice]
    end
    unless notice.empty?
      content_tag('div', h(notice), {id: "flash_notice"})
    end
  end

  def page_header(title)
    content_tag(:h1, title, class: 'page-header')
  end

  def euros(number)
    number_to_currency(number, unit: '€', precision: 0)
  end

  def euros_from_cents(number)
    number_to_currency(number / 100.00, unit: '€', precision: 2)
  end

  def format_currency(number, currency)
    format = currency.pre? ? "%u%n" : "%n %u"
    number_to_currency(number, unit: currency.unit, precision: 0, format: format)
  end

  def km(metres)
    ((metres / 1000.0).to_s + '<span class="km">km</span>').html_safe
  end

  def md(text)
    RDiscount.new(text).to_html.html_safe
  end

  def required_field
    '<span class="required">*</span>'.html_safe
  end

  def clear
    '<p class="clear">&nbsp;</p>'.html_safe
  end

  def a_tick
    '<span class="tick">✔</span>'.html_safe
  end

  def a_cross
    '<span class="cross">✘</span>'.html_safe
  end

  def tick_cross yes, show_cross=true
    if yes
      a_tick
    elsif show_cross
      a_cross
    end
  end

  def tick_cross_unknown yes
    yes.nil? ? '<span class="unknown">?</span>'.html_safe : tick_cross(yes)
  end

  def tick yes
    tick_cross yes, false
  end

  def star_rating rating
    ((star * rating) + (empty_star * (5 - rating))).html_safe
  end

  def star
    '<img src="/images/star.png" alt="*">'.html_safe
  end

  def empty_star
    '<img src="/images/empty-star.png" alt="">'.html_safe
  end

  def alt_attribute(path, fallback)
    alt_attr = AltAttribute.find_or_create_by(path: path)
    alt_attr.alt_text.blank? ? fallback : alt_attr.alt_text
  end

  def delete_button(object)
    link_to '<i class="icon-trash icon-white"></i> Delete'.html_safe,
    object,
    data: { confirm: 'Are you sure?' },
    method: :delete,
    class: 'btn btn-danger',
    title: "Delete #{object_title(object)}"
  end

  def edit_button(object)
    link_to '<i class="icon-edit"></i> Edit'.html_safe,
    edit_polymorphic_path(object),
    class: 'btn',
    title: "Edit #{object_title(object)}"
  end

  def new_button(type)
    link_to '<i class="icon-plus"></i> New'.html_safe,
    new_polymorphic_path(type),
    class: 'btn',
    title: "New #{object_title(type)}"
  end

  def view_button(object)
    link_to '<i class="icon-eye-open"></i> View'.html_safe,
    object,
    class: 'btn'
  end

  def editor(form, attribute, mode)
    textarea_id = "##{form.object_name}_#{attribute}"
    editor_id = "editor_#{attribute}"
    form_classes = ".new_#{form.object_name}, .edit_#{form.object_name}"
    form.text_area(attribute, class: 'editor-textarea') +
    content_tag('div', form.object.send(attribute), id: editor_id, class: 'editor') +
    javascript_tag(
      "var #{editor_id} = ace.edit('#{editor_id}');
  #{editor_id}.setTheme('ace/theme/chrome');
  #{editor_id}.getSession().setMode('ace/mode/#{mode}');
  #{editor_id}.getSession().setTabSize(2);
  #{editor_id}.getSession().setUseSoftTabs(true);
  $('#{form_classes}').submit(function() {
    $('#{textarea_id}').val(#{editor_id}.getSession().getValue());
  });
  "
    )
  end

  def link_to_with_count(text, object, count)
    link_to(raw(
      h(text.to_s) + content_tag(:span, "(#{count})")
    ), object)
  end

  protected

    def object_title(object)
      object.instance_of?(Array) ? object.last : object
    end
end
