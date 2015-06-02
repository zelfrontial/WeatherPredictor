Rails.application.routes.draw do
  resources :single_readings
  get 'weather/location' => 'location#getAllStation'
  #get 'weather/data/:location_id/:date' => 'reading#getLocationReading'
  # get 'weather/data/:postcode/:date' => 'reading#getPostcodeReading'
  get 'weather/prediction/:postcode/:period' => 'prediction#getPostcodePrediction'
  get 'weather/prediction/:lat/:long/:period' => 'prediction#getGeolocationPrediction'



  #Buggy haven't testeed
  get 'weather/data/:postcode/:date', to: "reading#getPostcodeReading", constraints: { postcode: /3\d{3}/ }
  get 'weather/data/:location_id/:date', to: "reading#getLocationReading", constraints: { location_id: /[a-zA-Z_]*/ }
  # get 'weather/locations', to: "weather#location", as: location
  # get 'weather/predicition/:postcode/:period', to: "weather#prediction", constraints: { postcode: /3\d{3}/ }, as: prediction_postcode
  # get 'weather/predicition/:lat/:long/:period', to: "weather#prediction", as: prediction_loc
  





  #get 'photos/:id', to: 'photos#show', constraints: { id: /[A-Z]\d{5}/ }
  # namespace :data do
  #   get 'weather/data/:location_id/:date', to: data, as: location_data_by_date
  #   get 'weather/data/:post_code/:date', to: data, as: post_code_data_by_date
  # end 

  
  # namespace :predicition do
  #   get 'weather/prediction/:post_code/:period', to: prediction, as: post_code_prediction 
  #   get 'weather/prediction/:lat/:long/:period', to: prediction, as: lat_long_prediction
  # end



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
