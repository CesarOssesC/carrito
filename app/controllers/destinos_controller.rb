class DestinosController < ApplicationController
    
    before_action :asignar_destino, only: [:mostrar, :editar, :actualizar, :eliminar]

    def listar
        @destinos = Destino.select(:id, :nombre)
    end

    def crear
        @destino = Destino.new
        consultar_regiones
    end

    def guardar
        @destino = Destino.new(destino_params)
        if @destino.save
            redirect_to action: :listar
        else
            consultar_regiones
            render :crear
        end
    end

    def mostrar

    end

    def editar
        consultar_regiones
        
    end

    def actualizar
        if @destino.update(destino_params)
            redirect_to action: :listar
        else
            consultar_regiones
            render :editar
        end
    end

    def eliminar
        @destino.destroy
        redirect_to destinos_path
    end

    private

    def destino_params
        params.require(:destino).permit(:nombre, :region_id)
    end

    def asignar_destino
        @destino = Destino.find(params[:id])
    end

    def consultar_regiones
        @regiones = Region.select(:id, :nombre).order(id: :asc)
    end

end
