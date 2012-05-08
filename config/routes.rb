EbrittonCom::Application.routes.draw do

  root :to => "blog#index"

  resources :blog, :only => [:index, :show] do
    collection do
      get :archive
    end
  end

  [:bio, :contact].each do |block|
    match block.to_s => "blocks##{block}"
  end  

  match "p" => "blocks#secret"

  resources :links, :only => [:index]
  resources :projects, :only => [:index]
  resources :events, :only => [:index, :show]


  ## Legacy PHP URLs
  %w[blog events bio bloghistory works links contact].each do |page|
    match "#{page}.php" => "legacy##{page}"
  end

  # Catch all remaining PHP pages and send them somewhere
  match ":page.php" => "legacy#default"

  # Legacy file locations
  match "/media/:filename" => "legacy#media"

end

