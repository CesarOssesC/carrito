module ProductosHelper
    
    def actualizar_estado(valor_check, producto_nuevo)
        if valor_check == "0"
        producto_nuevo.estados_producto = EstadosProducto.find_by(estado: "inactivo")
        else
        producto_nuevo.estados_producto = EstadosProducto.find_by(estado: "activo")
        end
        producto_nuevo.save
    end

    def evaluar_estado(valor_check)
  if valor_check == "0"
    EstadosProducto.find_by(estado: "inactivo")
  else
    EstadosProducto.find_by(estado: "activo")
  end
  
end
end
