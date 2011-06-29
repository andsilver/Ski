module FavouritesHelper
  def favourite_for_property(p)
    if @unregistered_user
      @unregistered_user.favourites.each do |f|
        return f if f.property == p
      end
    end
    nil
  end
end
