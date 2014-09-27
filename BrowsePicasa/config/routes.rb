BrowsePicasa::Application.routes.draw do
  root to: 'welcome#index'

  get 'welcome/index' => 'welcome#index'
  post 'login' => 'session#create'
  delete 'logout' => 'session#logout'

  get 'home' => 'home#index'
  get 'albums' => 'albums#all'
  get 'albums/:id' => 'albums#photos'
  post 'albums/:album_id/photos/:id/comment' => 'photos#comment'
end
