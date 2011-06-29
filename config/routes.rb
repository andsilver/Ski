MySkiChalet::Application.routes.draw do
  resources :countries
  match "resorts/:resort_id/properties/rent" => "properties#browse_for_rent", :as => :resort_property_rent
  match "resorts/:resort_id/properties/sale" => "properties#browse_for_sale", :as => :resort_property_sale
  match "resorts/:resort_id/properties/new-developments" => "properties#new_developments",
    :as => :resort_property_new_developments
  resources :resorts do
    get 'detail',    :on => :member
    get 'directory', :on => :member
    get 'featured',  :on => :collection
    get 'feature',   :on => :member
    get 'piste_map', :on => :member
  end

  resources :airports
  resources :airport_distances
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
    end
  end

  resources :adverts do
    post 'update_basket_contents', :on => :collection
    get 'place_order', :on => :collection
  end
  match "my/adverts" => "adverts#my", :as => :my_adverts

  resources :properties do
    post 'advertise_now',  :on => :member
    get  'contact',        :on => :member
    get  'email_a_friend', :on => :member
    get  'rent',           :on => :collection
    get  'sale',           :on => :collection
    get  'current_time',   :on => :collection
  end

  resources :property_base_prices
  resources :property_volume_discounts

  resources :banner_adverts do
    get  'click',         :on => :member
    post 'advertise_now', :on => :member
  end

  resources :directory_adverts do
    post 'advertise_now', :on => :member
  end

  resources :enquiries do
    get 'current_time', :on => :collection
    get 'my', :on => :collection
  end

  resources :email_a_friend_form do
    post 'current_time', :on => :collection
  end
  match "email_a_friend_form/1" => "email_a_friend_form#create"

  resources :images

  match "basket" => "adverts#basket"

  resources :orders do
    collection do
      get 'latest_receipt'
      get 'receipts'
      get 'select_payment_method'
    end
    member do
      get 'receipt'
    end
  end

  resources :payments do
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

  match "uploads/:filename/delete_file" => "uploads#delete_file", :as => :delete_uploaded_file,
    :constraints => { :filename => /[^\/]+/ }
  resources :uploads do
    delete 'delete_file', :on => :member
  end

  resources :websites
  match "cms/prices" => "websites#edit_prices", :as => :banner_directory_advert_prices

  resources :pages
  resources :favourites

  match "cms" => "cms#index"
  match "management_information" => "cms#management_information"
  match "gross_sales_analysis" => "cms#gross_sales_analysis"

  match "export" => "export#index"
  match "export/spreadsheet/:class_name" => "export#spreadsheet", :as => :export_spreadsheet

  match "start" => "home#start"
  match "privacy" => "home#privacy"
  match "terms" => "home#terms"
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
  # match ':controller(/:action(/:id(.:format)))'
end
