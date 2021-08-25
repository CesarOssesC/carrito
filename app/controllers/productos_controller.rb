class ProductosController < ApplicationController

    def index

    end

    def mostrar

    end

    def crear
        @producto_nuevo = Producto.new
    end

    def guardar
        
        @producto_nuevo = Producto.new(producto_params)
        
        if @producto_nuevo.save
            redirect_to action: "index"
        else
            render :crear
        end
    end

    def editar
        @producto_nuevo = Producto.select(:id, :nombre, :precio, :descripcion, :cantidad).order(id: :asc)
    end

    def actualizar

    end

    def eliminar

    end

    private

    def producto_params
        return params.require(:producto).permit(:id, :nombre, :precio, :descripcion, :cantidad)
    end

end
