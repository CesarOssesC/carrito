class Admin::PedidosController < Admin::AdminController
    
    include Admin::PedidosHelper

    before_action :asignar_pedido, only: [:mostrar, :editar, :actualizar, :aumentar_cantidad_producto, :disminuir_cantidad_producto, :eliminar_producto]

    def listar
        @lista_pedidos = Pedido.select(:id, :codigo, :total, :created_at).order(created_at: :desc)
    end

    def mostrar
        # TODO mostar un pedido con todos los productos
    end

    def crear
        # TODO mostrar formulario para crear pedido
    end

    def editar
        # TODO editar pediddo existente
        @datos_pedido = PedidosFormulario.new
        @datos_pedido.id = @pedido.id
        @datos_pedido.nombre = @pedido.datos_envio.nombre
        @datos_pedido.correo = @pedido.datos_envio.correo
        @datos_pedido.telefono = @pedido.datos_envio.telefono
        @datos_pedido.direccion = @pedido.datos_envio.direccion
        @datos_pedido.destino_id = @pedido.destino_id
        @datos_pedido.estado_id = @pedido.estados_pedido.id
        @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
        @estados_pedidos = EstadosPedido.select(:id, :estado).order(id: :asc)
        @productos = @pedido.detalles_pedidos

    end

    def guardar

    end

    def actualizar
        @datos_pedido = PedidosFormulario.new(params_pedidos)
        if @datos_pedido.valid?
            @pedido.datos_envio.nombre = @datos_pedido.nombre
            @pedido.datos_envio.correo = @datos_pedido.correo
            @pedido.datos_envio.telefono = @datos_pedido.telefono
            @pedido.datos_envio.direccion = @datos_pedido.direccion
            @pedido.destino = Destino.find(@datos_pedido.destino_id)
            @pedido.estados_pedido = EstadosPedido.find(@datos_pedido.estado_id)

            if @pedido.datos_envio.save and @pedido.save
                redirect_to action: :mostrar
            else
                @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
                @estados_pedidos = EstadosPedido.select(:id, :estado).order(id: :asc)
                render :editar
            end
            
        else
            @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
            @estados_pedidos = EstadosPedido.select(:id, :estado).order(id: :asc)
            render :editar
        end
    end

    def eliminar
        #TODO analizar si vale la pena
    end

    def aumentar_cantidad_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        detalle_pedido.cantidad += 1
        detalle_pedido.save

        redirect_to action: :editar
    end

    def disminuir_cantidad_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        if detalle_pedido.cantidad - 1 <= 0
            detalle_pedido.destroy
        else
            detalle_pedido.cantidad -= 1
            detalle_pedido.save
        end

        redirect_to action: :editar
    end

    def eliminar_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        detalle_pedido.destroy

        redirect_to action: :editar
    end

    private

    def params_pedidos
        params.require(:admin_pedidos_helper_pedidos_formulario).permit(:nombre, :correo, :telefono, :direccion, :destino_id, :estado_id)
    end

    def asignar_pedido
        @pedido = Pedido.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:errors] = "Pedido no encontrado"
        redirect_to action: :listar
    end
end
