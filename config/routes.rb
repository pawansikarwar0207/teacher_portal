Rails.application.routes.draw do
  devise_for :teachers, controllers: {
    sessions: 'teachers/sessions'
  }

  root "students#index"

  resources :students
end
