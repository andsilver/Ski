MySkiChalet::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  namespace :admin do
    resources :blog_posts, except: [:show]
    resources :regions,    except: [:show]
    resources :resorts,    except: [:show]
  end

  resources :buying_guides

  resources :countries

  resources :snippets

  get 'late-availability' => 'late_availability#index'

  get 'properties/search' => 'properties#quick_search'
  get "resorts/:resort_id/properties/rent" => "properties#browse_for_rent", as: :resort_property_rent
  get "resorts/:resort_id/properties/sale" => "properties#browse_for_sale", as: :resort_property_sale
  get "resorts/:resort_id/properties/new-developments" => "properties#new_developments",
    as: :resort_property_new_developments
  get "resorts/:resort_id/properties/hotels" => "properties#browse_hotels", as: :resort_property_hotels
  get "resorts/:id/resort-guide" => "resorts#resort_guide", as: :resort_guide
  get "resorts/:id/summer-holidays" => "resorts#summer_holidays", as: :summer_holidays
  get "resorts/:id/how-to-get-there" => "resorts#how_to_get_there", as: :how_to_get_there
  resources :resorts, only: [:show] do
    get 'featured', on: :collection
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

  get "tools/rental-prices" => "rental_prices#index"
  get "tools/rental-prices/results" => "rental_prices#results"

  resources :categories, except: [:show]
  get "categories/:id/:resort_id" => "categories#show", as: :show_category

  get "sign_in" => "sessions#new"
  get "sign_out" => "sessions#destroy"
  get "sign_up" => "users#new"
  get "switch_user/:user_id" => "sessions#switch_user", as: :switch_user
  resources :sessions

  get "advertise" => "users#show"
  get "first_advert" => "users#first_advert"
  get "my/details" => "users#edit", as: :my_details
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
  get "my/adverts" => "adverts#my", as: :my_adverts

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

  get 'accommodation/:permalink' => 'properties#show_interhome', as: :interhome_property
  get 'holiday-rentals/:permalink' => 'properties#show_pv', as: :pv_property

  resources :banner_prices
  resources :property_base_prices
  resources :property_volume_discounts
  resources :window_base_prices

  resources :directory_adverts do
    member do
      post 'advertise_now'
      get  'click'
    end
  end

  resources :enquiries do
    collection do
      get 'current_time'
      get 'my'
    end
  end

  resources :email_a_friend_form do
    post 'current_time', on: :collection
  end
  get "email_a_friend_form/1" => "email_a_friend_form#create"

  resources :interhome_place_resorts
  resources :pv_place_resorts

  resources :pv_accommodations do
    post 'import_accommodations', on: :collection
  end

  resources :images

  get "basket" => "adverts#basket"

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
    get  'complete_payment_not_required', on: :collection
    post 'worldpay_callback', on: :collection
  end

  resources :coupons

  resources :currencies do
    get 'update_exchange_rates', on: :collection
  end

  resources :roles do
    get 'sales_pitch', on: :member
  end
  get "welcome/:role" => "roles#sales_pitch", as: :sales_pitch

  resources :websites
  get 'cms/directory-price' => 'websites#edit_prices', as: :directory_price

  resources :pages

  resources :alt_attributes

  resources :footers

  resources :blog_posts do
    get 'feed', on: :collection
  end

  get "blog" => "blog_posts#blog"
  resources :favourites

  get "cms" => "cms#index"
  get "guide" => "cms#guide"
  get "management_information" => "cms#management_information"
  get "gross_sales_analysis" => "cms#gross_sales_analysis"

  get "export" => "export#index"
  get "export/spreadsheet/:class_name" => "export#spreadsheet", as:  :export_spreadsheet

  get "contact" => "home#contact"
  get "privacy" => "home#privacy"
  get "terms" => "home#terms"
  get 'sitemap.xml' => 'application#sitemap', as:  'sitemap', :format => 'xml'
  get 'restart' => 'application#restart', as: 'restart'
  get 'precompile_assets' => 'application#precompile_assets', as: 'precompile_assets'

  get 'home/resort_options_for_quick_search' => 'home#resort_options_for_quick_search'
  root to: 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # Catch unroutable paths and send to the routing error handler
  get '*a', to: 'application#routing_error'
end
