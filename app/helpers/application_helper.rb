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
end
