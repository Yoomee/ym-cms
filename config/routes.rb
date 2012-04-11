Rails.application.routes.draw do
  
  Mercury::Engine.routes
    
  resources :pages do
    member { post :mercury_update }
  end
  match "pages/:parent_id/subpage", :to => 'pages#new', :as => "new_child_page"
  
  resources :slideshows, :only => [:edit, :update] 
  
end
