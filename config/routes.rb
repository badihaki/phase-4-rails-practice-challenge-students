Rails.application.routes.draw do
  resources :students, only: [:index, :show, :update, :destroy]
  resources :instructors
  post "/instructors/:id/students", to: "instructors#create_new_student"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
