MySkiChalet::Application.routes.draw do
  resources :countries
  match "resorts/:id/properties/rent" => "properties#browse_for_rent", :as => :resort_property_rent
  match "resorts/:id/properties/sale" => "properties#browse_for_sale", :as => :resort_property_sale
  resources :resorts do
    resources :categories
    get 'info', :on => :member
  end

  match "sign_in" => "sessions#new"
  match "sign_out" => "sessions#destroy"
  match "sign_up" => "users#new"
  resources :sessions

  match "advertiser_home" => "users#show"
  match "my/details" => "users#edit", :as => :my_details
  resources :users

  resources :adverts do
    post 'update_basket_contents', :on => :collection
    get 'place_order', :on => :collection
  end

  match "new-developments" => "properties#new_developments", :as => :new_developments
  match "my/properties/for_rent" => "properties#my_for_rent", :as => :my_properties_for_rent
  match "my/properties/for_sale" => "properties#my_for_sale", :as => :my_properties_for_sale
  resources :properties do
    post 'advertise_now', :on => :member
    get 'rent', :on => :collection
    get 'sale', :on => :collection
    post 'current_time', :on => :collection
  end

  resources :directory_adverts do
    post 'advertise_now', :on => :member
    get 'my', :on => :collection
  end

  resources :enquiries do
    post 'current_time', :on => :collection
    get 'my', :on => :collection
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
      get 'receipt'
    end
  end

  resources :payments do
    post 'worldpay_callback', :on => :collection
  end

  resources :coupons

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
