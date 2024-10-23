Rails.application.routes.draw do
  devise_for :teachers, controllers: {
    sessions: 'teachers/sessions',
    registrations: 'teachers/registrations',
    passwords: 'teachers/passwords'
  }

  root "students#index"

  resources :students
end
