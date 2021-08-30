class CarrosController < ApplicationController
    before_action :validar_carro

    #post
    def agregar_producto
        @carro.productos << Producto.find(params[:producto_id])
        redirect_to root_path
    end
end
