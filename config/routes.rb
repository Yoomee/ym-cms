Rails.application.routes.draw do
  
  Mercury::Engine.routes
    
  resources :pages do
    member do 
      post :mercury_update
      get :order
    end
    collection do
       get :order
     end
  end
  match "pages/order", :to => "pages#update_order", :via => :post 
  match "pages/:id/order", :to => "pages#update_order", :via => :post 
  match "pages/:parent_id/subpage", :to => 'pages#new', :as => "new_child_page"
  
  resources :slideshows, :only => [:edit, :update] 
  
end
