MySkiChalet::Application.routes.draw do
  resources :buying_guides

  resources :countries

  resources :snippets

  match 'late-availability' => 'late_availability#index'

  match 'properties/search' => 'properties#quick_search'
  match "resorts/:resort_id/properties/rent" => "properties#browse_for_rent", :as => :resort_property_rent
  match "resorts/:resort_id/properties/sale" => "properties#browse_for_sale", :as => :resort_property_sale
  match "resorts/:resort_id/properties/new-developments" => "properties#new_developments",
    :as => :resort_property_new_developments
  match "resorts/:resort_id/properties/hotels" => "properties#browse_hotels", :as => :resort_property_hotels
  match "resorts/:id/resort-guide" => "resorts#resort_guide", as: :resort_guide
  match "resorts/:id/summer-holidays" => "resorts#summer_holidays", as: :summer_holidays
  match "resorts/:id/how-to-get-there" => "resorts#how_to_get_there", as: :how_to_get_there
  resources :resorts do
    get 'featured',  :on => :collection
    member do
      get 'resort-guide', action: 'resort_guide'
      get 'directory'
      get 'feature'
      get 'gallery'
      get 'piste_map'
      get 'piste_map_full_size'
      get 'edit_page'
    end
  end

  resources :airports
  resources :airport_distances

  resources :airport_transfers do
    collection do
      get 'find'
      post 'results'
      get 'skilifts'
    end
  end

  match "tools/rental-prices" => "rental_prices#index"
  match "tools/rental-prices/results" => "rental_prices#results"

  match "categories/:id/:resort_id" => "categories#show", as: :show_category
  resources :categories

  match "sign_in" => "sessions#new"
  match "sign_out" => "sessions#destroy"
  match "sign_up" => "users#new"
  match "switch_user/:user_id" => "sessions#switch_user", :as => :switch_user
  resources :sessions

  match "advertise" => "users#show"
  match "first_advert" => "users#first_advert"
  match "my/details" => "users#edit", :as => :my_details
  resources :users do
    collection do
      get 'forgot_password'
      post 'forgot_password_change'
      get 'forgot_password_new'
      post 'forgot_password_send'
      get 'select_role'
    end
  end

  resources :adverts do
    collection do
      post 'update_basket_contents'
      get  'place_order'
      post 'add_windows_to_basket'
      get  'buy_windows'
      post 'delete_all_new_advertisables'
    end
  end
  match "my/adverts" => "adverts#my", :as => :my_adverts

  resources :properties do
    member do
      post 'advertise_now'
      get 'choose_window'
      get  'contact'
      get  'email_a_friend'
      post 'place_in_window'
      post 'remove_from_window'
    end

    collection do
      get  'rent'
      get  'sale'
      get  'current_time'
      get  'import_documentation'
      get  'new_import'
      post 'import'
      get  'new_pericles_import'
      post 'pericles_import'

      post 'check_interhome_booking'
      get 'update_day_of_month_select'
      get 'interhome_payment_success'
      get 'interhome_payment_failure'
    end
  end

  match 'accommodation/:permalink' => 'properties#show_interhome', as: :interhome_property
  match 'holiday-rentals/:permalink' => 'properties#show_pv', as: :pv_property

  resources :banner_prices
  resources :property_base_prices
  resources :property_volume_discounts
  resources :window_base_prices

  resources :directory_adverts do
    post 'advertise_now', :on => :member
    get  'click',         :on => :member
  end

  resources :enquiries do
    get 'current_time', :on => :collection
    get 'my', :on => :collection
  end

  resources :email_a_friend_form do
    post 'current_time', :on => :collection
  end
  match "email_a_friend_form/1" => "email_a_friend_form#create"

  resources :interhome_place_resorts
  resources :pv_place_resorts

  resources :pv_accommodations do
    post 'import_accommodations', on: :collection
  end

  resources :images

  match "basket" => "adverts#basket"

  resources :orders do
    collection do
      get 'latest_receipt'
      get 'receipts'
      get 'select_payment_method'
    end
    member do
      get 'invoice'
      get 'receipt'
    end
  end

  resources :payments do
    get  'complete_payment_not_required', :on => :collection
    post 'worldpay_callback', :on => :collection
  end

  resources :coupons

  resources :currencies do
    get 'update_exchange_rates', :on => :collection
  end

  resources :roles do
    get 'sales_pitch', :on => :member
  end
  match "welcome/:role" => "roles#sales_pitch", :as => :sales_pitch

  resources :websites
  match 'cms/directory-price' => 'websites#edit_prices', as: :directory_price

  resources :pages

  resources :alt_attributes

  resources :footers

  resources :blog_posts do
    get 'feed', on: :collection
  end

  match "blog" => "blog_posts#blog"
  resources :favourites

  match "cms" => "cms#index"
  match "guide" => "cms#guide"
  match "management_information" => "cms#management_information"
  match "gross_sales_analysis" => "cms#gross_sales_analysis"

  match "export" => "export#index"
  match "export/spreadsheet/:class_name" => "export#spreadsheet", :as => :export_spreadsheet

  match "contact" => "home#contact"
  match "privacy" => "home#privacy"
  match "terms" => "home#terms"
  match 'sitemap.xml' => 'application#sitemap', :as => 'sitemap', :format => 'xml'
  match 'restart' => 'application#restart', as: 'restart'

  match 'home/resort_options_for_quick_search' => 'home#resort_options_for_quick_search'
  root to: 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # Catch unroutable paths and send to the routing error handler
  match '*a', to: 'application#routing_error'
end
