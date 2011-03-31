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
      content_tag('div', h(notice), {:id => "flash_notice"})
    end
  end

  def euros(number)
    number_to_currency(number, :unit => '€', :precision => 0)
  end

  def euros_from_cents(number)
    number_to_currency(number / 100.00, :unit => '€', :precision => 2)
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

  def tick yes
    tick_cross yes, false
  end
end
