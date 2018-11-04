Rails.application.routes.draw do
  # Aqui le estoy diciendo a rails que cuando accedan a la direccion /carrito, los redirija 
  # a la accion carrito del controlador de payments
  get "/carrito", to: "payments#carrito"
  get "/compras", to: "payments#compras"
  # es muy importante que esta ruta este arriba de resources payments
  get "payments/express"
  get "transactions/checkout"
  resources :attachments
  resources :posts
  resources :payments
  # Lo de controllers, es para que reciba los hash que devuelve omniauth para ver si se realizo el
  # Inicio de sesion desde facebook o twitter por ejemplo
  devise_for :usuarios, controllers: {omniauth_callbacks: "omniauth_callbacks",
  									 registrations: "registrations"}
  
  # Para manejar manualmente algunos eventos del usuario con el controlador
  # como por ejemplo crear una vista para ver el perfil
  resources :usuario 
  
  

  get 'welcome/index'
  post "usuario/follow"
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
