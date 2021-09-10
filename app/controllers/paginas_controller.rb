class PaginasController < ApplicationController
    
    before_action :validar_carro
    

    def inicio
        @todos_los_productos = Producto.select(:id, :nombre, :descripcion, :precio, :cantidad, :estados_producto_id).order(nombre: :asc).where("estados_producto_id = 1 and cantidad > 0")
    end
    
    def Carro
        
    end
    
    private

        

end
