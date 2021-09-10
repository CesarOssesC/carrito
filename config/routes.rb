Rails.application.routes.draw do
  root 'paginas#inicio'
  get 'carrito',          to: 'paginas#carro',          as: 'carrito'

  

  #carros
  post 'carros/:producto_id',             to: 'carros#agregar_producto',        as: 'agregar_producto'
  put 'carros/:producto_id/cantidad',    to: 'carros#aumentar_un_producto',    as: 'aumentar_producto'
  delete 'carros/:id_producto',           to: 'carros#eliminar_producto',       as:'eliminar_producto'
  delete 'carros/:id_producto/cantidad',  to: 'carros#disminuir_un_producto',   as:'disminuir_producto'
  
  
  get 'productos',            to: 'productos#index',      as: 'productos'
  get 'productos/crear',      to: 'productos#crear',      as: 'nuevo_producto'
  get 'productos/:id',        to: 'productos#mostrar',    as: 'producto'
  get 'productos/:id/editar', to: 'productos#editar',     as: 'editar_productos' 

  post 'productos/guardar',    to: 'productos#guardar'
  put 'productos/:id',         to: 'productos#actualizar'
  patch 'productos/:id',       to: 'productos#actualizar'
  #delete 'productos/:id',      to: 'productos#eliminar'  no lo utilizamos por la razon explicada en el controlador.

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

  get 'destinos',             to: 'destinos#listar',     as: 'destinos'
  get 'destinos/crear',       to: 'destinos#crear',      as: 'nuevo_destino'
  get 'destinos/:id',         to: 'destinos#mostrar',    as: 'destino'
  get 'destinos/:id/editar',  to: 'destinos#editar',     as: 'editar_destinos'

  post 'destinos/guardar',    to: 'destinos#guardar'
  put 'destinos/:id',         to: 'destinos#actualizar'
  patch 'destinos/:id',       to: 'destinos#actualizar'
  delete 'destinos/:id',      to: 'destinos#eliminar'


  get 'pedidos',                    to: 'pedidos#crear',            as: 'nuevo_pedido'
  get 'pagar',                      to: 'pedidos#pagar',            as: 'pagar'
  get 'pedidos/lista_pedidos',      to: 'pedidos#lista_pedidos',    as: 'lista_pedidos'
  get 'pedidos/detalles_pedidos',   to: 'pedidos#detalles_pedidos', as: 'detalles_pedidos' 

  post 'pedidos',             to: 'pedidos#guardar',    as: 'crear_pedido_cliente'

end
