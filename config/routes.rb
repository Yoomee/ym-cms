Rails.application.routes.draw do
  
  resources :pages do
    member do 
      get :order
    end
    collection do
       get :order
     end
  end
  match "pages/order", :to => "pages#update_order", :via => :post 
  match "pages/:id/order", :to => "pages#update_order", :via => :post 
  get "pages/:parent_id/subpage", :to => 'pages#new', :as => "new_child_page"


  
  resources :slideshows do
    member do
      get :order
    end
  end
  
  resources :snippets, :only => [:index, :edit, :update]
  
end
