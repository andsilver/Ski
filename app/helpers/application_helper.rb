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
    alt_attr = AltAttribute.find_or_create_by_path(path)
    alt_attr.alt_text.blank? ? fallback : alt_attr.alt_text
  end
end
