class Carro < ApplicationRecord
    has_many :carros_contenidos
    has_many :producto, through: :carros_contenidos
end
