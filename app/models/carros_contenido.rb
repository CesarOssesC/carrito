class CarrosContenido < ApplicationRecord

  after_save :actualizar_total
  after_destroy :actualizar_total

  belongs_to :carro
  belongs_to :producto
  
  
  
  private
  
  def actualizar_total
    
    carro = self.carro
    subtotal = 0
    carro.carros_contenidos.each do |contenido|
      subtotal += contenido.cantidad * contenido.producto.precio
    end
    carro.total = subtotal
    
    # self.carro.total = self.carro.productos.map(&:precio).sum
    carro.save
  end

end