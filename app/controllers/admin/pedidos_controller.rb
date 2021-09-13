class Admin::PedidosController < Admin::AdminController
    
    include Admin::PedidosHelper

    before_action :asignar_pedido, only: [:mostrar, :editar, :actualizar]

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
        @destinos = Destino.select(:id, :nombre).order(nombre: :asc)

    end

    def guardar

    end

    def actualizar

    end

    def eliminar
        #TODO analizar si vale la pena
    end

    private

    def params_pedidos

    end

    def asignar_pedido
        @pedido = Pedido.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:errors] = "Pedido no encontrado"
        redirect_to action: :listar
    end
end
