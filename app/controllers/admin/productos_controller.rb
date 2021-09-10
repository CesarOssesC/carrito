class Admin::ProductosController < Admin::AdminController

    include ProductosHelper

    before_action :asignar_producto, only: [:mostrar, :editar, :actualizar, :eliminar, :eliminar_foto]

    def index
        @lista_productos = Producto.includes(:categoria).select(:id, :nombre, :precio, :descripcion, :cantidad, :categoria_id, :estados_producto_id).order(id: :asc).where("estados_producto_id = 1")
        @lista_productos_inactivos = Producto.includes(:categoria).select(:id, :nombre, :precio, :descripcion, :cantidad, :categoria_id, :estados_producto_id).order(id: :asc).where("estados_producto_id = 2")
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
        @producto_nuevo.estados_producto = evaluar_estado(params_estado_producto)
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
            actualizar_estado(params_estado_producto, @producto_nuevo)
            redirect_to admin_producto_path(@producto_nuevo)
        else
            consultar_categorias
            render :editar
        end
    end

    #Este metodo lo utilizamos al comienzo, pero luego cambiamos la lógica y decidimos activar o desactivar en vez de eliminar.
    # def eliminar
    #     @producto_nuevo.estados_producto = EstadosProducto.find_by(estado: 'inactivo')
    #     @producto_nuevo.save
    #     redirect_to action: :index
    # end

    def eliminar_foto
        @producto_nuevo.imagenes.find(params[:id_imagen]).purge
        redirect_to admin_editar_productos_path(@producto_nuevo)
    end

    private

    def asignar_producto
        @producto_nuevo = Producto.includes(:estados_producto, :categoria).find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to action: :index
    end

    def producto_params
        return params.require(:producto).permit(:nombre, :precio, :descripcion, :cantidad, :categoria_id, imagenes: [])
    end

    def params_estado_producto
        params.require(:producto).permit(:estados_producto_id)[:estados_producto_id]
    end

    def consultar_categorias
        @categorias = Categoria.select(:id, :categoria).order(categoria: :asc)
    end

end
