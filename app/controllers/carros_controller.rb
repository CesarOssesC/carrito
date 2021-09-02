class CarrosController < ApplicationController
    before_action :validar_carro

    #post
    def agregar_producto
        # @carro.productos << Producto.find(params[:producto_id])
        #la forma anterior no nos acomodaba a lo que queremos asique haremos otra forma.
        
        producto_para_agregar = Producto.find(params[:producto_id])
        contenido_carrito = @carro.carros_contenidos.find_by(producto: producto_para_agregar)
        if contenido_carrito
            contenido_carrito.cantidad += 1
        else
            contenido_carrito = CarrosContenido.new(carro: @carro, producto: producto_para_agregar, cantidad:1)
        end
        contenido_carrito.save
        redirect_to root_path
    end

    def eliminar_producto
        @carro.carros_contenidos.find_by(producto_id: params[:id_producto]).destroy
        redirect_to carrito_path
    end

    def aumentar_un_producto
        producto_para_agregar = Producto.find(params[:producto_id])
        contenido_carrito = @carro.carros_contenidos.find_by(producto: producto_para_agregar)
        contenido_carrito.cantidad += 1
        contenido_carrito.save
        redirect_to carrito_path
    end

    def disminuir_un_producto
        contenido = @carro.carros_contenidos.find_by(producto_id: params[:id_producto])
        if contenido.cantidad - 1 <= 0
            contenido.destroy
        else
            contenido.cantidad -= 1
            contenido.save
        end
        redirect_to carrito_path
    end
end
