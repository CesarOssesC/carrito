Rails.application.routes.draw do
  get 'productos',            to: 'productos#index',      as: 'productos'
  get 'productos/crear',      to: 'productos#crear',      as: 'nuevo_producto'
  get 'productos/:id',        to: 'productos#mostrar',    as: 'producto'
  get 'productos/:id/editar', to: 'productos#editar',     as: 'editar_productos' 

  post 'productos/guardar',    to: 'productos#guardar'
  put 'productos/:id',         to: 'productos#actualizar'
  patch 'productos/:id',       to: 'productos#actualizar'
  delete 'productos/:id',      to: 'productos#eliminar'  

  get 'categorias',            to: 'categorias#index',      as: 'categorias'
  get 'categorias/crear',      to: 'categorias#crear',      as: 'nueva_categoria'
  get 'categorias/:id',        to: 'categorias#mostrar',    as: 'categoria'
  get 'categorias/:id/editar', to: 'categorias#editar',     as: 'editar_categorias'

  post 'categorias/guardar',    to: 'categorias#guardar'
  put 'categorias/:id',         to: 'categorias#actualizar'
  patch 'categorias/:id',       to: 'categorias#actualizar'
  delete 'categorias/:id',      to: 'categorias#eliminar'   
  #delete especial para borrar sólo una foto
  delete 'productos/:id/imagenes/:id_imagen',  to: 'productos#eliminar_foto',  as: 'eliminar_foto'



end
