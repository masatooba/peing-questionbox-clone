Rails.application.routes.draw do
  root to: "home#index"

  post "home/tweet"
  get ":id" => "home#show"
  get "home/tweet_box"
  get "home/error"
  get "home/question"
  get "home/about"
  get "home/guides"
  get "home/privacy"
  get "home/contact"
  post "home/change_before"
  post "home/change_after"


  get 'setting/index'
  post "setting/change"
  post "setting/destroy"

  get 'message/add/:id', :to => 'message#add'
  get 'message/index'
  get 'message/after'
  post "message/create"
  post "message/answer"
  get "/message/get_image"


  get 'base/login_required'
  get 'sessions/callback'
  get 'sessions/destroy'
  get '/auth/:provider/callback', to: 'sessions#callback'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
