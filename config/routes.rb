MySkiChalet::Application.routes.draw do
  resources :buying_guides

  resources :countries
  match "resorts/:resort_id/properties/rent" => "properties#browse_for_rent", :as => :resort_property_rent
  match "resorts/:resort_id/properties/sale" => "properties#browse_for_sale", :as => :resort_property_sale
  match "resorts/:resort_id/properties/new-developments" => "properties#new_developments",
    :as => :resort_property_new_developments
  match "resorts/:resort_id/properties/hotels" => "properties#browse_hotels", :as => :resort_property_hotels
  match "resorts/:id/resort-guide" => "resorts#resort_guide", as: :resort_guide
  match "resorts/:id/summer-holidays" => "resorts#summer_holidays", as: :summer_holidays
  resources :resorts do
    get 'featured',  :on => :collection
    member do
      get 'resort-guide', action: 'resort_guide'
      get 'directory'
      get 'feature'
      get 'gallery'
      get 'piste_map'
      get 'piste_map_full_size'
    end
  end

  resources :airports
  resources :airport_distances

  resources :airport_transfers do
    collection do
      get 'find'
      post 'results'
    end
  end

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
    post 'update_basket_contents',  :on => :collection
    get  'place_order',             :on => :collection
    post 'add_windows_to_basket',   :on => :collection
    get  'buy_windows',             :on => :collection
  end
  match "my/adverts" => "adverts#my", :as => :my_adverts

  resources :properties do
    post 'advertise_now',        :on => :member
    post 'choose_window',        :on => :member
    get  'contact',              :on => :member
    get  'email_a_friend',       :on => :member
    post 'place_in_window',      :on => :member
    get  'rent',                 :on => :collection
    post 'remove_from_window',   :on => :member
    get  'sale',                 :on => :collection
    get  'current_time',         :on => :collection
    get  'import_documentation', :on => :collection
    get  'new_import',           :on => :collection
    post 'import',               :on => :collection
    get  'new_pericles_import',  :on => :collection
    post 'pericles_import',      :on => :collection
  end

  match 'accommodation/:permalink' => 'properties#show_interhome', as: :interhome_property

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

  resources :images

  match "basket" => "adverts#basket"

  resources :orders do
    collection do
      get 'latest_receipt'
      get 'receipts'
      get 'select_payment_method'
      get 'resources'
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

  resources :uploads do
    delete 'delete_file', :on => :collection
  end

  resources :websites
  match "cms/prices" => "websites#edit_prices", :as => :banner_directory_advert_prices

  resources :pages do
    get 'resources', on: :collection
  end

  resources :alt_attributes

  resources :footers

  resources :blog_posts
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
  root :to => "home#index"

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
end
