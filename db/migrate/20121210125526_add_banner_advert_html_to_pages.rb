class AddBannerAdvertHtmlToPages < ActiveRecord::Migration
  class Page < ActiveRecord::Base
  end

  def change
    add_column :pages, :banner_advert_html, :text
    Page.reset_column_information
    Page.all.each do |page|
      unless page.fixed_banner_image_filename.blank?
        page.banner_advert_html = '<img src="/fixed-banners/' + page.fixed_banner_image_filename + '" alt="">'
        unless page.fixed_banner_target_url.blank?
          page.banner_advert_html = '<a href="' + page.fixed_banner_target_url + '">' + page.banner_advert_html + '</a>'
        end
        page.save(validate: false)
      end
    end
  end
end
