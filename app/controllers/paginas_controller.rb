class PaginasController < ApplicationController
    
    before_action :validar_carro
    

    def inicio
        
        @todos_los_productos = Producto.select(:id, :nombre, :descripcion, :precio, :cantidad).order(nombre: :asc)
    end
    
    def Carro
        
    end
    
    private

        

end
