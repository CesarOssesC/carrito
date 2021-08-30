class PaginasController < ApplicationController
    
    before_action :validar_carro
    
    def inicio
        @todos_los_productos = Producto.select(:id, :nombre, :descripcion, :precio).order(nombre: :asc)
    end

    def Carro
        
    end

end
