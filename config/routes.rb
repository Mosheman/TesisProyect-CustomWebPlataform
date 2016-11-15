Rails.application.routes.draw do

  namespace :api, :defaults => {:format => :json} do

  end

  # Visualization Tool
  get "visual_tool/index"
  get "visual_tool/action_dispatcher"
  get "visual_tool/massive_push"
  get "visual_tool/received"
  get "visual_tool/tweets_viewer"
  get "visual_tool/users_viewer"
  get "visual_tool/visualizer_dispatcher"
  get "visual_tool/inner_receiver"
  scope "visual_tool" do
    resources :packages
    resources :studies
    get "tweets_visualizer/index", to: "tweets_visualizer#index"
    get "tusers_visualizer/index", to: "tusers_visualizer#index"
  end

  resources :searches do
    get "show_tweets", to: "searches#show_tweets"
    get "show_users", to: "searches#show_users"
    resources :twitter_users
    resources :tweets
      collection do
        get :set_searchtype
        post :create_quick
      end
  end

  #post 'searches/start_search'
  #get 'searches/index'

  resources :twitter_credentials
  get 'settings/index'


  devise_for :users, controllers: { sessions: "users/sessions", 
                                      registrations: "users/registrations" }
  
  get 'dashboard/index'

  get 'index', to: "welcome#index"
  get 'contact', to: "welcome#contact"
  get 'about', to: "welcome#about"

  #get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index' 


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
end
