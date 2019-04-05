Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  namespace :admin do
    resources :airport_distances, except: [:show]
    resources :airports,          except: [:show]
    resources :alt_attributes,    except: [:show]
    resources :buying_guides,     except: [:show]
    resources :carousel_slides,   except: [:show] do
      member do
        post :move_down
        post :move_up
      end
    end
    resources :categories,        except: [:show]
    resources :countries,         except: [:show]
    resources :currencies,        except: [:show] do
      collection do
        get "update_exchange_rates"
      end
    end
    resources :coupons,           except: [:show]
    resources :footers,           except: [:show]
    resources :holiday_types,     except: [:show]
    resources :holiday_type_brochures, only: [:create, :destroy]
    resources :payments,          only: [:index, :show]
    resources :regions,           except: [:show] do
      member do
        get "edit_page"
      end
    end
    resources :resorts, except: [:show] do
      member do
        get "edit_page"
        post "destroy_directory_adverts"
        post "destroy_properties"
      end
    end
    resources :roles,             except: [:show]
    resources :snippets,          except: [:show]
    resources :tracked_actions, only: [:index]
    resources :trip_advisor_locations, only: [:index, :show, :update]

    resources :users, only: [:index, :destroy] do
      member do
        post "extend_windows"
      end
    end

    resources :window_base_prices, except: [:show]
  end

  resources :buying_guides, only: [:show]

  get "late-availability" => "late_availability#index"

  get "properties/search" => "properties#quick_search"

  resources :property_sales, only: [:index]

  get "resorts/:resort_slug/properties/rent" => "properties#browse_for_rent", :as => :resort_property_rent
  get "resorts/:resort_slug/properties/sale" => "properties#browse_for_sale", :as => :resort_property_sale
  get "resorts/:resort_slug/properties/new-developments" => "properties#new_developments",
      :as => :resort_property_new_developments

  # Region property routes are handled by the same controller and actions as
  # the resort property routes.
  get "regions/:region_slug/properties/rent" => "properties#browse_for_rent", :as => :region_property_rent
  get "regions/:region_slug/properties/sale" => "properties#browse_for_sale", :as => :region_property_sale
  get "regions/:region_slug/properties/new-developments" => "properties#new_developments", :as => :region_property_new_developments

  get "resorts/:id/resort-guide" => "resorts#resort_guide", :as => :resort_guide
  get "resorts/:id/ski-and-guiding-schools" => "resorts#ski_and_guiding_schools", :as => :ski_and_guiding_schools
  get "resorts/:id/summer-holidays" => "resorts#summer_holidays", :as => :summer_holidays
  get "resorts/:id/how-to-get-there" => "resorts#how_to_get_there", :as => :how_to_get_there
  resources :resorts, only: [:show] do
    get "featured", on: :collection
    member do
      get "resort-guide", action: "resort_guide"
      get "directory"
      get "feature"
      get "gallery"
      get "piste_map"
      get "piste_map_full_size"
    end
  end

  resources :airport_transfers do
    collection do
      get "find"
      post "results"
      get "skilifts"
    end
  end

  get "tools/rental-prices" => "rental_prices#index"
  get "tools/rental-prices/results" => "rental_prices#results"

  get "categories/:id/:resort_slug" => "categories#show", :as => :show_category

  get "sign_in" => "sessions#new"
  get "sign_out" => "sessions#destroy"
  get "sign_up" => "users#new"
  get "switch_user/:user_id" => "sessions#switch_user", :as => :switch_user
  resources :sessions

  get "advertise" => "users#show"
  get "first_advert" => "users#first_advert"
  get "my/details" => "users#edit", :as => :my_details
  resources :users, except: [:index, :destroy] do
    collection do
      get "forgot_password"
      post "forgot_password_change"
      get "forgot_password_new"
      post "forgot_password_send"
      get "select_role"
    end
  end

  resources :holiday_types, only: [:show], path: "holidays"

  get(
    ":place_type/:place_slug/holidays/:holiday_type_slug/(*tab)" =>
      "holiday_type_brochures#show",
    :as => :holiday_type_brochure,
    :constraints => {place_type: /countries|regions|resorts/}
  )

  resources :adverts do
    collection do
      post "update_basket_contents"
      get  "place_order"
      post "add_windows_to_basket"
      get  "buy_windows"
      post "delete_all_new_advertisables"
    end
  end
  get "my/adverts" => "adverts#my", :as => :my_adverts

  resources :properties do
    member do
      post "advertise_now"
      get "choose_window"
      get  "contact"
      get  "interhome_booking_form"
      post "place_in_window"
      post "remove_from_window"
    end

    collection do
      get  "rent"
      get  "sale"
      get  "current_time"

      post "interhome_enquiry"
      post "check_interhome_booking"
      get "update_booking_durations_select"
      get "update_day_of_month_select"
      get "interhome_payment_success"
      get "interhome_payment_failure"
    end
  end

  get "accommodation/:permalink" => "properties#show_interhome", :as => :interhome_property

  resources :property_base_prices

  post "property_importer/import"
  get  "property_importer/import_documentation"
  get  "property_importer/new_import"
  get  "property_importer/new_pericles_import"
  post "property_importer/pericles_import"

  resources :property_volume_discounts

  resources :directory_adverts do
    member do
      post "advertise_now"
      post "click"
    end
  end

  resources :enquiries do
    collection do
      get "current_time"
      get "my"
    end
  end

  resources :interhome_place_resorts

  resources :images

  get "basket" => "adverts#basket"

  resources :orders do
    collection do
      get "latest_receipt"
      get "receipts"
      get "select_payment_method"
    end
    member do
      get "invoice"
      get "receipt"
    end
  end

  resources :payments do
    get  "complete_payment_not_required", on: :collection
    post "worldpay_callback", on: :collection
  end

  resources :regions, only: [:show]
  get "regions/:id/how-to-get-there" => "regions#how_to_get_there", :as => :how_to_get_to_region
  get "regions/:id/piste_map" => "regions#piste_map", :as => :region_piste_map

  get "welcome/:role" => "roles#sales_pitch", :as => :sales_pitch

  resources :trip_advisor_properties, only: [] do
    post "get_details", on: :member
  end

  resources :websites
  get "cms/directory-price" => "websites#edit_prices", :as => :directory_price

  resources :pages do
    get "copy", on: :member
  end

  get "cms" => "cms#index"
  get "guide" => "cms#guide"
  get "management_information" => "cms#management_information"
  get "gross_sales_analysis" => "cms#gross_sales_analysis"

  get "export" => "export#index"
  get "export/spreadsheet/:class_name" => "export#spreadsheet", :as => :export_spreadsheet

  get "contact" => "home#contact"
  get "privacy" => "home#privacy"
  get "style-guide" => "home#style_guide", :as => :style_guide
  get "terms" => "home#terms"
  get "sitemap.xml" => "application#sitemap", :as => "sitemap", :format => "xml"
  get "restart" => "application#restart", :as => "restart"
  get "precompile_assets" => "application#precompile_assets", :as => "precompile_assets"

  get "search" => "search#index"
  get "search/place_names" => "search#place_names"

  get "home/search" => "home#search", :as => :home_search
  get "home/search_sales" => "home#search_sales", :as => :home_search_sales

  get "home/country_options_for_quick_search" => "home#country_options_for_quick_search"
  get "home/resort_options_for_quick_search" => "home#resort_options_for_quick_search"
  root "home#index"

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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # Catch unroutable paths and send to the routing error handler
  get "*a", to: "application#routing_error"
end
