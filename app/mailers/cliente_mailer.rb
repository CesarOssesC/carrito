class ClienteMailer < ApplicationMailer
    
    def confirmacion_pedido
        @datos_envio = params[:datos_envio]
        @pedido = params[:pedido_correo]
        mail(
            to: @datos_envio.correo,
            subject: 'Confirmación de pedido'
        )
    end

end
