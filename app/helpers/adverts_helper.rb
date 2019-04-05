module AdvertsHelper
  def edit_advert_object_path advert
    send "edit_#{advert.type}_path".to_sym, advert.object
  end
end
