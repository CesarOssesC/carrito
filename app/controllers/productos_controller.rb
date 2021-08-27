class ProductosController < ApplicationController

    before_action :asignar_producto, only: [:mostrar, :editar, :actualizar, :eliminar, :eliminar_foto]

    def index
        @lista_productos = Producto.includes(:categoria).select(:id, :nombre, :precio, :descripcion, :cantidad, :categoria_id).order(id: :asc)
    end

    def mostrar
        @columnas = case(@producto_nuevo.imagenes.count)
        when 0
            "col-12"
        when 1
            "col-10"
        when 2
            "col-6"
        when 3
            "col-4"
        when 4
            "col-3"
        end
    end

    def crear
        @producto_nuevo = Producto.new
        consultar_categorias
    end

    def guardar
        
        @producto_nuevo = Producto.new(producto_params)
        
        if @producto_nuevo.save
            redirect_to action: :index
        else
            consultar_categorias
            render :crear
        end
    end

    def editar
        consultar_categorias
    end

    def actualizar
        if @producto_nuevo.update(producto_params)
            redirect_to producto_path(@producto_nuevo)
        else
            consultar_categorias
            render :editar
        end
    end

    def eliminar
        @producto_nuevo.destroy
        redirect_to action: :index
    end

    def eliminar_foto
        @producto_nuevo.imagenes.find(params[:id_imagen]).purge
        redirect_to editar_productos_path(@producto_nuevo)
    end

    private

    def asignar_producto
        @producto_nuevo = Producto.find(params[:id])
    end

    def producto_params
        return params.require(:producto).permit(:nombre, :precio, :descripcion, :cantidad, :categoria_id, imagenes: [])
    end

    def consultar_categorias
        @categorias = Categoria.select(:id, :categoria).order(categoria: :asc)
    end

end
