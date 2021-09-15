module Admin::PedidosHelper
    class PedidosFormulario
      
      include ActiveModel::Model
      attr_accessor(:id, :nombre, :correo, :direccion, :telefono, :destino_id, :estado_id)
      validates(:nombre, presence: true)
      validates(:direccion, presence: true)
      validates(:correo, presence: true)
      validates(:telefono, presence: true)
      validates(:destino_id, presence: true)
      

      def persisted?
        id != nil
      end

      
    end

    # def crear_datos_envio(pedido)
    #     DatosEnvio.create(
    #         nombre: datos_formulario.nombre,
    #         direccion: datos_formulario.direccion,
    #         telefono: datos_formulario.telefono,
    #         correo: datos_formulario.correo
    #     )
    # end

    # def definir_pedido(total, pedido, datos_envio)
    #     Pedido.new( 
    #         total: total, 
    #         destino_id: datos_formulario.destino_id,
    #         estados_pedido: EstadosPedido.find_by(estado: 'solicitando'), 
    #         datos_envio: datos_envio
    #     )
    # end

    # def migrar_productos(carro, pedido)
    #     carro.carros_contenidos.each do |contenido|
    #         DetallesPedido.create(
    #             pedido: pedido, 
    #             producto: contenido.producto, 
    #             cantidad: contenido.cantidad
    #         )
    #     end
    # end
  
end
