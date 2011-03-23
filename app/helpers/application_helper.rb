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

  def km(metres)
    ((metres / 1000.0).to_s + '<span class="km">km</span>').html_safe
  end

  def md(text)
    RDiscount.new(text).to_html.html_safe
  end
end
