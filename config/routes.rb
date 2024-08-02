Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords],controllers: {
    sessions: "admin/sessions"
  }
  scope module: :public do
    root to: 'inquiries#new'
    post 'inquiries/confirm' => "inquiries#confirm"
    get 'inquiries/complete' => "inquiries#complete"
    resources :inquiries, only: [:create]
  end

  namespace :admin do
    get "/" => "inquiries#index"
    patch 'inquiries/:id/destroy' => "inquiries#destroy", as: "destroy_inquiry"
    resources :inquiries, only: [:show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
  end
end
