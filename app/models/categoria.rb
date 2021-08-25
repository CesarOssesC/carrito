class Categoria < ApplicationRecord
    has_many :productos
    validates(:categoria, uniqueness: true)
end
