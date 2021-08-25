class ProductosController < ApplicationController

    def index
        @lista_productos = Producto.includes(:categoria).select(:id, :nombre, :precio, :descripcion, :cantidad, :categoria_id).order(id: :asc)
    end

    def mostrar

    end

    def crear
        @producto_nuevo = Producto.new
        @categorias = Categoria.select(:id, :categoria).order(categoria: :asc)
    end

    def guardar
        
        @producto_nuevo = Producto.new(producto_params)
        
        if @producto_nuevo.save
            redirect_to action: :index
        else
            render :crear
        end
    end

    def editar
        @producto_nuevo = Producto.select(:id, :nombre, :precio, :descripcion, :cantidad, :categoria_id).order(id: :asc)
    end

    def actualizar

    end

    def eliminar

    end

    private

    def producto_params
        return params.require(:producto).permit(:nombre, :precio, :descripcion, :cantidad, :categoria_id, imagenes: [])
    end

end
