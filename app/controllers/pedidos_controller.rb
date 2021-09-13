class PedidosController < ApplicationController

    include PedidosHelper

    layout 'application', only: [:lista_pedidos, :detalles_pedidos]
    # en vez de hacer un layout especial para un controlador
    # podemos llamar a otro usando
    # layout 'paginas'

    before_action :validar_carro
    before_action :validar_productos_carro, only: :crear

    def crear
        @datos_formulario = DatosEnvioFormulario.new
        consultar_destinos
    end
    
    def pagar

    end

    def guardar
        @datos_formulario = DatosEnvioFormulario.new(params_datos_formulario)
        if @datos_formulario.valid? 
            @datos_envio = crear_datos_envio(@datos_formulario)
            @pedido = definir_pedido(
                @carro.total,
                @datos_formulario,
                @datos_envio
            )
            if @pedido.save
                migrar_productos(@carro, @pedido)
                enviar_confirmacion_pedido
                eliminar_carrito
                render :pagar
            else
                consultar_destinos
                render :crear
            end
        else
            # @datos_envio.valid?
            # @datos_envio.errors.add(:destino_id, "Seleccione un destino")
            consultar_destinos
            render :crear
        end
    end
    
    def lista_pedidos
        @lista_pedidos = Pedido.select(:created_at, :codigo, :total).order(created_at: :desc)
    end

    def detalles_pedidos
    end

    def eliminar_pedidos
        
    end
    

    private

    def params_datos_formulario
        params.require(:pedidos_helper_datos_envio_formulario).permit(:nombre, :direccion, :correo, :telefono, :destino_id)
    end

    def enviar_confirmacion_pedido
        ClienteMailer.with(datos_envio: @datos_envio, pedido_correo: @pedido).confirmacion_pedido.deliver_later
    end
    
    def eliminar_carrito
        session[:carro_id] = nil
        @carro.destroy
    end
    
    def consultar_destinos
        @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
    end

    def validar_productos_carro
        if @carro.productos.count.zero?
            redirect_to root_path
        end
    end

    # primera versión del controlador
    # def datos_envio_params
    #     params.require(:pedidos_helper_datos_envio_formulario).permit(:nombre, :direccion, :correo, :telefono)
    # end

    # def destino_params
    #     params.require(:pedidos_helper_datos_envio_formulario).permit(:destino_id)
    # end
    # def consultar_categorias
    #     @categorias = Categoria.select(:id, :categoria).order(categoria: :asc)
    # end
end
