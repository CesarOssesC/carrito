class PedidosController < ApplicationController

    before_action :validar_carro
    

    def crear
        @datos_envio = DatosEnvio.new
        @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
    end
    
    def pagar

    end

    def guardar
        
        @datos_envio = DatosEnvio.new(datos_envio_params)

        if destino_params[:destino_id].empty? == false
            
            if @datos_envio.save
                @pedido = Pedido.new(codigo: SecureRandom.hex(4).upcase, total: @carro.total, destino_id: destino_params[:destino_id], estados_pedido: EstadosPedido.first, datos_envio: @datos_envio)
                if @pedido.save
                    @carro.carros_contenidos.each do |contenido|
                        DetallesPedido.create(pedido: @pedido, producto: contenido.producto, cantidad: contenido.cantidad)
                    end
                    enviar_confirmacion_pedido
                    eliminar_carrito
                    
                    render :pagar
                else
                    @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
                    render :crear
                end
                
            else
                @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
                render :crear
            end

        else
            @datos_envio.errors.add(:destino_id, "Seleccione un destino")
            @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
            render :crear
        end
    end

    private

    def datos_envio_params
        params.require(:datos_envio).permit(:nombre, :direccion, :correo, :telefono)
    end

    def destino_params
        params.require(:datos_envio).permit(:destino_id)
    end

    def enviar_confirmacion_pedido
        ClienteMailer.with(datos_envio: @datos_envio, pedido_correo: @pedido).confirmacion_pedido.deliver_later
    end

    def eliminar_carrito
        session[:carro_id] = nil
        @carro.destroy
    end
    # def consultar_categorias
    #     @categorias = Categoria.select(:id, :categoria).order(categoria: :asc)
    # end
end
