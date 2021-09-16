class Admin::PedidosController < Admin::AdminController
    
    include Admin::PedidosHelper

    before_action :asignar_pedido, only: [:mostrar, :editar, :actualizar, :aumentar_cantidad_producto, :disminuir_cantidad_producto, :eliminar_producto, :agregar_producto, :guardar_producto]

    def listar
        @lista_pedidos = Pedido.select(:id, :codigo, :total, :created_at, :estados_pedido_id).order(created_at: :desc)
    end

    def mostrar
        
    end

    def crear
        @pedido = Pedido.new
        @pedido.codigo = SecureRandom.hex(4).upcase
        @pedido.total = 0
        @pedido.estados_pedido = EstadosPedido.find_by(estado: "Solicitado")
        @pedido.destino = Destino.find_by(nombre: 'Sin Destino')
        @pedido.datos_envio = DatosEnvio.create(
            nombre: 'Ingrese Nombre',
            telefono: 'Ingrese un teléfono',
            direccion: 'Ingrese dirección',
            correo: 'Ingrese un correo',
        )
        @pedido.save
        redirect_to admin_editar_pedido_path(@pedido)
        
    end

    def editar
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

    def agregar_producto
        @todos_los_productos = Producto.select(:id, :nombre, :descripcion, :precio, :cantidad, :estados_producto_id).order(nombre: :asc).where("estados_producto_id = 1 and cantidad > 0")
    end

    def guardar_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        if detalle_pedido
            detalle_pedido.cantidad += 1
        else
        detalle_pedido = DetallesPedido.new(
            pedido: @pedido,
            producto_id: params[:id_producto],
            cantidad: 1,
        )
        end
        detalle_pedido.save
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
