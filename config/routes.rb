Rails.application.routes.draw do
  get 'productos',            to: 'productos#index',      as: 'productos'
  get 'productos/crear',      to: 'productos#crear'
  get 'productos/:id',        to: 'prodcutos#mostrar'
  get 'productos/:id/editar', to: 'productos#editar'

  post 'productos/guardar',    to: 'productos#guardar'
  put 'productos/:id',         to: 'productos#actualizar'
  patch 'productos/:id',       to: 'productos#actualizar'
  delete 'productos/:id',      to: 'productos#eliminar'

  get 'categorias',            to: 'categorias#index',      as: 'categorias'
  get 'categorias/crear',      to: 'categorias#crear'
  get 'categorias/:id',        to: 'categorias#mostrar'
  get 'categorias/:id/editar', to: 'categorias#editar',      as: 'editar_categorias'

  post 'categorias/guardar',    to: 'categorias#guardar'
  put 'categorias/:id',         to: 'categorias#actualizar'
  patch 'categorias/:id',       to: 'categorias#actualizar'
  delete 'categorias/:id',      to: 'categorias#eliminar',   as: 'eliminar_categorias'




end
