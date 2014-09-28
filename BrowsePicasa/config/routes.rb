BrowsePicasa::Application.routes.draw do
  root to: 'welcome#index'

  get 'welcome/index' => 'welcome#index'
  post 'login' => 'session#create'
  delete 'logout' => 'session#logout'

  get 'albums' => 'albums#all'
  get 'albums/:id/photos' => 'albums#photos'
  post 'albums/:album_id/photos/:id/comment' => 'photos#comment'
end
