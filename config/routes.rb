require 'api_version'
Rails.application.routes.draw do
  scope module: :v1, defaults: {format: 'json'}, constraints: ApiVersion.new('v1', true) do
    resources :tags, except: %i[index edit]
    resources :items, except: %i[index edit]
    post 'get_items_through_tags', to: 'items#get_items_through_tags'
    get 'deleted_items', to: 'items#deleted_items'
    get 'get_items', to: 'items#get_items'
    get 'get_tags', to: 'tags#get_tags'
    post '/undo_delete_item:id', to: 'items#undo_delete_item'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   tags :products

  # Example resource route with options:
  #   tags :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-tags:
  #   tags :products do
  #     tags :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-tags:
  #   tags :products do
  #     tags :comments
  #     tags :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   tags :posts, concerns: :toggleable
  #   tags :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     tags :products
  #   end
end
