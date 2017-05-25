Rails.application.routes.draw do
  root 'goals#index'
  post '/create' => 'goals#create'
  get '/show' => 'goals#show'
  post '/log_user' => 'goals#log_user'
  get '/logout' => 'goals#logout'
  post '/add_goal' => 'goals#add_goal'
  get '/view_profile/:id' => 'goals#view_profile'
  get '/view_profile/:user_id' => 'goals#view_profile'
  post '/post_message/:user_id' => 'goals#post_message'
  post '/complete_goal/:goal_id' => 'goals#complete_goal'
  post '/incomplete_goal/:goal_id' => 'goals#incomplete_goal'
  post '/failed/:user_id' => 'goals#failed'
  post '/avatar' => 'goals#avatar'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
