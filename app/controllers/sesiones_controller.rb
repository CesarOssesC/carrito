class SesionesController < ApplicationController
    

    #post
    def iniciar_sesion
    #nombre_usuario_formulario = params[:nombre_usuario]
    @usuario_actual = Administrador.find_by(correo: sesion_params[:correo])
        if @usuario_actual
            if @usuario_actual.authenticate(sesion_params[:password])
                session[:usuario_id] = @usuario_actual.id
                redirect_to admin_pedidos_path
                
            else
                flash[:error_sesion] = "Correo o contraseña inválidos"
                redirect_to root_path
            end
        else
            flash[:error_sesion] = "Usuario no registrado"
            redirect_to root_path   

        end
    end

    #delete
    def cerrar_sesion
    session[:usuario_id] = nil 
    redirect_to root_path
    end


    private

    def sesion_params
        params.permit(:correo, :password)
    end
end
