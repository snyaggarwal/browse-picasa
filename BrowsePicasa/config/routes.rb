BrowsePicasa::Application.routes.draw do
  root to: 'welcome#index'

  get 'welcome/index' => 'welcome#index'
  post 'login' => 'login#index'
  get 'home' => 'home#index'
  delete 'logout' => 'home#logout'
  get 'albums/:id' => 'albums#photos'
  post 'albums/:album_id/photos/:id/comment' => 'photos#comment'
end
