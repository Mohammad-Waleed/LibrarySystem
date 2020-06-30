Rails.application.routes.draw do

  devise_for :users ,controllers: {  registrations: 'users/registrations'}
  resources :libraries
  resources :issuers
  resources :admins
  resources :managers
  resources :books
  resources :book_histories,only:[:destroy]

  get  '/search_book/',to:"books#search_book",as: 'search_book'
  post '/books/:id/issue_book',to:'books#issue_book',as: 'issue_book'
  post '/books/:id/issue_book_request',to:'books#issue_book_request',as: 'issue_book_request'
  post '/books/:id/return_book',to:'books#return_book',as: 'return_book'
  post '/managers/:id/change_status',to:'managers#change_status',as:'manager_change_status'
  post '/issuers/:id/change_status',to:'issuers#change_status',as:'issuer_change_status'
  post '/books/:id/change_status',to:'books#change_status',as:'book_change_status'
  post '/issuers/:id/approve',to:'issuers#approve',as:'issuer_approval'

  root 'libraries#index'
end
