Rails.application.routes.draw do

  get 'home/index'

  get 'batch_record_updates' => 'batch_record_updates#index'

  get 'transfer_request_form' => 'batch_record_updates#transfer_request_form'
  get 'withdraw_some_items' => 'batch_record_updates#withdraw_some_items'
  get 'change_home_location' => 'batch_record_updates#change_home_location'
  get 'change_current_location' => 'batch_record_updates#change_current_location'
  get 'change_item_type' => 'batch_record_updates#change_item_type'

  get 'show_batches_complete' => 'batch_record_updates#show_batches_complete'
  get 'show_batches_not_complete' => 'batch_record_updates#show_batches_not_complete'

  get 'sal3_batch_requests' => 'sal3_batch_requests#index'

  get 'management_reports' => 'management_reports#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
