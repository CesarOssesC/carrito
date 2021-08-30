class CarrosContenido < ApplicationRecord

  before_save :actualizar_total

  belongs_to :carro
  belongs_to :producto
end



private

def actualizar_total
    self.carro.total = self.carro.productos.map{ |producto| producto.precio }.sum
    # self.carro.total = self.carro.productos.map(&:precio).sum
    self.carro.save
end