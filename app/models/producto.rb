class Producto < ApplicationRecord
  belongs_to :categoria
  has_many_attached :imagenes
end
